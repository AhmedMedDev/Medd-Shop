<?php

class ControllerAPICheckoutCart extends Controller {

    public function delete() {

        $this->load->language('checkout/cart');
        $user_id = $cart_id = $actvie_cart_id = 0;

        $this->load->controller('api/common/header');
		
        if (isset($this->request->get['user_id'])) {
            $user_id = (int) $this->request->get['user_id'];
        }
        if (isset($this->request->get['cart_id'])) {
            $cart_id = (int) $this->request->get['cart_id'];
        }
		
        if (intval($user_id) < 1 || intval($cart_id) < 1) {
			
            $data['error'] = $this->language->get('error_invalid_request');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
		}
		
        $logged_user_id = $this->customer->getId();
        $active_cart_id = $this->cart->getActiveCartId();
        $cart_owner_id = $this->cart->getCartOwner();
		
        if ($user_id == $logged_user_id && $cart_owner_id == $user_id ) {
            $this->session->data['error'] = $this->language->get('error_owner_not_allowed');
            $data['error'] = $this->language->get('error_owner_not_allowed').$cart_owner_id;
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }

        if (!$this->cart->checkCartUser($cart_id, $user_id)) {

            //$this->session->data['error'] = $this->language->get('error_unauthorized_access');
            $data['error'] = $this->language->get('error_unauthorized_access');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }
        
        $cart_data = $this->cart->checkoutStage();
        if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']==$user_id){
            
            $data['error'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname']);
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }        

        if (!$this->cart->removeUserFromCart($user_id)) {
           // $this->session->data['error'] = $this->language->get('error_in_removing_user_from_cart');
            $data['error'] = $this->language->get('error_in_removing_user_from_cart');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }

        $this->session->data['success'] = $this->language->get('success_user_removed_from_cart');
        /* if( $cart_owner_id == $logged_user_id ){
            $this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));    
        } */
        //$this->response->redirect($this->url->link('checkout/cart/listing', '', 'SSL'));
        $data['success'] = $this->language->get('success_user_removed_from_cart');;
        $data['status'] = 1;
		echo json_encode($data);
		exit;
    }

    public function update() {

        $this->load->language('checkout/cart');
        $user_id = $cart_id = $actvie_cart_id = 0;

        $this->load->controller('api/common/header');

        if (isset($this->request->get['cart_id'])) {
            $cart_id = (int) $this->request->get['cart_id'];
        }

        if (intval($cart_id) < 1) {
            //$this->session->data['error'] = $this->language->get('error_invalid_request');
            $data['error'] = $this->language->get('error_invalid_request');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }

        $logged_user_id = $this->customer->getId();

        if (!$this->cart->checkCartUser($cart_id, $logged_user_id)) {
            //$this->session->data['error'] = $this->language->get('error_unauthorized_access');
            $data['error'] = $this->language->get('error_unauthorized_access');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }

        if (!$this->cart->updateActiveCart($cart_id)) {
            //$this->session->data['error'] = $this->language->get('error_in_shifting_cart');
            $data['error'] = $this->language->get('error_in_shifting_cart');
            $data['status'] = 0;
			echo json_encode($data);
			exit;
        }

        //$this->session->data['success'] = $this->language->get('success_cart_changed');
		$data['success'] = $this->language->get('success_cart_changed');
		$data['status'] = 1;
		echo json_encode($data);
    }

    public function listing() {

        $this->load->language('checkout/cart');
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('checkout/cart/users', 'SSL');
            $this->response->redirect($this->url->link('account/login', '', 'SSL'));
        }

