package ui.timer 
{
1
2
3
4
5
6
	import core.utils.DateUtil;
	import core.utils.LinkageUtility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.components.sprite.HSprite;
	import ui.components.UIComponents;
	import ui.textFields.LabelTextField;
	
	/**
	 * LinkageTimer
	 * Timerの時間を文字で表示するか画像で表示するかを設定するだけで手軽に表示できるタイマークラス
	 * 使い方は以下を参考に
	 * 	var timer:LinkageTimer = new LinkageTimer();
	 * //画像を使う場合
	 * 	timer.setLabelTextImage("common_txt_num_");
	 * //文字を使う場合
	 * 	timer.setLabelText(120, 20, 0xffffff, 12, "center");  
	 * どれか一つだけを設定するように
	 * 
	 * 更新する時はupdateを呼び出し、limitTimeを渡す
	 * 
	 * @since		2015-09-24
	 * @author		qwang
	 * @copyright	(C)2015 CROOZ ALL Rights
	 */
	public class LinkageTimer extends UIComponents
	{
		// -----------------------------------------------------------------------
	    // プロパティ
	    // -----------------------------------------------------------------------
		
		/** タイマーのテキスト */
		protected var timerLabel:LabelTextField;
		
		/** リミットタイム */
		protected var limitTime:int;
		
		/** タイマー */
		protected var timer:Timer;
		
		/** タイマーカウント */
		protected var timeCnt:int;
		
		/** 数字画像 */
		protected var numberImage:Vector.<BitmapData>;
		
		/** 時間のHSprite */
		protected var timeImgList:HSprite;
		
		/** 数字画像の横幅 */
		public var imgWidth:Number = 0;
			
		/** 数字画像の縦幅 */
		public var imgHeight:Number = 0;
		
		// -----------------------------------------------------------------------
	    // コンストラクタ
	    // -----------------------------------------------------------------------	
		
		/**
		 * コンストラクタ
		 */
		public function LinkageTimer() 
		{
			super();
		}
		
		// -----------------------------------------------------------------------
	    // オーバーライドしたメソッド
	    // -----------------------------------------------------------------------			
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void 
		{
			super.init();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update(...rest):void 
		{
			if (rest && rest.length)
			{
				limitTime = int(rest[0]);
				timeCnt = 0;
				if (!timer.running)
				{
					timer.addEventListener(TimerEvent.TIMER, timerHandler);
					timer.start();
				}
			}
		}
		
		// -----------------------------------------------------------------------
	    // メソッド
	    // -----------------------------------------------------------------------
		
		/**
		 * タイマーの文字をセット
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	size
		 * @param	align
		 */
		public function setLabelText(width:Number, height:Number, color:uint, size:Number, align:String):void
		{
			timerLabel = new LabelTextField();
			timerLabel.width = width;
			timerLabel.height = height;
			timerLabel.color = color;
			timerLabel.size = size;
			timerLabel.align = align;
			
			addChild(timerLabel);
		}
		
		/**
		 * 数字を画像で表示するための画像ファイルをセット
		 * @param	String 画像のファイル名 （0番から9番まで揃うものじゃないとダメ, 渡す時は番号を除いたファイル名, 例:common_txt_num_0 だと common_txt_num_を渡すこと）
		 */
		public function setLabelTextImage(fileName:String, w:Number = 0, h:Number = 0):void
		{
			numberImage = new Vector.<BitmapData>();
			for (var i:int = 0; i < 10; i++)
			{
				var img:BitmapData = LinkageUtility.createBitmapData(fileName + i.toString());
				numberImage.push(img);
			}
			numberImage.push(LinkageUtility.createBitmapData("common_txt_num_colon"));
			timeImgList = new HSprite();
			timeImgList.gap = 0;
			
			for (var j:int = 0; j < 8; j++)
			{
				var timeImg:Bitmap = new Bitmap();
				timeImgList.addChild(timeImg);
			}
			addChild(timeImgList);
		}
		
		// -----------------------------------------------------------------------
	    // イベントハンドラー
	    // -----------------------------------------------------------------------	
		
		/**
		 * タイマーイベント
		 * @param	e
		 */
		private function timerHandler(e:TimerEvent):void 
		{
			// プロパティ持ち タイマー起動前に0を初期化
			timeCnt++;
			// 逃走完了時間から、タイマーカウンターを引く
			var escapeTime:int = limitTime - timeCnt;
			
			if (escapeTime < 0) 
			{
				escapeTime = 0;
				timer.reset();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			}
			
			//文字で表示する場合
			if (timerLabel)
			{
				timerLabel.text = DateUtil.secondToHourString(escapeTime);
			} //画像で表示する場合
			else if (numberImage && timeImgList)
			{
				//今表示している画像のbitmapDataを全部一回消してから新しいbitmapdataを代入
				var len:int = timeImgList.numChildren;
				for (var j:int = 0; j < len; j++ )
				{
					Bitmap(timeImgList.getChildAt(j)).bitmapData = null;
				}
				
				var date:String = DateUtil.secondToHourString(escapeTime);
				for (var i:int = 0; i < date.length; i++)
				{
					var str:String = date.substring(i, i + 1);
					
					if (i < timeImgList.numChildren)
					{
						var dateImg:Bitmap = Bitmap(timeImgList.getChildAt(i));
						if (str === ":")
						{
							dateImg.bitmapData = numberImage[10];
							dateImg.visible = true;
						}
						else
						{
							
							dateImg.bitmapData = numberImage[parseInt(str)];
							dateImg.visible = true;
						}
						
						if (imgWidth)
						{
							dateImg.width = imgWidth;
							dateImg.height = imgHeight;
						}
					}
				}
				timeImgList.invalidateDisplayList();
			}
		}
	}

}