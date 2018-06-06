package ui.inputForms 
{
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.text.TextFormat;
	/**
	 * タイトルがイメージ画像の入力フォームクラス.
	 * タイトル、入力エリア、ボタン（「OK」、「キャンセル」の任意の組み合わせ）を含むことができるポップアップダイアログボックス。
	 * inputForm.Show()で自動的に入力フォームポップアップを表示します
	 * ハンター専用の実装。
	 * 閉じたとき、CloseEventを引数としたコールバックが登録されている場合は呼び出されます
	 * 
	 * @author		ogino
	 */
	public class TitelImageInputForm extends InputFormPanel 
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
		public static function show(title:String = "", defaultText:String = "", maxChars:int = 30, closeHandler:Function = null):TitelImageInputForm
		{	
			var inputForm:TitelImageInputForm = new TitelImageInputForm();
			inputForm.setTitleImage(title);
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
		public function TitelImageInputForm() 
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
			super.init();
			
			drawBackgroundImage(LinkageUtility.createBitmapData("common_popup_3"));
			setSize(861, 234);
			
			var tf:TextFormat = new TextFormat();
			tf.font = "小塚ゴシック Pro M";
			tf.color = 0xFFFFFF;
			tf.size = 15;
			tf.align = "left";
			textInput.setTextInputSkin("guild_keijiban_txtbox_table");
			textInput.setStyle("textPadding", 8);
			textInput.setStyle("textFormat", tf);
			
			textInput.setSize(695, 46);
			DisplayUtility.addChildSetPosition(this, textInput, 83, 75);
			
			okBtn.setButtonSkin("common_btn_skin_a_link_240x40");
			okBtn.setLabelLinkage("common_btn_b_txt_a40_ok");
			cancelBtn.setButtonSkin("common_btn_skin_b_link_240x40");
			cancelBtn.setLabelLinkage("common_btn_b_txt_a40_cancel");
			
			btnList.paddingLeft = 0;
			btnList.move(215, 163);
		}		
		
		/**
		 * @inheritDoc
		 */
		override public function invalidateDisplayList():void 
		{
			btnList.invalidateDisplayList();
			btnList.x = (width - btnList.width) >> 1;
		}		
	}

}