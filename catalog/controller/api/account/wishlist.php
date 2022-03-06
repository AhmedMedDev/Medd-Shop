<?php
class ControllerAPIAccountWishList extends Controller {
	public function index() {
		
		$this->load->controller('api/common/header');
		$this->load->language('account/wishlist');
		$this->load->model('account/wishlist');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$this->load->model('account/customer');		
		$this->load->model('account/address');
		
		$currentCustomerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		
		if ($this->config->get('config_tax_customer') == 'payment') {
			$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
		}

		if ($this->config->get('config_tax_customer') == 'shipping') {
			$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
		}
		
		if (isset($this->request->get['remove'])) {
			// Remove Wishlist
			$this->model_account_wishlist->deleteWishlist($this->request->get['remove']);
			$data['success_remove'] = $this->language->get('text_remove');
		}
		
		if (isset($this->request->post['currency'])) {
			$currentCurrency = $this->currency->getCurrentCurrency($this->request->post['currency']);
		}else{
			$currentCurrency = $this->currency->getCurrentCurrency($this->currency->getCurrency());
		}
		
		
		$this->document->setTitle($this->language->get('heading_title'));

		

		$data['products'] = array();
		$wishlist_product_removed = false;
		
		$results = $this->model_account_wishlist->getWishlist();
		
	
		foreach ($results as $result) {
			$product_info = $this->model_catalog_product->getProduct($result['product_id']);

			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], 600,600);
				} else {
					$image = false;
				}

				if ($product_info['quantity'] <= 0) {
					$stock = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $product_info['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), '', '', false);
				} else {
					$price = false;
				}

				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), '', '', false);
				} else {
					$special = false;
				}
				
				$option['options'] = array();
				
				$getProductOptions = $this->model_catalog_product->getProductOptions($product_info['product_id']);
				
				foreach ($getProductOptions as $getProductOption) {
					$product_option_value_data = array();
					
					foreach ($getProductOption['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$optionPrice = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), '', '', false);
							} else {
								$optionPrice = false;
							}

							$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
								'currency'    => $currentCurrency,
								'price'                   => $optionPrice,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}

					$option['options'][] = array(
						'product_option_id'    => $getProductOption['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $getProductOption['option_id'],
						'name'                 => $getProductOption['name'],
						'type'                 => $getProductOption['type'],
						'value'                => $getProductOption['value'],
						'required'             => $getProductOption['required'],
					);
				}
				
				
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'thumb'      => $image,
					'name'       => $product_info['name'],
					'model'      => $product_info['model'],
					'currency'    => $currentCurrency,
					'stock'      => $stock,
					'minimum'    => $product_info['minimum'],
					'price'      => $price,
					'special'    => $special,
					'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
					'remove'     => $this->url->link('account/wishlist', 'remove=' . $product_info['product_id']),
					'options'        => $option['options']
				);
			} else {
				$this->model_account_wishlist->deleteWishlist($result['product_id']);
				$wishlist_product_removed =  true;
			}
		}
		
		
		if( $wishlist_product_removed ){
			$this->session->data['error'] = 'Product removed!';
			$this->response->redirect($this->url->link('account/wishlist', '', 'SSL'));		
		
		}
		
		$data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		$data['status'] = 1;
		
		$this->response->setOutput(json_encode($data));
		
	}

	public function add() {
		$this->load->language('api/account/wishlist');
		$this->load->model('api/account/wishlist');
		$currentCustomerId = $this->model_api_account_wishlist->getCustomerIdByToken($this->request->post['token']);
		
		//$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if ($currentCustomerId) {
				// Edit customers cart
				$this->load->model('account/wishlist');

				$this->model_account_wishlist->addWishlist($this->request->post['product_id']);

				$json['success'] = sprintf($this->language->get('plain_text_success'), $product_info['name']);

				$json['total'] = sprintf($this->language->get('text_wishlist'), $this->model_api_account_wishlist->getTotalWishlist($currentCustomerId));
			} else {
				if (!isset($this->session->data['wishlist'])) {
					$this->session->data['wishlist'] = array();
				}

				$this->session->data['wishlist'][] = $this->request->post['product_id'];

				$this->session->data['wishlist'] = array_unique($this->session->data['wishlist']);

				$json['success'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'), $this->url->link('product/product', 'product_id=' . (int)$this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));

				$json['total'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
			}
		}
		$json['status'] = 1;
		$this->response->setOutput(json_encode($json));
	}
}