        if (isset($this->request->post['new_cart']) && $this->request->post['new_cart'] == 'Start New Cart') {
            $logged_user_id = $this->customer->getId();
            $cart_name = $this->request->post['cart_name'];
            $cart_description = $this->request->post['cart_description'];

            if (!$this->cart->createNewCart($cart_name, $cart_description)) {
                $this->session->data['error'] = $this->language->get('error_in_creating_cart');
                $this->response->redirect($this->url->link('checkout/cart/listing', '', 'SSL'));
            }
            $this->session->data['success'] = $this->language->get('success_cart_created');
            $this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
        }
        
        
        if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
            $data['error_warning'] = $this->language->get('error_stock');
        } elseif (isset($this->session->data['error'])) {
            $data['error_warning'] = $this->session->data['error'];

            unset($this->session->data['error']);
        } else {
            $data['error_warning'] = '';
        }

        if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
            $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
        } else {
            $data['attention'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }        


        $cart_data = $this->cart->getAllCarts();

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $data['cart_update_url'] = $this->url->link('checkout/cart/update', '', 'SSL');
        $data['cart_url'] = $this->url->link('checkout/cart', '', 'SSL');
        $data['cart_data'] = $cart_data;


        $data['text_shop_with_friends'] = $this->language->get('text_shop_with_friends');
        $data['text_share_your_cart_with_friends'] = $this->language->get('text_share_your_cart_with_friends');
        $data['text_recent_carts'] = $this->language->get('text_recent_carts');
        $data['text_create_new_cart'] = $this->language->get('text_create_new_cart');
        $data['text_cart_title'] = $this->language->get('text_cart_title');
        $data['text_cart_description'] = $this->language->get('text_cart_description');
        $data['text_start_new_cart'] = $this->language->get('text_start_new_cart');
        $data['text_view_cart'] = $this->language->get('text_view_cart');
        $data['text_cart_items'] = $this->language->get('text_cart_items');


        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/listing.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/listing.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/checkout/listing.tpl', $data));
        }
    }

    public function share_cart() {

        $this->load->language('checkout/cart');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['share_url'] = '';
        if ($this->customer->isLogged()) {
            $active_cart_id = $this->cart->getActiveCartId();
            $share_url = $this->url->link('checkout/cart/share', 'cart_id=' . $active_cart_id, 'SSL');
            $data['share_url'] = $share_url;
        }

        $data['home_url'] = $this->url->link('common/home', '', 'SSL');

        $data['text_invite_people'] = $this->language->get('text_invite_people');
        $data['text_share_this_link'] = $this->language->get('text_share_this_link');
        $data['text_lets_shop'] = $this->language->get('text_lets_shop');


        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/share_cart.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/share_cart.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/checkout/share.tpl', $data));
        }
    }

    public function share() {

        $this->load->language('checkout/cart');
        $cart_id = $this->request->get['cart_id'];
        $cart_sharing_approved = 0;
        $owner_name = '';
		
        if (!$this->customer->isLogged()) {
            $data['error'] = 'Please login to share cart';
            $data['status'] = 0;
        }
		
        if (!$this->cart->isValidCart($cart_id)) {
            //$this->session->data['error'] = $this->language->get('error_invalid_request');
            //$this->response->redirect($this->url->link('checkout/cart/listing', '', 'SSL'));
			$data['error'] = $this->language->get('error_invalid_request');
            $data['status'] = 0;
        }

        $customer_id = $this->customer->getId();

        if ($this->cart->checkCartUser($cart_id, $customer_id)) {
            $this->cart->updateActiveCart($cart_id);            
            $data['error'] = $this->language->get('error_user_already_member');
			$data['status'] = 0;
            //$this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
        }

        if (isset($this->request->post['cart_sharing_approved'])) {
            $cart_sharing_approved = (int) $this->request->post['cart_sharing_approved'];
        }

        if ($cart_sharing_approved == 1) {
            if (!$this->cart->addUserToCart($cart_id)) {
                $this->session->data['error'] = $this->language->get('error_adding_user');
                $this->response->redirect($this->url->link('common/home', '', 'SSL'));
            }
            $data['success'] = $this->language->get('success_user_added_in_cart');
            //$this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
			$data['status'] = 1;
        } else if ($cart_sharing_approved == 2) {
            $data['success'] = $this->language->get('success_cart_sharing_declined');
            $this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
			$data['status'] = 1;
        } else {
            $owner_name = $this->cart->getCartOwnerName($cart_id);
			$data['status'] = 0;
        }

        /* $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header'); */

        $data['text_user_wants_to_shop_with_you'] = sprintf($this->language->get('text_user_wants_to_shop_with_you'), $owner_name);
        $data['text_shop_with_friends'] = $this->language->get('text_shop_with_friends');
        $data['text_shop_with_friend_and_get'] = sprintf($this->language->get('text_shop_with_friend_and_get'), $owner_name);
        $data['text_decline_share_cart'] = $this->language->get('text_decline_share_cart');
        $data['text_join_share_cart'] = $this->language->get('text_join_share_cart');

		
		
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($data));
		
       /*  if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/share.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/share.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/checkout/share.tpl', $data));
        } */
    }

    public function index() {
		
        $this->load->language('checkout/cart');
        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
            $this->load->model('extension/extension');
            $result_ship = $this->model_extension_extension->getExtensions('shipping');
            foreach ($result_ship AS $ship_val) {
                if (array_key_exists('code', $ship_val) && $ship_val['code'] == 'free') {
                    $free_shipping_status = $this->config->get('free_status');
                    $free_total = $this->config->get('free_total');
                    if ($free_shipping_status == 1 && (int) $free_total > 0) {
                        $data['text_cart_order_note'] = sprintf($this->language->get('text_cart_order_note'), $this->currency->format($free_total));
                    }
                    break;
                }
            }

            

            if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
                $data['error_warning'] = $this->language->get('error_stock');
            } elseif (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }

            if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
                $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
            } else {
                $data['attention'] = '';
            }

            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }

            $data['action'] = $this->url->link('checkout/cart/edit', '', true);

            if ($this->config->get('config_cart_weight')) {
                $data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
            } else {
                $data['weight'] = '';
            }

            $this->load->model('tool/image');
            $this->load->model('tool/upload');

            $data['products'] = array();

            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $product_total = 0;

                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $product_total) {
                    $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                }

                if ($product['image']) {
                    $image = $this->model_tool_image->resize($product['image'], 600, 600);
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
                        'name' => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
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

                $recurring = '';

                if ($product['recurring']) {
                    $frequencies = array(
                        'day' => $this->language->get('text_day'),
                        'week' => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month' => $this->language->get('text_month'),
                        'year' => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }

                $data['products'][] = array(
                    'product_id' => $product['product_id'],
                    'mcp_id' => $product['mcp_id'],
                    'cart_id' => $product['cart_id'],
                    'thumb' => $image,
                    'name' => $product['name'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'recurring' => $recurring,
                    'quantity' => $product['quantity'],
                    'stock' => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                    'reward' => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
                    'price' => $price,
                    'total' => $total,
                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );
            }
			
            // Gift Voucher
            $data['vouchers'] = array();
            if (!empty($this->session->data['vouchers'])) {
				
                foreach ($this->session->data['vouchers'] as $key => $voucher) {
                    $data['vouchers'][] = array(
                        'key' => $key,
                        'description' => $voucher['description'],
                        'amount' => $this->currency->format($voucher['amount']),
                        'remove' => $this->url->link('checkout/cart', 'remove=' . $key)
                    );
                }
            }
			
            // Totals
            $this->load->model('extension/extension');

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();
		
			$cart_id = $this->cart->getActiveCartId();
			/*if (isset($this->request->post['cart_id'])) {
				$cart_id = $this->request->post['cart_id'];
			} else {
				$cart_id = '';
			}*/ 
			 
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
						//echo $result['code'];
                        $this->{'model_api_total_' . $result['code']}->getTotal($total_data, $total, $taxes,$cart_id);
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
                    'text' => $this->currency->format($total['value'], '', '', false)
                );
            }
			
            $data['continue'] = $this->url->link('common/home');
            $data['current_page_url'] = $this->url->link('checkout/cart', '', 'SSL');
            $data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

            $this->load->model('extension/extension');

            $data['checkout_buttons'] = array();
            //$files = glob(DIR_APPLICATION . '/controller/total/*.php');

            if ($files) {
                foreach ($files as $file) {
                    $extension = basename($file, '.php');

                    $data[$extension] = $this->load->controller('total/' . $extension);
                }
            }

            $cart_data = $this->cart->checkoutStage();
            $current_logged_customer_id = $this->customer->getId();
            if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
                $data['button_checkout'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname']);
                $data['checkout'] = 'javascript:void(0);';
            }
			/* print_r($data); */
            $data['status'] = 1;
			$this->response->setOutput(json_encode($data));
          
        } else {

            

            $data['continue'] = $this->url->link('common/home');
            if (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }
            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }
			$data['status'] = 0;
            $this->response->setOutput(json_encode($data));
        }
    }

    public function add() {
		
        $this->load->language('checkout/cart');
		$json = array();
		
        $error_data = '';        
        $cart_data = $this->cart->checkoutStage();
		$current_logged_customer_id = $this->customer->getId();
		
		if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
			
            $this->session->data['error'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname'].' '.$this->language->get('text_please_wait_to_complete'));
            $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
        }else{
				
			    if (isset($this->request->post['product_id'])) {
                    $product_id = (int) $this->request->post['product_id'];
                } else {
                    $product_id = 0;
                }
                
                if (isset($this->request->post['product_page'])) {
                    $product_page = $this->request->post['product_page'];

                } else {
                    $product_page = false;
                }
				$this->load->model('catalog/product');
				$product_info = $this->model_catalog_product->getProduct($product_id);
				$cart_products = $this->cart->getProducts();
                $qdata = array();
                if(!empty($cart_products)){
                    foreach ($cart_products as $product) {
                        $qdata[$product['product_id']] = $product['quantity'];
                    }
                }
                
                
				$proceed_to_cart = true;
				if ($product_info) {
					
                    $q = 0;                    
                    if(array_key_exists($product_id,$qdata)){                        
                        $q = $qdata[$product_id];
                    }                    
                   
                    $total_asked_quantity = (int)$this->request->post['quantity'] + $q;
                    
					if($product_info['quantity'] == 0 ){
						$proceed_to_cart = false;
						$json['error'] = $this->language->get('error_stock_app'); 
						$json['status'] = 0;
					} 
                    else if((int)$product_info['quantity'] < $total_asked_quantity){
                        $proceed_to_cart = false;
						$json['error'] =sprintf($this->language->get('error_stock_available'), $product_info['quantity']);
						$json['status'] = 0;
                    }
                    /*we can remove this else if */
                    /* elseif ( (int)$product_info['quantity'] < (int)$this->request->post['quantity']){
						$proceed_to_cart = false;
						$json['error'] =sprintf($this->language->get('error_stock_available'), $product_info['quantity']);
						$json['status'] = 0;
					} */
                    else {
					
						if (isset($this->request->post['quantity']) && ((int) $this->request->post['quantity'] >= $product_info['minimum'])) {
							$quantity = (int) $this->request->post['quantity'];
						} else {
							$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
						}
					}
				} else {
					$proceed_to_cart = false;
					$json['error'] = $this->language->get('error_invalid_request');
					$json['status'] = 0;
				}
				
				if ($proceed_to_cart == true) {
                    if (isset($this->request->post['quantity']) && ((int) $this->request->post['quantity'] >= $product_info['minimum'])) {
                        $quantity = (int) $this->request->post['quantity'];
                    } else {
                        $quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
                    }

                    if (isset($this->request->post['option'])) {
                        $option = array_filter($this->request->post['option']);
						
                    } else {
						
                        $option = array();
                    }
					
                    $product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);
					
                    foreach ($product_options as $product_option) {
						
                        if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                            /* $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']); */
                            $error_data = sprintf($this->language->get('error_required'), $product_option['name']); 
							
							//$json['error'] = 'Please fill all the required options.';
							$json['status'] = 0;
                        }
                    }
					
                    if (isset($this->request->post['recurring_id'])) {
                        $recurring_id = $this->request->post['recurring_id'];
                    } else {
                        $recurring_id = 0;
                    }

                    $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);
					
                    if ($recurrings) {
                        $recurring_ids = array();

                        foreach ($recurrings as $recurring) {
                            $recurring_ids[] = $recurring['recurring_id'];
                        }

                        if (!in_array($recurring_id, $recurring_ids)) {
                            /* $json['error']['recurring'] = $this->language->get('error_recurring_required'); */
							$json['error'] = $this->language->get('error_recurring_required');
							$json['status'] = 0;
                        }
                    }
					
                    if (!$json) {
						
                        $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

                        $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

                        // Totals
                        $this->load->model('extension/extension');

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

                       // $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
                        $json['total'] = sprintf($this->language->get('text_items'), $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
						//$json['count_product'] = $this->cart->countProducts();
						$json['count_product'] = $this->cart->hasProducts();
						$json['status'] = 1;
					} else {
						
						if(!$product_page){
							$this->session->data['error'] = $error_data;
						}                    
                        $json['error'] = $error_data;
						$json['status'] = 0;
                        //$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
                    }
					
                }
        }
		
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function edit() {
        $this->load->language('checkout/cart');
        
        $json = array();
		
		$product_id = 0;
		$products = $this->cart->getProducts();
		foreach ($products as $product) {
			if ($this->request->post['mcp_id'] == $product['mcp_id'] ){
				$product_id = (int) $product['product_id'];
			}
		}
	 	
        // Update
        if (array_key_exists('quantity', $this->request->post)) {
             
			$quantity =  (int)$this->request->post['quantity'];
			
			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
            $cart_products = $this->cart->getProducts();
            $qdata = array();
            if(!empty($cart_products)){
                foreach ($cart_products as $product) {
                    $qdata[$product['product_id']] = $product['quantity'];
                }
            }
			
			$proceed_to_cart = true;
			if ($product_info) {
            
                $q = 0;                    
                if(array_key_exists($product_id,$qdata)){                        
                    $q = $qdata[$product_id];
                }                    
               
                $total_asked_quantity = (int)$this->request->post['quantity'] + $q;
				
				if($product_info['quantity'] == 0 ){
					$proceed_to_cart = false;
					$json['error'] = $this->language->get('error_stock_app'); 
					$json['status'] = 0;
				} 
                else if((int)$product_info['quantity'] < $total_asked_quantity){
                    $proceed_to_cart = false;
                    $json['error'] =sprintf($this->language->get('error_stock_available'), $product_info['quantity']);
                    $json['status'] = 0;
                }
                /* elseif ( (int)$product_info['quantity'] < (int)$this->request->post['quantity']){
					$proceed_to_cart = false;
					$json['error'] =sprintf($this->language->get('error_stock_available'), $product_info['quantity']);
					$json['status'] = 0;
				} */
                else {
				
					if (isset($this->request->post['quantity']) && ((int) $this->request->post['quantity'] >= $product_info['minimum'])) {
						$quantity = (int) $this->request->post['quantity'];
					} else {
						$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
					}
				}
			} else {
				$proceed_to_cart = false;
				$json['error'] = $this->language->get('error_invalid_request');
				$json['status'] = 0;
			}
			
			if($proceed_to_cart== true){
				$cart_data = $this->cart->checkoutStage();
				$current_logged_customer_id = $this->customer->getId();
				if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
					$data['error'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname'].' '.$this->language->get('text_please_wait_to_complete'));
					$data['status'] = 0;
					echo json_encode($data);
					exit;				
				}else{
				   
					$this->cart->update($this->request->post['mcp_id'], $quantity);
					$json['success'] = $this->language->get('text_remove');
					
					//$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
					$json['total'] = sprintf($this->language->get('text_items'), $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
					//$json['count_product'] = $this->cart->countProducts();
					$json['count_product'] = $this->cart->hasProducts();
					$json['status'] = 1;
				}
			}
            //$this->response->redirect($this->url->link('checkout/cart'));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function remove() {
        $this->load->language('checkout/cart');

        $json = array();
        
        // Remove
        if (isset($this->request->post['mcp_id'])) {
            
            $cart_data = $this->cart->checkoutStage();
            $current_logged_customer_id = $this->customer->getId();
            if(isset($cart_data['mc_current_stage']) && ($cart_data['mc_current_stage']==1 || $cart_data['mc_current_stage']==2 )&& $cart_data['mc_checkout_by_user']!=$current_logged_customer_id){
                $data['error'] = sprintf($this->language->get('text_checkout_in_process'),$cart_data['firstname'].' '.$cart_data['lastname'].' '.$this->language->get('text_please_wait_to_complete'));
				$data['status'] = 0;
				echo json_encode($data);
				exit;				
            }else{
				$this->cart->remove($this->request->post['mcp_id']);
            }            

            $json['success'] = $this->language->get('text_remove');

            // Totals
            $this->load->model('extension/extension');

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

            //$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
            $json['total'] = sprintf($this->language->get('text_items'), $this->cart->hasProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        }
		$json['status'] = 1;
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function cart_listing_update() {

        $this->load->language('checkout/cart');

        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->addStyle('catalog/view/theme/growcer/css/jQueryTab.css');
        $this->document->addStyle('catalog/view/theme/growcer/css/animation.css');
        $this->document->addScript('catalog/view/theme/growcer/js/jQueryTab.js');
        $this->document->addScript('catalog/view/theme/growcer/js/classie.js');
        $this->document->addScript('catalog/view/theme/growcer/js/modalEffects.js');
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home')
        );

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('checkout/cart'),
            'text' => $this->language->get('heading_title')
        );


        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_recurring_item'] = $this->language->get('text_recurring_item');
            $data['text_next'] = $this->language->get('text_next');
            $data['text_next_choice'] = $this->language->get('text_next_choice');

            $data['text_cart_order_heading'] = $this->language->get('text_cart_order_heading');
            $data['text_cart_order_summary'] = $this->language->get('text_cart_order_summary');

            $this->load->model('extension/extension');
            $result_ship = $this->model_extension_extension->getExtensions('shipping');
            foreach ($result_ship AS $ship_val) {
                if (array_key_exists('code', $ship_val) && $ship_val['code'] == 'free') {
                    $free_shipping_status = $this->config->get('free_status');
                    $free_total = $this->config->get('free_total');
                    if ($free_shipping_status == 1 && (int) $free_total > 0) {
                        $data['text_cart_order_note'] = sprintf($this->language->get('text_cart_order_note'), $this->currency->format($free_total));
                    }
                    break;
                }
            }

            $data['column_image'] = $this->language->get('column_image');
            $data['column_name'] = $this->language->get('column_name');
            $data['column_model'] = $this->language->get('column_model');
            $data['column_quantity'] = $this->language->get('column_quantity');
            $data['column_price'] = $this->language->get('column_price');
            $data['column_total'] = $this->language->get('column_total');

            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_update'] = $this->language->get('button_update');
            $data['button_remove'] = $this->language->get('button_remove');
            $data['button_shopping'] = $this->language->get('button_shopping');
            $data['button_checkout'] = $this->language->get('button_checkout');

            if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
                $data['error_warning'] = $this->language->get('error_stock');
            } elseif (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }

            if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
                $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
            } else {
                $data['attention'] = '';
            }

            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }

            $data['action'] = $this->url->link('checkout/cart/edit', '', true);

            if ($this->config->get('config_cart_weight')) {
                $data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
            } else {
                $data['weight'] = '';
            }

            $this->load->model('tool/image');
            $this->load->model('tool/upload');

            $data['products'] = array();

            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $product_total = 0;

                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $product_total) {
                    $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                }

                if ($product['image']) {
                    $image = $this->model_tool_image->resize($product['image'], 600, 600);
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
                        'name' => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
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

                $recurring = '';

                if ($product['recurring']) {
                    $frequencies = array(
                        'day' => $this->language->get('text_day'),
                        'week' => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month' => $this->language->get('text_month'),
                        'year' => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }

                $data['products'][] = array(
                    'product_id' => $product['product_id'],
                    'mcp_id' => $product['mcp_id'],
                    'cart_id' => $product['cart_id'],
                    'thumb' => $image,
                    'name' => $product['name'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'recurring' => $recurring,
                    'quantity' => $product['quantity'],
                    'stock' => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                    'reward' => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
                    'price' => $price,
                    'total' => $total,
                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );
            }

            // Totals
            $this->load->model('extension/extension');

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

            $data['totals'] = array();

            foreach ($total_data as $total) {
                $data['totals'][] = array(
                    'title' => $total['title'],
                    'text' => $this->currency->format($total['value'])
                );
            }

            $data['continue'] = $this->url->link('common/home');
            $data['current_page_url'] = $this->url->link('checkout/cart', '', 'SSL');
            $data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

            $this->load->model('extension/extension');

            $data['checkout_buttons'] = array();

            $files = glob(DIR_APPLICATION . '/controller/total/*.php');

            if ($files) {
                foreach ($files as $file) {
                    $extension = basename($file, '.php');

                    $data[$extension] = $this->load->controller('total/' . $extension);
                }
            }

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            
            $this->load->language('total/reward');
            $data['entry_reward'] = $this->language->get('heading_title');
            $data['button_reward'] = $this->language->get('button_reward');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart_listing_update.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/cart_listing_update.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/checkout/cart_listing_update.tpl', $data));
            }
        } else {

            $data['heading_title'] = $this->language->get('heading_title');

            $data['text_error'] = $this->language->get('text_empty');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');
            if (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }
            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }
			print_r($data);
        }
        
        
    }            
    

}
