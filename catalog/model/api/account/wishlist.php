<?php
class ModelAPIAccountWishlist extends Model {
	public function getProductWishlist($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "' AND product_id = '".$product_id."'");
		
		$getData = $query->rows;
		
		if($getData){
			return true;
		}else{
			return false;
		}
	}
	
	public function getTotalWishlist($customer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$customer_id . "'");
		return $query->row['total'];
	}
	public function getCustomerIdByToken($token){
		$query = $this->db->query("SELECT `customer_id` FROM `" . DB_PREFIX . "customer` WHERE `token`='".$token."'");
		return $query->row['customer_id'];
	}
}
