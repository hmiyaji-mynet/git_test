ssssssss

package utils 
{
	/**
	 * 秒数を時:分：秒に変換
	 * @author kei kato
	 */
	
	public function timeFormat(second:int):String {
		var hh:int = int(second / 3600);
		var mm:int = int((second % 3600) / 60);
		var ss:int = int(second % 60);
		var mStr:String = String(mm);
		if (mm < 10) {
			mStr = "0" + String(mm);
		}
		var sStr:String = String(ss);
		if (ss < 10) {
			sStr = "0" + String(ss);
		}
		return String(hh) + ":" + mStr + ":" + sStr;
	}

}