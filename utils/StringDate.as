package utils 
{
	/**
	 * サーバなどから取得した時間をStringで保持しておくクラス
	 * Date型のStringバージョン
	 * 
	 * @author ikawashima
	 */
	public class StringDate 
	{
		/** 年 */
		public var year:String;
		
		/** 月 */
		public var month:String;
		
		/** 日 */
		public var date:String;
		
		/** 時間 */
		public var hours:String;
		
		/** 分 */
		public var minutes:String;
		
		/** 秒 */
		public var seconds:String;
		
		/** ミリ秒 */
		public var ms:String;
		
		/**
		 * コンストラクタ
		 * 
		 * @param	_year
		 * @param	_month
		 * @param	_date
		 * @param	_hours
		 * @param	_minutes
		 * @param	_seconds
		 * @param	_ms
		 */
		public function StringDate (_year:*=null, _month:*=null, _date:*=null, _hours:*=null, _minutes:*=null, _seconds:*=null, _ms:*=null)
		{
			year = String(_year);
			month = String(_month);
			date = String(_date);
			hours = String(_hours);
			minutes = String(_minutes);
			seconds = String(_seconds);
			ms = String(_ms);
		}
	}

}