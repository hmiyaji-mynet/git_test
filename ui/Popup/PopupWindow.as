package ui.Popup 
{
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import ui.button.LinkageButton;
	import ui.components.UIComponents;
	import utils.PopupManager;
	test1
	test2
	test3
	test4
	test5
	test6
	
	/**
	 * ポップアップWindowの背景とタイトルとボタンをセットしたクラス
	 * 基本継承して使うこと
	 * 
	 * @since		2015-09-10
	 * @author		qwang
	 * @copyright	(C)2015 CROOZ ALL Rights
	 */
	public class PopupWindow extends UIComponents
	{
		//-----------------------------------------------------
		//コンポーネント
		//-----------------------------------------------------	
		
		/** ポップ背景 */
		protected var popupBg:Bitmap;
		
		/** タイトルラベル */
		protected var titleLabel:Bitmap;
		
		/** クローズボタン */
		protected var closeButton:LinkageButton;
		
		//-----------------------------------------------------
		//プロパティ
		//-----------------------------------------------------	
		
		/** ポップアップ中かどうか */
		protected var isPopup:Boolean = false;
		
		//-----------------------------------------------------
		//コンストラクタ
		//-----------------------------------------------------			
		
		/**
		 * コンストラクタ
		 */
		public function PopupWindow() 
		{
			super();
		}
		
		//-----------------------------------------------------
		//オーバーライドしたメソッド
		//-----------------------------------------------------			
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			popupBg = LinkageUtility.createBitmap("common_popup");
			closeButton = new LinkageButton();
			closeButton.setButtonSkin("common_btn_30x30_tojiru");
			closeButton.setSize(30, 30);
			closeButton.addEventListener(MouseEvent.CLICK, pupopCloaseHanler);
			
			DisplayUtility.addChildSetPosition(this, popupBg, 0, 0);
			DisplayUtility.addChildSetPosition(this, closeButton, 820, 10);
		}
		
		//-----------------------------------------------------
		//メソッド
		//-----------------------------------------------------	
		
		public function addViewToPopup(parent:DisplayObjectContainer):void
		{
			if (!isPopup)
			{
				PopupManager.addPopup(this, parent);
				isPopup = true;
			}
		}
		
		public function removeViewToPopup():void
		{
			PopupManager.removePopup(this);
			isPopup = false;
		}
		
		//-----------------------------------------------------
		//イベントハンドラー
		//-----------------------------------------------------			
		
		/**
		 * ポップアップを閉じるイベント
		 * @param	e
		 */
		protected function pupopCloaseHanler(e:MouseEvent):void
		{
			removeViewToPopup();
		}
	}

}