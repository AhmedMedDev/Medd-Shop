<?php
class ModelAPICommonCurrency extends Model {
	public function updateCurrency($currency_code,$customer_id){
		
		$customer_id = $this->customer->getId();
		if($currency_code){
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET currency = '" . $currency_code . "' WHERE customer_id = '" . (int)$customer_id . "'");
		}
	}
	
}