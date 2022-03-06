<?php
class ModelCheckoutUserTracking extends Model {
	public function save($customer_id){
	
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart_user_last_tracked WHERE mcult_user_id = '" . (int)$customer_id . "'");
		$num_rows = $query->num_rows;
	
		if( $num_rows > 0 ){
		
			$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_user_last_tracked SET mcult_tracked_time = CURRENT_TIMESTAMP WHERE mcult_user_id = '" . (int)$customer_id . "'");
			$logged_time = ($query->row['mcult_checkout_tracked_time'] != NULL )?1 :0 ;
			if( $logged_time ){

	                $timezone = new DateTimeZone(DB_TIMEZONE_SETTING);
	                
	                $date = new DateTime();
	                $date->setTimezone($timezone );
	                $current_user_logged_time = $date->format( 'Y-m-d H:i:s' );	
			
			$time1 = strtotime($query->row['mcult_checkout_tracked_time']);
			$time2 = strtotime($current_user_logged_time);

			$diff = ($time2-$time1)/60;
			if ($diff>5){

				$cart_id = $this->cart->getActiveCartId();
				$this->db->query("UPDATE " . DB_PREFIX . "multi_cart SET mc_current_stage = 0, mc_checkout_by_user = 0 WHERE mc_cart_id = '" . (int)$cart_id . "' AND mc_checkout_by_user = '" . (int)$customer_id . "'");
			}				
			}		
			
		}else{
			$this->db->query("INSERT INTO " . DB_PREFIX . "multi_cart_user_last_tracked ( mcult_user_id,mcult_tracked_time) VALUES ('" . (int)$customer_id . "',CURRENT_TIMESTAMP)");
		}

		
	}
	
	public function update($customer_id){
		if( isset($this->request->get['route'])){
			$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_user_last_tracked SET mcult_tracked_time = CURRENT_TIMESTAMP, mcult_checkout_tracked_time = CURRENT_TIMESTAMP WHERE mcult_user_id = '" . (int)$customer_id . "'");		
		}
	}

}
