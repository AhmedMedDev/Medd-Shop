<?php
class ModelAPITotalShipping extends Model {
	public function getTotal(&$total_data, &$total, &$taxes,&$cart_id='') {
		
		$getShipping = $this->getShipping($cart_id);
		$sessionData = $this->customer->getSessionData($this->customer->getToken());
		$sessionData = unserialize($sessionData['session_data']);
		$shipping = explode('.', $getShipping['shipping']);
		$shippingMethod = $sessionData['shipping_methods'];
		$getShippingInfo = $shippingMethod[$shipping[0]]['quote'];
		
		$this->session->data['shipping_method'] = $getShippingInfo[$shipping[0]];
		
		if ($this->cart->hasShipping() && isset($this->session->data['shipping_method'])) {
			$total_data[] = array(
				'code'       => 'shipping',
				'title'      => $this->session->data['shipping_method']['title'],
				'value'      => $this->session->data['shipping_method']['cost'],
				'sort_order' => $this->config->get('shipping_sort_order')
			);

			if ($this->session->data['shipping_method']['tax_class_id']) {
				$tax_rates = $this->tax->getRates($this->session->data['shipping_method']['cost'], $this->session->data['shipping_method']['tax_class_id']);

				foreach ($tax_rates as $tax_rate) {
					if (!isset($taxes[$tax_rate['tax_rate_id']])) {
						$taxes[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
					} else {
						$taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
					}
				}
			}

			$total += $this->session->data['shipping_method']['cost'];
		}
	}
	
	
	public function applyShipping($cart_id,$shipping){
		
		if($cart_id){
			
			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "cart_shipping` WHERE user_id = '" . (int)$this->customer->getId() . "'");
			
			if($query->num_rows){
				$this->db->query("UPDATE " . DB_PREFIX . "cart_shipping SET shipping = '" . $shipping . "', cart_id = '".$cart_id."' WHERE user_id = '" . (int)$this->customer->getId() . "'");
			}else{
				$this->db->query("INSERT INTO `" . DB_PREFIX . "cart_shipping` SET user_id = '".(int)$this->customer->getId()."', cart_id = '".$cart_id."', shipping = '".$shipping."'");
			}
		}
	}
	public function getShipping($cart_id){
		if($cart_id){
			
			$query = $this->db->query("SELECT shipping FROM `" . DB_PREFIX . "cart_shipping` WHERE user_id = '".(int)$this->customer->getId()."' AND cart_id = '".$cart_id."'");
		}
		
		return $query->row;
	}
	
	public function deleteShipping($cart_id){
		$this->db->query("DELETE FROM `" . DB_PREFIX . "cart_shipping` WHERE user_id = '".(int)$this->customer->getId()."' AND cart_id = '".$cart_id."'");
		
		return true;
	}
}