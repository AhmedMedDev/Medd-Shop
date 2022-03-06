<?php
class ControllerCommonHeader extends Controller {
	public function index() {

		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('analytics/' . $analytic['code']);
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		/****** Message System Starts *****/
		$this->language->load('account/message');
		$data['text_message_system'] = $this->language->get('text_message_system');
		$data['message_system'] = $this->url->link('account/message');
		$filter_data =array(
			'filter_sender'   => 'user',
			'filter_status'   => '0',
			'customer_id'     => $this->customer->getId(),
		);
		$this->load->model('account/message');
		$data['alert_messages'] = $this->model_account_message->getTotalUnreadMessages($filter_data);

		/****** Message System Ends *****/
		$config_demo_store = $this->config->get('config_demo_store');
		$language_id = (int)$this->config->get('config_language_id');
		if(!empty($config_demo_store)){
			$current_language_ar = $config_demo_store[$language_id];
			if($current_language_ar['status']==1){
				$demo_store_message = $current_language_ar['message'];
				$data['demo_store_message'] = $demo_store_message;
			}
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();

		if((!isset($this->request->get['route'])) || (isset($this->request->get['route']) && $this->request->get['route']=='common/home') ){
			$data['page_route'] = 'home';//do not add inner page style on home page.
		}

		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_logo_mobile'))) {
			$data['logo_mobile'] = $this->config->get('config_logo_mobile');
		} else {
			if(isset($data['logo']) && $data['logo']!=''){
				$data['logo_mobile'] = $data['logo'];
			}else{
				$data['logo_mobile'] = '';
			}
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');
		$data['text_welcome_home'] = $this->language->get('text_welcome_home');

		$data['welcome_username'] = 'Visitor';

		// Wishlist
		if ($this->customer->isLogged()) {
			$data['welcome_username'] = $this->customer->getFirstName().' '.$this->customer->getLastName();
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$data['compareTotal'] = (isset($this->session->data['compare'])) ? $this->session->data['compare'] : array();
		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));


		if ($this->customer->isLogged()) {
		$data['welcome_username'] = $this->customer->getFirstName().' '.$this->customer->getLastName();
		}

		$data['text_account'] = $this->language->get('text_account');
		$data['text_affiliate_account'] = $this->language->get('text_affiliate_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_affiliate_logout'] = $this->language->get('text_affiliate_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_category_menu'] = $this->language->get('text_category_menu');
		$data['text_category_view_all'] = $this->language->get('text_category_view_all');
		$data['text_category_more'] = $this->language->get('text_category_more');
		$data['shop_with_friends'] = $this->language->get('shop_with_friends');
		$data['share_cart_txt'] = $this->language->get('share_cart_txt');


		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['compare'] = $this->url->link('product/compare', '', 'SSL');
		$data['logged'] = $this->customer->isLogged();
		$data['aff_account'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['aff_logged'] = $this->affiliate->isLogged();
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['listing'] = $this->url->link('checkout/cart/listing', '', 'SSL');
		$data['share_cart'] = $this->url->link('checkout/cart/share_cart', '', 'SSL');


		$data['aff_logout'] = $this->url->link('affiliate/logout', '', 'SSL');
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['contact'] = $this->url->link('information/contact');
		$data['view_all_categories'] = $this->url->link('product/category/viewall');

		$data['telephone'] = $this->config->get('config_telephone');

		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 3

				$children_data = array();
				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {

						// Level 2
						$children_children_data = array();

						$children_children = $this->model_catalog_category->getCategories($child['category_id']);

						/* $filter_data = array(
							'filter_category_id'  => $child['category_id'],
							'filter_sub_category' => true
						); */

						if(count($children_children)>0){

							foreach ($children_children as $child_child) {
								/* $filter_data = array(
									'filter_category_id'  => $child_child['category_id'],
									'filter_sub_category' => true
								);
								($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : '')
								*/

								$children_children_data[] = array(
									'name'  => $child_child['name'],
									'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child_child['category_id'])
								);
							}

						}


				    $children_data[] = array(
						'name'  => $child['name'],
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),
						'children' => $children_children_data,
						'column'   => $child['column'] ? $child['column'] : 1
					);

				}

				// Level 1
				$data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}
		//echo "<pre>".print_r($data['categories'], true); die;
		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		$data['og_thumb'] = '';
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
			$product_info = $this->model_catalog_product->getProduct($product_id);
			//$this->data['product_info'] = $product_info;
			if ($product_info['image']) {
				$data['og_thumb'] = $this->model_tool_image->resize($product_info['image'], 300, 300);
			}

		}

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		$data['api_checkout_process'] = false;
		if(isset($this->session->data['api_checkout_process']) && $this->session->data['api_checkout_process'] === true){
			$data['api_checkout_process'] = true;
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}
}
