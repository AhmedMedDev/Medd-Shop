<?php

class ModelCheckoutCheckout extends Model {

	public function getCouponCode($cart_id){

		if($cart_id){

			

			$query = $this->db->query("SELECT coupon_code FROM `" . DB_PREFIX . "cart_coupon` WHERE user_id = '".(int)$this->customer->getId()."' AND cart_id = '".$cart_id."'");

		}

		return $query->row['coupon_code'];

	}

	

	public function getVoucherCode($cart_id){

		if($cart_id){

			$query = $this->db->query("SELECT voucher_code FROM `" . DB_PREFIX . "cart_voucher` WHERE user_id = '".(int)$this->customer->getId()."' AND cart_id = '".$cart_id."'");

		}

		return $query->row['voucher_code'];

	}

	public function getShipping($cart_id){

		if($cart_id){

			$query = $this->db->query("SELECT shipping FROM `" . DB_PREFIX . "cart_shipping` WHERE user_id = '".(int)$this->customer->getId()."' AND cart_id = '".$cart_id."'");

		}

		return $query->row['shipping'];

	}

}

