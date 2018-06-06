package ui.alerts
{
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ui.bitmap.BitmapScale9Grid;
	
	/**
	 * アラートクラス.
	 * メッセージ、タイトル、ボタン（「OK」、「キャンセル」の任意の組み合わせ）を含むことができるポップアップダイアログボックス。Alert コントロールはモーダル。
	 * ハンター専用の実装。
	 * Alert.Show()で自動的にアラートポップアップを表示します
	 * 閉じたとき、CloseEventを引数としたコールバックが登録されている場合は呼び出されます
	 *
	 * @author ogino
	 */
	public class Alert extends AlertPanel
	{
		
		//-----------------------------------------------------
		//クラス定数
		//-----------------------------------------------------			
		
		/**
		 * flags パラメーター（show() メソッドのパラメーター）として渡されたときに、Alert コントロールの「キャンセル」ボタンを有効にする値です。 | 演算子を使用すると、このビットフラグを OK、YES、NO および NONMODAL フラグと組み合わせることができます。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static const CANCEL:uint = 0x0008;
		
		/**
		 * flags パラメーター（show() メソッドのパラメーター）として渡されたときに、Alert コントロールの「OK」ボタンを有効にする値です。 | 演算子を使用すると、このビットフラグを CANCEL、YES、NO および NONMODAL フラグと組み合わせることができます。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static const OK:uint = 0x0004;
		
		//-----------------------------------------------------
		//コンストラクタ
		//-----------------------------------------------------			
		
		/**
		 * Alert コントロールをポップアップする静的メソッドです。Alert コントロールは、ユーザーがこのコントロールのボタンを選択したときに閉じます。
		 *
		 * @param	text	Alert コントロールに表示されるテキストストリングです。このテキストは警告ダイアログボックスの中央に配置されます。
		 * @param	title	タイトルバーに表示されるテキストストリングです。このテキストは左揃えされます。
		 * @param	flags	Alert コントロールに配置するボタンを指定します。 有効な値は、Alert.OK、Alert.CANCELです。 デフォルト値は Alert.OK です。 複数のボタンを表示する場合は、ビット単位の OR 演算子を使用します。 例えば、(Alert.OK | Alert.CANCEL) を渡すと「ＯＫ」「キャンセル」ボタンが表示されます。「キャンセル」「ＯＫ」の順でボタンを表示する場合は ~(Alert.OK | Alert.CANCEL) と指定してください。
		 * @param	closeHandler	Alert コントロール上の任意のボタンが押されたときに呼び出されるイベントハンドラーです。 このハンドラーに渡されるイベントオブジェクトは、CloseEvent のインスタンスです。このオブジェクトの detail プロパティには、値 Alert.OK、Alert.CANCELが含まれます。
		 * @return	Alert コントロールへの参照です。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static function show(text:String = "", title:String = "", flags:int = 4, closeHandler:Function = null):Alert
		{	
			var alert:Alert = new Alert();
			alert.titleLabel.text = title;
			alert.detailLabel.text = text;
			
			alert.callBackHandler = closeHandler;
			alert.setBtn(flags);
			alert.invalidateDisplayList();
			
			alert.showPopup();
			return alert;
		}
		
		/**
		 * Alert のボタンラベルを自由に変えられるshowメソッドの改良版
		 *
		 * @param	text	Alert コントロールに表示されるテキストストリングです。このテキストは警告ダイアログボックスの中央に配置されます。
		 * @param	title	タイトルバーに表示されるテキストストリングです。このテキストは左揃えされます。
		 * @param	flags	Alert コントロールに配置するボタンを指定します。 有効な値は、Alert.OK、Alert.CANCELです。 デフォルト値は Alert.OK です。 複数のボタンを表示する場合は、ビット単位の OR 演算子を使用します。 例えば、(Alert.OK | Alert.CANCEL) を渡すと「ＯＫ」「キャンセル」ボタンが表示されます。「キャンセル」「ＯＫ」の順でボタンを表示する場合は ~(Alert.OK | Alert.CANCEL) と指定してください。
		 * @param	closeHandler	Alert コントロール上の任意のボタンが押されたときに呼び出されるイベントハンドラーです。 このハンドラーに渡されるイベントオブジェクトは、CloseEvent のインスタンスです。このオブジェクトの detail プロパティには、値 Alert.OK、Alert.CANCELが含まれます。
		 * @return	Alert コントロールへの参照です。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static function showOriginalAlert(text:String = "", title:String = "", flags:int = 4, closeHandler:Function = null, okLabel:String = "", cancelLabel:String = ""):Alert
		{	
			var alert:Alert = new Alert();
			alert.titleLabel.text = title;
			alert.detailLabel.text = text;
			
			alert.callBackHandler = closeHandler;
			alert.setBtn(flags);
			alert.invalidateDisplayList();
			
			if (okLabel.length && cancelLabel.length)
			{
				alert.okBtn.setLabelLinkage(okLabel);
				alert.cancelBtn.setLabelLinkage(cancelLabel);
			}
			
			alert.showPopup();
			return alert;
		}
		
		//-----------------------------------------------------
		//コンストラクタ
		//-----------------------------------------------------			
		
		/**
		 * コンストラクタ
		 */
		public function Alert()
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
			var bgbd:BitmapData = LinkageUtility.createBitmapData("common_9grid_f");
			var bg:BitmapScale9Grid = new BitmapScale9Grid(bgbd, new Rectangle(4, 4, 81, 81));
			bg.setSize(600, 190);
			DisplayUtility.addChildSetPosition(this, bg, 0, 0);
			
			var frame:BitmapData = LinkageUtility.createBitmapData("common_9grid_a");
			var ff:BitmapScale9Grid = new BitmapScale9Grid(frame, new Rectangle(18, 29, 43, 43));
			ff.setSize(600, 190);
			DisplayUtility.addChildSetPosition(this, ff, 0, 0);
			
			super.init();
			
			okBtn.setButtonSkin("common_btn_skin_a_link_240x40");
			okBtn.setLabelLinkage("common_btn_b_txt_a40_ok");
			cancelBtn.setButtonSkin("common_btn_skin_b_link_240x40");
			cancelBtn.setLabelLinkage("common_btn_b_txt_a40_cancel");
		}
	}

}