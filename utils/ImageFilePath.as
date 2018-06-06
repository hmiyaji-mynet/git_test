package utils 
{
	/**
	 * アイテム画像をロード先を取得するたためのクラス
	 * 
	 * @since		2015-10-23
	 * @author		qwang
	 * @copyright	(C)2015 CROOZ ALL Rights
	 */
	public class ImageFilePath 
	{
		/**
		 * アイテムの画像パスを取得
		 * 
		 * @param	string　アイテム画像タイプ
		 * @param	String アイテム画像ID
		 * @return	画像パス
		 */
		public static function getImageFilePath(type:String, id:String):String
		{
			var file:String = "";
			switch(type)
			{
				case "1":
					file = "img/other/money.jpg";
					break;
				/*case "2":
					file = "img/other/raidpoint.jpg";
					break;*/
				break;
				case "3":
					file = "img/card/small/" + id + ".png";
					break;
				case "4":
					file = "img/other/yell.jpg";
					break;
				case "5":
					file = "img/item/middle/" + id + "_2.png";
					break;
				default:
					file = "img/item/middle/" + id + ".jpg";
					break;
			}
			
			return file;
		}
	}

}