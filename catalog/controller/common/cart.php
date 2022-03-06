<?php
class ControllerCommonCart extends Controller {

	public function index() {
		$this->load->language('common/cart');

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

		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();

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

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_share_link_to_invite'] = $this->language->get('text_share_link_to_invite');                
		$data['text_user_offline'] = $this->language->get('text_user_offline');                
		$data['text_user_online'] = $this->language->get('text_user_online');                
                
		$data['text_cart'] = $this->language->get('text_cart');
		$data['your_cart_text'] = $this->language->get('your_cart_text');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_recurring'] = $this->language->get('text_recurring');
		//$data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        $data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
			
			
        //$data['products_count'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
        $data['products_count'] = $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
        
        
		$data['products_total_price'] = $this->currency->format($total); 
		$data['products_text_items'] = $this->language->get('products_text_items');
		
		
		$data['text_loading'] = $this->language->get('text_loading');

		$data['button_remove'] = $this->language->get('button_remove');
		$data['copy_link'] = $this->language->get('copy_link');

		$this->load->model('tool/image');
		$this->load->model('tool/upload');
                
                $data['cart_users'] = $this->cart->getAllCartUsers();
                $data['cart_owner'] =  $this->cart->getCartOwner();

		$data['products'] = array();

		foreach ($this->cart->getProducts() as $product) {

			if ($product['image']) {
				$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
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
				$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
			} else {
				$total = false;
			}

			$data['products'][] = array(
				'cart_id'   => $product['cart_id'],
				'firstname' => $product['firstname'],			
				'added_by'  => $product['added_by'],				
				'mcp_id'    => $product['mcp_id'],				
				'thumb'     => $image,
				'name'      => $product['name'],
				'model'     => $product['model'],
				'option'    => $option_data,
				'recurring' => ($product['recurring'] ? $product['recurring']['name'] : ''),
				'quantity'  => $product['quantity'],
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
					'amount'      => $this->currency->format($voucher['amount'])
				);
			}
		}

		$data['totals'] = array();

		foreach ($total_data as $result) {
			$data['totals'][] = array(
				'title' => $result['title'],
				'text'  => $this->currency->format($result['value']),
			);
		}

		$data['cart'] = $this->url->link('checkout/cart');
		$data['shop_with_friends'] = $this->language->get('shop_with_friends');
		$data['show_friends'] = $this->language->get('show_friends');
		$data['hide_friends'] = $this->language->get('hide_friends');
		$data['logged'] = $this->customer->isLogged();
		
		$data['share_cart_show_friend_status'] = $this->customer->getShareCartShowFriendStatus();
				
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
                        $share_url = $this->url->link('checkout/cart/share', 'cart_id='.$active_cart_id, 'SSL');    
                    }else{
                        $share_url = '';
                    }
                    
                    $data['share_url'] = $share_url;
                }
                
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/cart.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/cart.tpl', $data);
		} else {
			return $this->load->view('default/template/common/cart.tpl', $data);
		}
	}

	public function info() {
		$this->response->setOutput($this->index());
	}
    
	public function error_app() { 
		$data['error_warning'] = $this->session->data['error_warning'];
		$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/error-app.tpl', $data));
	}
        
}
