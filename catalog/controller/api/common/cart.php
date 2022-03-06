<?php
class ControllerAPICommonCart extends Controller {

	public function index() {
		$this->load->language('common/cart');
		$this->load->controller('api/common/header');
		$this->load->model('api/account/customer');

		// Totals
		$this->load->model('extension/extension');
		$this->load->model('checkout/user_tracking');

		$current_logged_customer_id = $this->customer->getId();
		$data['logged_customer_id'] = $current_logged_customer_id;

		$timezone = new DateTimeZone(DB_TIMEZONE_SETTING );
		$date = new DateTime();
		$date->setTimezone($timezone );
	   
		$data['current_user_logged_time'] = $date->format( 'Y-m-d H:i:s' );
		
		if($current_logged_customer_id  > 0 ){
			$this->model_checkout_user_tracking->save($current_logged_customer_id);
		}
		if (isset($this->request->post['currency'])) {
			$currentCurrency = $this->currency->getCurrentCurrency($this->request->post['currency']);
		}else{
 			$currentCurrency = $this->currency->getCurrentCurrency($this->currency->getCurrency());
		}
		
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();
		$cart_id = $this->cart->getActiveCartId();
		/* if (isset($this->request->post['cart_id'])) {
				$cart_id = $this->request->post['cart_id'];
			} else {
				$cart_id = '';
			} */
		// Display prices
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$sort_order = array();
			
			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('api/total/' . $result['code']);
					
					$this->{'model_api_total_' . $result['code']}->getTotal($total_data, $total, $taxes,$cart_id);
				}
			}
			
			/* print_r($total_data); */
			$sort_order = array();
			
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $total_data);
		}
			

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_share_link_to_invite'] = $this->language->get('text_share_link_to_invite');                
		$data['text_user_offline'] = $this->language->get('text_user_offline');                
		$data['text_user_online'] = $this->language->get('text_user_online');                
                
		$data['text_cart'] = $this->language->get('text_cart');
		$data['your_cart_text'] = $this->language->get('your_cart_text');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_recurring'] = $this->language->get('text_recurring');
		//$data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, '', '', false));
		$data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, '', '', false));
		
		
		//$data['products_count'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['products_count'] = $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['products_total_price'] = $this->currency->format($total, '', '', false);
		$data['products_text_items'] = $this->language->get('products_text_items');
		
		
		$data['text_loading'] = $this->language->get('text_loading');

		$data['button_remove'] = $this->language->get('button_remove');
		if ($this->config->get('config_cart_weight')) {
			$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
		} else {
			$data['weight'] = '';
		}

		$this->load->model('tool/image');
		$this->load->model('tool/upload');
        $this->load->model('account/customer');

		$data['cart_users'] = $this->cart->getAllCartUsers();
		$data['cart_owner'] =  $this->cart->getCartOwner();
		
		$currentCurrencyType = $this->model_account_customer->getCustomer($this->customer->getId());
		//echo $this->config->get('config_language_id');
		if($currentCurrencyType['currency']){
			$currency = $currentCurrencyType['currency'];
		}else{
			$currency = $this->currency->getCurrency();
		}
		
		$data['currency_type'] = $currency;
		
		$data['products'] = array();
		

		foreach ($this->cart->getProducts() as $product) {

			if ($product['image']) {
				$image = $this->model_tool_image->resize($product['image'], 150, 150);
			} else {
				$image = '';
			}

			$option_data = array();

			foreach ($product['option'] as $option) {
				if ($option['type'] != 'file') {
					$value = $option['value'];
				} else {
					$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

					if ($upload_info) {
						$value = $upload_info['name'];
					} else {
						$value = '';
					}
				}

				$option_data[] = array(
					'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value),
					'type'  => $option['type']
				);
			}

			// Display prices
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), '', '', false);
			} else {
				$price = false;
			}

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'], '', '', false);
			} else {
				$total = false;
			}
			
			$stock_status = $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'));
			$stock_status = (int)$stock_status;
			//print_r($product); 
			$data['products'][] = array(
				'cart_id'   => $product['cart_id'],
				'product_id'   => $product['product_id'],
				'firstname' => ($product['firstname'] == "You") ? $this->language->get('text_you') : $product['firstname'],				
				'added_by'  => $product['added_by'],				
				'mcp_id'    => $product['mcp_id'],				
				'minimun'   => $product['minimum'],				
				'thumb'     => $image,
				'name'      => $product['name'],
				'model'     => $product['model'],
				'option'    => $option_data,
				'recurring' => ($product['recurring'] ? $product['recurring']['name'] : ''),
				'quantity'  => $product['quantity'],
				'stock_status'		=> (string)$stock_status,
				'currency'  => $currentCurrency,
				'price'     => $price,
				'total'     => $total,
				'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
			);
		}
	
		// Gift Voucher
		$data['vouchers'] = array();
		
		if (!empty($this->session->data['vouchers'])) {
			foreach ($this->session->data['vouchers'] as $key => $voucher) {
				$data['vouchers'][] = array(
					'key'         => $key,
					'description' => $voucher['description'],
					'amount'      => $voucher['amount']
				);
			}
		}
		
		$data['totals'] = array();
		
		foreach ($total_data as $result) {
			$data['totals'][] = array(
				'title' => $result['title'],
				'text'  => $result['value'],
			);
		}
		//print_r($data['totals']);
		$data['cart'] = $this->url->link('checkout/cart');
		$data['shop_with_friends'] = $this->language->get('shop_with_friends');
		$data['show_friends'] = $this->language->get('show_friends');
		$data['hide_friends'] = $this->language->get('hide_friends');
		$data['logged'] = $this->customer->isLogged();
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['delet_url'] = $this->url->link('checkout/cart/delete', '', 'SSL');;
                
		$cart_data = $this->cart->checkoutStage();
		
		if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
			$data['text_checkout'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname']);
			$data['checkout'] = 'javascript:void(0);';
		} 
               

		$data['share_url'] = '';
		if ($this->customer->isLogged()) {                
			$active_cart_id = $this->cart->getActiveCartId();
			if($active_cart_id>0){
				$share_url = str_replace('&amp;', '&', $this->url->link('checkout/cart/share', 'cart_id='.$active_cart_id, 'SSL'));    
			}else{
				$share_url = '';
			}
			$data['share_url'] = $share_url;
		}
//		echo $this->currency->getCurrency();
		if (isset($this->request->post['currency'])) {
			$currentCurrency = $this->currency->getCurrentCurrency($this->request->post['currency']);
		}else{
			$currentCurrency = $this->currency->getCurrentCurrency($this->currency->getCurrency());
		}
		
		$getCouponCode = $this->model_api_total_coupon->getCouponCode($cart_id);
		$getVoucherCode = $this->model_api_total_voucher->getVoucherCode($cart_id);
		
		if (isset($getVoucherCode['voucher_code'])) {
			$data['voucher_status'] = 1;
		}else{
			$data['voucher_status'] = 0;
		}
		if (isset($getCouponCode['coupon_code'])) {
			$data['coupon_status'] = 1;
		}else{
			$data['coupon_status'] = 0;
		}
		$data['currency'] = $currentCurrency;
		$data['status'] = 1;
		$this->response->addHeader('Content-Type: application/json');
		echo json_encode($data);
	}

	public function info() {
		$this->response->setOutput($this->index());
	}
}