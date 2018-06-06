package ui.inputForms 
{
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import ui.bitmap.BitmapScale9Grid;
	import ui.inputForms.InputFormPanel;
	
	/**
	 * 入力フォームクラス.
	 * タイトル、入力エリア、ボタン（「OK」、「キャンセル」の任意の組み合わせ）を含むことができるポップアップダイアログボックス。
	 * inputForm.Show()で自動的に入力フォームポップアップを表示します
	 * ハンター専用の実装。
	 * 閉じたとき、CloseEventを引数としたコールバックが登録されている場合は呼び出されます
	 * @since		2015-09-09
	 * @author		qwang
	 * @copyright	(C)2015 CROOZ ALL Rights
	 */
	public class InputForm extends InputFormPanel
	{
		
		//-----------------------------------------------------
		//クラス定数
		//-----------------------------------------------------	
		
		/**
		 * flags パラメーター（show() メソッドのパラメーター）として渡されたときに、inputForm コントロールの「キャンセル」ボタンを有効にする値です。 | 演算子を使用すると、このビットフラグを OK、YES、NO および NONMODAL フラグと組み合わせることができます。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static const CANCEL:uint = 0x0008;
		
		/**
		 * flags パラメーター（show() メソッドのパラメーター）として渡されたときに、inputForm コントロールの「OK」ボタンを有効にする値です。 | 演算子を使用すると、このビットフラグを CANCEL、YES、NO および NONMODAL フラグと組み合わせることができます。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static const OK:uint = 0x0004;		
		
		//-----------------------------------------------------
		//クラスメソッド
		//-----------------------------------------------------	
		
		/**
		 * inputForm コントロールをポップアップする静的メソッドです。inputForm コントロールは、ユーザーがこのコントロールのボタンを選択したときに閉じます。
		 *
		 * @param	title	タイトルバーに表示されるテキストストリングです。このテキストは左揃えされます。
		 * @param	defaultText		何も入力されてない状態に表示されるテキスト
		 * @param	maxChars		入力可能文字数
		 * @param	closeHandler	Alert コントロール上の任意のボタンが押されたときに呼び出されるイベントハンドラーです。 このハンドラーに渡されるイベントオブジェクトは、CloseEvent のインスタンスです。このオブジェクトの detail プロパティには、値 Alert.OK、Alert.CANCELが含まれます。
		 * @return	inputForm コントロールへの参照です。
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.1
		 * @productversion	Flex 3
		 */
		public static function show(title:String = "", defaultText:String = "", maxChars:int = 30, closeHandler:Function = null):InputForm
		{	
			var inputForm:InputForm = new InputForm();
			inputForm.titleLabel.text = title;
			inputForm.setPromptAndMaxChara(defaultText, maxChars);
			inputForm.callBackHandler = closeHandler;
			inputForm.invalidateDisplayList();
			
			inputForm.showPopup();
			
			return inputForm;
		}
		
		//-----------------------------------------------------
		//コンストラクタ
		//-----------------------------------------------------			
		
		/**
		 * コンストラクタ
		 */
		public function InputForm()
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
			
			var inputAreabd:BitmapData = LinkageUtility.createBitmapData("common_9grid_j");
			var inputAreaBg:BitmapScale9Grid = new BitmapScale9Grid(inputAreabd, new Rectangle(4, 4, 81, 81));
			inputAreaBg.setSize(550, 50);
			DisplayUtility.addChildSetPosition(this, inputAreaBg, 20, 50);
			
			super.init();
			
			var tf:TextFormat = new TextFormat();
			tf.font = "小塚ゴシック Pro M";
			tf.color = 0x000000;
			tf.size = 12;
			tf.align = "left";
			textInput.setStyle("textFormat", tf);
			textInput.setStyle("textPadding", 1);
			
			textInput.prompt = "あいさつを入力してください(40文字)";
			textInput.setSize(550, 50);
			DisplayUtility.addChildSetPosition(this, textInput, 20, 50);
			
			okBtn.setButtonSkin("common_btn_skin_a_link_240x40");
			okBtn.setLabelLinkage("common_btn_b_txt_a40_ok");
			cancelBtn.setButtonSkin("common_btn_skin_b_link_240x40");
			cancelBtn.setLabelLinkage("common_btn_b_txt_a40_cancel");
		}
	}
}