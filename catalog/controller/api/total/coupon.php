<?php
class ControllerAPITotalCoupon extends Controller {
	public function index() {
		if ($this->config->get('coupon_status')) {
			$this->load->language('total/coupon');

			$data['heading_title'] = $this->language->get('heading_title');
			$data['text_loading'] = $this->language->get('text_loading');
			$data['entry_coupon'] = $this->language->get('entry_coupon');
			$data['button_coupon'] = $this->language->get('button_coupon');

			if (isset($this->session->data['coupon'])) {
				$data['coupon'] = $this->session->data['coupon'];
			} else {
				$data['coupon'] = '';
			}
			$data['status'] = 1;
			$this->response->setOutput(json_encode($data));
		}
	}

	public function coupon() {
		
		$this->load->language('total/coupon');
		$json = array();
		$this->load->model('total/coupon');
		$this->load->model('api/total/coupon');
		
		if (isset($this->request->post['coupon'])) {
			$coupon = $this->request->post['coupon'];
		} else {
			$coupon = '';
		}
		
		if (isset($this->request->post['cart_id'])) {
			$cart_id = $this->request->post['cart_id'];
		} else {
			$cart_id = '';
		}
		
		$coupon_info = $this->model_api_total_coupon->getCoupon($coupon);
		 
		if (empty($this->request->post['coupon'])) {
			$json['error'] = $this->language->get('error_empty');
			$json['status'] = 0;
		} elseif ($coupon_info) {
			$getCouponResult = $this->model_api_total_coupon->getCouponCode($cart_id);
			 
			if($getCouponResult){
				$json['error'] = $this->language->get('error_applied');
				$json['status'] = 0;
			}else{
				$json['coupon'] = $this->request->post['coupon'];
				
				$this->model_api_total_coupon->applyCoupon($cart_id,$coupon);
				$json['success'] = $this->language->get('text_success');
				$json['redirect'] = $this->url->link('checkout/cart');
				$json['status'] = 1;
			}
		} else {
			$json['error'] = $this->language->get('error_coupon');
			$json['status'] = 0;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function deleteCoupon(){
		$json = array();
		$this->load->language('total/coupon');
		$this->load->model('api/total/coupon');
		
		if (isset($this->request->post['cart_id'])) {
			$cart_id = $this->request->post['cart_id'];
		} else {
			$cart_id = '';
		}
		
		if($cart_id){
			$this->model_api_total_coupon->deleteCoupon($cart_id);
			$json['success'] = $this->language->get('text_remove');
			$json['status'] = 1;
		}else{
			$json['error'] = $this->language->get('error_cartid');
			$json['status'] = 0;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getCoupons(){
		$this->load->model('api/total/coupon');
		$results = $this->model_api_total_coupon->getCoupons();
		foreach ($results as $result) {
			$data['coupons'][] = array(
				'coupon_id'  => $result['coupon_id'],
				'name'       => $result['name'],
				'code'       => $result['code'],
				'discount'   => $result['discount'],
				'date_start' => date($this->language->get('date_format_short'), strtotime($result['date_start'])),
				'date_end'   => date($this->language->get('date_format_short'), strtotime($result['date_end'])),
				'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'edit'       => $this->url->link('marketing/coupon/edit', 'token=' . $this->session->data['token'] . '&coupon_id=' . $result['coupon_id'] . $url, 'SSL')
			);
		}
		$data['status'] = 1;
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data));
	}
}