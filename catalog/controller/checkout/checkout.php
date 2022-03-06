<?php
class ControllerCheckoutCheckout extends Controller {
	public function index() {
		
		 
		$this->load->model('checkout/checkout');
		$this->load->model('account/customer');
		$this->load->language('checkout/checkout');
		
		if(isset($this->request->post['token'])){
			 
			if (!$this->customer->loginWithToken($this->request->post['token'])) {
				$this->error['warning'] = $this->language->get('error_login');
				$this->model_account_customer->addLoginAttempt($this->request->post['token']);
				$this->session->data['error_warning'] = $this->language->get('error_login');
				$this->response->redirect($this->url->link('common/cart/error_app'));
			} else {  
				$this->session->data['api_checkout_process'] = true; 
				
				$this->model_account_customer->deleteLoginAttempts($this->request->post['token']);
			}
			
			$cart_id = $this->cart->getActiveCartId();
			
			unset($this->session->data['guest']);
			$this->session->data['coupon'] = $this->model_checkout_checkout->getCouponCode($cart_id);
			
			$this->session->data['voucher'] = $this->model_checkout_checkout->getVoucherCode($cart_id);
			$shippingMethod = $this->model_checkout_checkout->getShipping($cart_id);
			$shipping = explode('.', $shippingMethod);
			
			$sessionData = $this->customer->getSessionData($this->customer->getToken());
			$sessionData = unserialize($sessionData['session_data']);
			$this->session->data['shipping_address'] = $sessionData['shipping_address'];
			$this->session->data['shipping_methods'] = $sessionData['shipping_methods'];
			$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
			$this->session->data['hide_Data'] = '1';
            $this->session->data['m_app'] = '1';
			
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			
			//$this->response->redirect($this->url->link('checkout/cart'));
		}
		
		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();
		
		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {				 
				$this->response->redirect($this->url->link('checkout/cart'));
			}
		}
		
