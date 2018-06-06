package utils 
{
	
	import com.flashdynamix.motion.Tweensy;
	import core.utils.DisplayUtility;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.components.UIComponents;
	
	/**
	 * ポップアップマネージャークラス.
	 * 複数表示するとバグが発生するので、このマネージャーから生成するポップアップは一つだけにしてください
	 * 
	 * @author kei kato
	 */
	public class PopupManager 
	{	
		/**
		 * 保持しているポップアップオブジェクトの配列
		 * {popup:ポップアップするMC , parent:ポップアップを配置しているコンテナ ,backShadow:背景の黒}
		 */
		private static var _popupList:Array;
		
		/** 背景色 */
		private static var backShadow:Sprite = new Sprite();	
		
		/**
		 * ポップアップ表示
		 * 
		 * @param	popup 追加するポップアップ
		 * @param	parent ポップアップを配置するコンテナ
		 * @param   isBackClickClose 背景の黒いのを押したらクローズするか
		 * @param   closeCallBack 閉じたときのイベントハンドラー
		 */
		public static function addPopup(popup:UIComponents, parent:DisplayObjectContainer, isBackClickClose:Boolean=false, closeCallBack:Function=null):void
		{			
			if (!parent) return;
			
			var g:Graphics = backShadow.graphics;
			g.clear();
			g.beginFill(0x000000, .5);
			g.drawRect(0, 0, 960, 560);
			
			if (_popupList == null) _popupList = [];
			
			var s:Sprite = new Sprite();
			s.addChild(popup);
			
			var pupupObject:Object = {popup:popup, parent:parent, closeCallBack:closeCallBack};
			_popupList.push( pupupObject );
			showPopup(s, parent, isBackClickClose);
		}
		
		/**
		 * ポップアップの削除
		 */
		public static function removePopup(popup:UIComponents):void 
		{
			var cnt:uint = 0;
			
			for each(var obj:Object in _popupList) 
			{
				if (obj.popup == popup) 
				{
					hidePopup(obj.popup, obj.parent, obj.closeCallBack);
					_popupList.splice(cnt, 1);
					popup.dispatchEvent(new Event(Event.COMPLETE));
					break;
				}
				
				cnt++;	
			}	
		}
		
		/**
		 * ポップアップが存在するかどうかを確認
		 * @author	qwang
		 * @since	2015-08-11
		 */
		public static function checkPopup(popup:UIComponents):Boolean
		{
			var cnt:uint = 0;
			
			for each(var obj:Object in _popupList) 
			{
				if (obj.popup == popup) 
				{
					return true;
				}
				
				cnt++;	
			}
			
			return false;
		}
		
		/**
		 * ポップアップをセンタリング表示
		 * 
		 * @param displayObject
		 */
		public static function center(displayObject:DisplayObject):void 
		{
			displayObject.x = Math.round((960 - displayObject.width) >> 1);
			displayObject.y = Math.round((560 - displayObject.height) >> 1);
		}			
		
		/**
		 * ポップアップの表示
		 * 
		 * @param popup
		 * @param parent
		 * @param isBackClickClose
		 */
		private static function showPopup(popup:Sprite, parent:DisplayObjectContainer, isBackClickClose:Boolean):void
		{	
			popup.scaleX = popup.scaleY = 1;
			
			// 一旦センタリング表示
			center(popup);
			
			var baceX:Number = popup.x;
			var baceY:Number = popup.y;			
			
			popup.alpha = 1;
			//popup.scaleX = popup.scaleY = .5;
			popup.scaleX = popup.scaleY = .85;
			center(popup);
			
			parent.addChild(backShadow);
			parent.addChild(popup);
			
			Tweensy.to(popup, { scaleX:1, scaleY:1, x:baceX, y:baceY }, 0.25 );
			
			if (!backShadow.hasEventListener(MouseEvent.CLICK) && isBackClickClose)
				backShadow.addEventListener(MouseEvent.CLICK, onBackClick);
		}		
		
		/**
		 * ポップアップの子を削除
		 * 
		 * @param	parent
		 */
		private static function removePopupChild(parent:DisplayObjectContainer):void 
		{
			var cnt:uint = 0;
			
			for each(var obj:Object in _popupList) 
			{
				if (obj.parent == parent)
				{
					hidePopup(obj.popup, obj.parent, obj.closeCallBack);
					_popupList.splice(cnt, 1);
					break;
				}
				cnt++;
			}
			
		}
		
		/**
		 * ポップアップの削除
		 * 
		 * @param pupup
		 * @param parent
		 * @param closeCallBack
		 */
		private static function hidePopup(popup:UIComponents, parent:DisplayObjectContainer, closeCallBack:Function = null):void 
		{
			backShadow.removeEventListener(MouseEvent.CLICK, onBackClick);
			
			var s:Sprite = Sprite(popup.parent);
			
			var ui:Shape = new Shape();
			var g:Graphics = ui.graphics;
			g.beginFill(0x000000);
			g.drawRect(0, 0, s.width, s.height)
			g.endFill();
			//ui.scaleX = ui.scaleY = 0.2;
			ui.scaleX = ui.scaleY = 0.85;
			center(ui);
			
			var baceX:Number = ui.x;
			var baceY:Number = ui.y;
			var to:Object = { x:baceX, y:baceY, scaleX:ui.scaleX, scaleY:ui.scaleY, alpha:0 };
			
			//Tweensy.to(s, to, 0.5, null, 0, null, 
			//Tweensy.to(s, to, 0.25, null, 0, null, 
			Tweensy.to(s, to, 0, null, 0, null, 
				function():void 
				{
					removeDisplayObject(popup);
					removeDisplayObject(s);
					removeDisplayObject(backShadow);
					
					if (closeCallBack != null) closeCallBack();
				}
			);
		}
		
		/**
		 * 画面から削除
		 * 
		 * @param	content
		 */
		private static function removeDisplayObject(content:DisplayObject):void 
		{
			DisplayUtility.removeChild(content);
		}		
		
		/**
		 * 背景をクリック
		 * 
		 * @param e
		 */
		private static function onBackClick(e:MouseEvent):void 
		{
			removePopupChild(e.currentTarget.parent);	
		}
	}

}