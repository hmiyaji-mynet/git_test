package utils 
{
	/**
	 * ...
	 * @author Yukihiro Kawasaki
	 */
	public class CardModelUtil 
	{
		//jsonデータが空かどうか
		public static function isEmpty(obj:Object):Boolean
		{
			if (!obj) return true;
			else if (obj is Array) {
				if (obj.length == 0) return true;
				else return false;
			}
			else return false;
		}
	}

}