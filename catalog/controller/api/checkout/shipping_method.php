<?php
class ControllerAPICheckoutShippingMethod extends Controller {
	public function index() {
		$this->load->language('checkout/checkout');
		$this->load->model('account/address');
		$address_id = $this->request->post['address_id'];
		
		$shipping_methods = $this->getShippingMethod($address_id);
		
		$data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$data['text_shipping_method'] = $this->language->get('text_shipping_method');
		$data['text_comments'] = $this->language->get('text_comments');
		$data['text_loading'] = $this->language->get('text_loading');

		$data['button_continue'] = $this->language->get('button_continue');

		if (empty($shipping_methods)) {
			$data['error_warning'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
		} else {
			$data['error_warning'] = '';
		}
		//print_r($shipping_methods);
		if (isset($shipping_methods)) {
			$data['shipping_methods'] = $shipping_methods;
		} else {
			$data['shipping_methods'] = array();
		}
		
		if (isset($this->session->data['shipping_method']['code'])) {
			$data['code'] = $this->session->data['shipping_method']['code'];
		} else {
			$data['code'] = '';
		}

		if (isset($this->session->data['comment'])) {
			$data['comment'] = $this->session->data['comment'];
		} else {
			$data['comment'] = '';
		}
		$data['status'] = 1;
		$this->response->setOutput(json_encode($data));
		
	}

	public function save() {
		$this->load->language('checkout/checkout');

		$json = array();
		$address_id = $this->request->post['address_id'];
		$shipping_methods = $this->getShippingMethod($address_id);
		// Validate if shipping is required. If not the customer should not have reached this page.
		if (!$this->cart->hasShipping()) {
			$json['status'] = 0;
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}
		
		// Validate if shipping address has been set.
		if (!isset($this->session->data['shipping_address'])) {
			$json['status'] = 0;
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['status'] = 0;
			$json['redirect'] = $this->url->link('checkout/cart');
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
				$json['redirect'] = $this->url->link('checkout/cart');

				break;
			}
		}
		if (!isset($this->request->post['shipping_method'])) {
			$json['error']['warning'] = $this->language->get('error_shipping');
		} else {
			$shipping = explode('.', $this->request->post['shipping_method']);
			
			if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($shipping_methods[$shipping[0]]['quote'][$shipping[1]])) {
				$json['error']['warning'] = $this->language->get('error_shipping');
				$json['status'] = 0;
			}
		}

		if (!$json) {
			$json['shipping_method'] = $shipping_methods[$shipping[0]]['quote'][$shipping[1]];
			
			$json['comment'] = strip_tags($this->request->post['comment']);
			$json['status'] = 1;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getShippingMethod($address_id){
		$shipping_methods = array();
		$this->load->model('account/address');
		$shippingAddress = $this->model_account_address->getAddress($address_id);
		if (isset($shippingAddress)) {
			$method_data = array();
			$this->load->model('extension/extension');
			$results = $this->model_extension_extension->getExtensions('shipping');
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);
					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shippingAddress);
					if ($quote) {
						$method_data[$result['code']] = array(
							'title'      => $quote['title'],
							'quote'      => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
					}
				}
			}
			$sort_order = array();
			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $method_data);
			$shipping_methods = $method_data;
		}
		return $shipping_methods;
	}
}