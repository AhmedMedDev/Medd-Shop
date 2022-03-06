<?php
class ModelCheckoutUser extends Model {
	public function save($customer_id) {
	
	
		if( intval( $customer_id > 0 ) ){
			$this->db->query("UPDATE " . DB_PREFIX . "order_recurring SET reference = '" . $this->db->escape($ref) . "' WHERE order_recurring_id = '" . (int)$recurring_id . "'");				
		}
		
	}

}