		// Totals
		$this->load->model('extension/extension');
		$result_ship = $this->model_extension_extension->getExtensions('shipping');
		foreach($result_ship AS $ship_val){
			if(array_key_exists('code', $ship_val) && $ship_val['code']=='free'){
				$free_shipping_status = $this->config->get('free_status');
				$free_total = $this->config->get('free_total');
				if($free_shipping_status==1 && (int)$free_total>0){
					$data['text_cart_order_note']     = sprintf($this->language->get('text_cart_order_note'),$this->currency->format($free_total));
				}
				break;
			}
		}
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();
		$data['continue'] = $this->url->link('common/home');
		$data['current_page_url'] = $this->url->link('checkout/cart', '', 'SSL');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');			
		
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
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}

			$sort_order = array();

			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $total_data);
		}
		
		$data['totals'] = array();

		foreach ($total_data as $total) {
			$data['totals'][] = array(
				'title' => $total['title'],
				'text'  => $this->currency->format($total['value'])
			);
		}		
		
		$this->document->setTitle($data['heading_title']);
		$this->document->addStyle('catalog/view/theme/growcer/css/jQueryTab.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/animation.css');
		$this->document->addScript('catalog/view/theme/growcer/js/jQueryTab.js');
		


		// Required by klarna
		if ($this->config->get('klarna_account') || $this->config->get('klarna_invoice')) {
			$this->document->addScript('http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js');
		}
		 
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_cart'),
			'href' => $this->url->link('checkout/cart')
		);

		$data['breadcrumbs'][] = array(
			'text' => $data['heading_title'],
			'href' => $this->url->link('checkout/checkout', '', 'SSL')
		);
		 
		$data['cur_page_url'] = $this->url->link('checkout/checkout');
		$data['text_cart_order_heading']  = $this->language->get('text_cart_order_heading');
		$data['text_cart_order_summary']  = $this->language->get('text_cart_order_summary');		
		
		$data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');
		$data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['button_continue'] = $this->language->get('button_continue');
		/* echo '<pre>';print_r($this->session->data);echo '</pre>';
		die('test'); */
		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}
		
		$data['logged'] = $this->customer->isLogged();
                
		$current_logged_customer_id = $this->customer->getId();
		if($current_logged_customer_id > 0 ){
                
			$this->load->model('account/address');
		
			$data['addresses'] = $this->model_account_address->getAddresses();
			foreach($data['addresses'] as $key=>$val){
				if(strlen($val['address_1'])<1 ||strlen($val['address_1'])<1){
					
					$this->session->data['error'] = $this->language->get('error_update_address');
					$this->response->redirect($this->url->link('account/address/edit', '', 'SSL').'&address_id='.$key);
				}
			}		 
                
			$cart_data = $this->cart->checkoutStage();
			
			if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){ 
				 
				$this->session->data['error'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname']);
				$this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
			}else{
				$this->load->model('checkout/user_tracking');
				$this->cart->updateCheckoutStage(1,$current_logged_customer_id);
				$this->model_checkout_user_tracking->update($current_logged_customer_id);
				$this->model_checkout_user_tracking->save($current_logged_customer_id);
			}              
		}
                
		if (isset($this->session->data['account'])) {
			$data['account'] = $this->session->data['account'];
		} else {
			$data['account'] = '';
		}
		if(isset($this->session->data['hide_Data'])){
			$data['hide_Data'] = 'hideClass';
		}else{
			$data['hide_Data'] = '';
		}
		
		$data['shipping_required'] = $this->cart->hasShipping();
		$data['current_page_url'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		$data['button_shopping'] = $this->language->get('button_shopping');
		$data['button_checkout'] = $this->language->get('button_checkout');		
		
		$data['api_checkout_process'] = false;
		if(isset($this->session->data['api_checkout_process']) && $this->session->data['api_checkout_process'] === true){
			$data['api_checkout_process'] = true;
		}
		 
		 
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/checkout.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/checkout.tpl', $data));
		}
	}

	public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function customfield() {
		$json = array();

		$this->load->model('account/custom_field');

		// Customer Group
		if (isset($this->request->get['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->get['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->get['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

		foreach ($custom_fields as $custom_field) {
			$json[] = array(
				'custom_field_id' => $custom_field['custom_field_id'],
				'required'        => $custom_field['required']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getUpdatedOrderSummary(){
            
		$this->load->language('checkout/cart');
		
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();	
		$this->load->model('extension/extension');
                
		$result_ship = $this->model_extension_extension->getExtensions('shipping');
		foreach ($result_ship AS $ship_val) {
			if (array_key_exists('code', $ship_val) && $ship_val['code'] == 'free') {
				$free_shipping_status = $this->config->get('free_status');
				$free_total = $this->config->get('free_total');
				if ($free_shipping_status == 1 && (int) $free_total > 0) {
					$text_cart_order_note = sprintf($this->language->get('text_cart_order_note'), $this->currency->format($free_total));
				}
				break;
			}
		}                

		$text_cart_order_summary = $this->language->get('text_cart_order_summary');
		$button_checkout = $this->language->get('button_checkout');
		$checkout = $this->url->link('checkout/checkout', '', 'SSL');
		
		$cart_data = $this->cart->checkoutStage();
		
		$current_logged_customer_id = $this->customer->getId();
		if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
			
			$button_checkout = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname']);
			$checkout  = 'javascript:void(0);';
		}
				//echo '<pre>';print_r($this->session->data);echo '</pre>';
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
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}

			$sort_order = array();

			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $total_data);
		}

		$totals = array();

		foreach ($total_data as $total) {
			$totals[] = array(
				'title' => $total['title'],
				'text'  => $this->currency->format($total['value'])
			);
		}
		
		$total_count = count($totals);
		$iteration	 = 0;
		$li_class	 = '';
		$html = '<h3>'.$text_cart_order_summary.'</h3><ul>';
		foreach ($totals as $total) { 
			$iteration++;
			if($total_count-$iteration==0){
				$li_class = ' class="netpay"';
			}
		
			$html.='<li '.$li_class.'>
				<span class="pull_left">'.$total['title'].':</span>
				<span class="pull_right">'.$total['text'].'</span>
			</li>';
			
		}
                $html.='</ul><div class="padd15 checkout-btn"><p>'.$text_cart_order_note.'</p>';
                $html.='<a href="'.$checkout.'" class="addtocart-btn green checkout_button">'.$button_checkout.'</a></div>';
                $html.='</div>';
		echo $html;
			
	}
        
        
	public function update_info(){
		$this->load->model('checkout/user_tracking');
		$current_logged_customer_id = $this->customer->getId();            
		if($current_logged_customer_id > 0 ){
			$this->model_checkout_user_tracking->update($current_logged_customer_id);
		}
		exit();            
	}

}