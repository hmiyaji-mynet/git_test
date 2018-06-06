package ui.gauge 
{
	import a24.tween.Tween24;
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * レイド　ＨＰゲージ
	 * 
	 * @author ogino
	 */
	public class RaidBossHpGauge extends AbstractGauge 
	{
		
		//-------------------------------------------
		// コンポーネント
		//-------------------------------------------			
		
		/** ダメージゲージ */
		private var damagesGauge:Bitmap;
		
		//-------------------------------------------
		//コンストラクタ
		//-------------------------------------------			
		
		/**
		 * コンストラクタ
		 */
		public function RaidBossHpGauge() 
		{
			super();
		}
		
		//-------------------------------------------
		//オーバーライドしたメソッド
		//-------------------------------------------			
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void 
		{
			drawBackgroundImage(LinkageUtility.createBitmapData("battle_raid_gauge_bg"));	
			
			var gauge:Bitmap = LinkageUtility.createBitmap("battle_raid_gauge_skin");		
			
			/*damagesGauge = LinkageUtility.createBitmap("battle_raid_gauge_skin");
			DisplayUtility.addChildSetPosition(this, damagesGauge, 14, 7);
			damagesGauge.visible = false;			*/
			
			DisplayUtility.addChildSetPosition(this, gauge, 14, 7);			
			
			var bd:BitmapData = new BitmapData(gauge.width, gauge.height);
			bd.copyPixels(gauge.bitmapData, new Rectangle(0, 0, gauge.width, gauge.height), new Point(0, 0));
			
			maskImage = new Bitmap(bd);
			gauge.mask = maskImage;
			DisplayUtility.addChildSetPosition(this, maskImage, 14, 7);	
		}		
		
		/**
		 * @inheritDoc
		 */
		override public function updateGauge(num:Number, Max:Number):void 
		{
			Tween24.stopAllTweens();
			super.updateGauge(num, Max);
			/*damagesGauge.visible = true;
			
			var bd:BitmapData = maskImage.bitmapData;
			
			// ゲージの動き
			var tween:Tween24 = Tween24.tween(damagesGauge, 0.2, Tween24.ease.SineOut).width(bd.width * (num / Max)).visible(false).delay(1);
			tween.play();*/
		}		
		
	}

}