package utils 
{
	/**
	 * サーバ側のJSONをこちらで使える形に（無理やり）直すために使用する
	 * @author yu saito
	 */
	public class GachaJsonRefactorUtil 
	{
		
		/**
		 * ガチャ演出時のgetExecCntBonusで入手される情報がかなり簡素化されていたので水増し調整
		 * @param	json
		 * @return
		 */
		static public function refactorExecCntBonus(json:Object):Object
		{
			var result:Object = new Object();
			result["item_value"] = json["item_id"];
			result["item_num"] = json["item_num"];
			result["prize_rank"] = "10"; // 10の時は非表示
			result["item_category"] = json["item_category"]; 
			result["detail"] = new Object();
			var category:String = json["item_category"];
			switch (category) 
			{
				// カードの時
				case "3":
					var card:Object = new Object();
					card.card_id = json["item_id"];
					card.card_name = json["name"];
					card.card_comment  = "";
					card.card_comment_detail = "";
					card.card_cost = "";
					card.card_img =  json["item_id"];
					card.cardRank = "";
					card.card_rare = "";
					card.card_rare_name = "";
					result["detail"]["card"] = card;
					break;
				default:
					result["detail"]["name"] = json["name"];
					result["detail"]["description"] = "";
			}
			return result;
		}
		
	}

}