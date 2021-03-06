package ui.gauge 
{
	import core.utils.DisplayUtility;
	import core.utils.LinkageUtility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * レイドスキルゲージクラス
	 * 
	 * @author ogino
	 */
	public class RaidSkillGauge extends AbstractGauge 
	{
		
		//-------------------------------------------
		//コンストラクタ
		//-------------------------------------------		
		
		/**
		 * コンストラクタ
		 */		
		public function RaidSkillGauge() 
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
			drawBackgroundImage(LinkageUtility.createBitmapData("common_gauge_recast_bg"));	
		}
		
		//-------------------------------------------
		//メソッド
		//-------------------------------------------			
		
		/**
		 * ゲージイメージ
		 * 
		 * @param	linkage
		 */
		public function setGaugeImage(linkage:String):void 
		{
			var gauge:Bitmap = LinkageUtility.createBitmap(linkage);
			DisplayUtility.addChildSetPosition(this, gauge, 2, 2);			
			
			var bd:BitmapData = new BitmapData(gauge.width, gauge.height);
			bd.copyPixels(gauge.bitmapData, new Rectangle(0, 0, gauge.width, gauge.height), new Point(0, 0));				
			
			maskImage = new Bitmap(bd);
			gauge.mask = maskImage;
			DisplayUtility.addChildSetPosition(this, maskImage, 2, 2);			
		}		
		
	}

}