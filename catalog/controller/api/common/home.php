<?php
class ControllerApiCommonHome extends Controller {

	public function index() {

		$json = array();
		static $module = 0;

		$this->load->model('account/api');
		$this->load->language('api/home');
		$this->load->model('design/layout');
		$this->load->model('catalog/manufacturer');
		$this->load->model('account/wishlist');
		$this->load->model('api/account/customer');
		$this->load->model('tool/image');
		$this->load->model('api/account/message');

		// Check if IP is allowed
		//echo $this->currency->getCurrency();
		//print_r($abc['currency']);
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			// Login with API Key

			$api_info = $this->model_account_api->getApiByKey( $this->request->post[ 'key' ] );
			if ($api_info) {

					if (isset($this->request->get['route'])) {
						$route = (string)$this->request->get['route'];
					} else {
						$route = 'api/common/home';
					}
					$layout_id = 0;

					if ($route == 'product/category' && isset($this->request->get['path'])) {
						$this->load->model('catalog/category');
						$path = explode('_', (string)$this->request->get['path']);
						$layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
					}

					if ($route == 'product/product' && isset($this->request->get['product_id'])) {
						$this->load->model('catalog/product');

						$layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
					}

					if ($route == 'information/information' && isset($this->request->get['information_id'])) {
						$this->load->model('catalog/information');

						$layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
					}

					if (!$layout_id) {

						$layout_id = $this->model_design_layout->getLayout($route);

					}

					if (!$layout_id) {
						$layout_id = $this->config->get('config_layout_id');
					}

					$this->load->model('extension/module');

					$data['modules'] = array();

					$modules = $this->model_design_layout->getLayoutModules($layout_id, 'content_top');
					$dsignModules = array('slideshow','popular','anylist','featured');
					/* print_r($modules); */
					foreach ($modules as $module) {

						$part = explode('.', $module['code']);


						if(array_intersect($dsignModules, $part)){
							//echo $part[0];
							if (isset($part[0]) && $this->config->get($part[0] . '_status')) {

								$data['modules'][] = $this->load->controller('api/module/' . $part[0]);
							}

							if (isset($part[1])) {
								$setting_info = $this->model_extension_module->getModule($part[1]);
								//print_r($setting_info);
								if ($setting_info && $setting_info['status']) {
									//print_r($setting_info);
									if($part[0]=='popular'){
										//echo 'api/common/' . $part[0];
										//var_dump( $this->load->controller('api/common/' . $part[0], $setting_info));die;
									}
									$data['modules'][$part[0]] = $this->load->controller('api/common/' . $part[0], $setting_info);

									//break;
								}
							}
						}
					}

					$data['modules']['categories'] = $this->load->controller('api/common/category');

					$results = $this->model_catalog_manufacturer->getManufacturers();
					//echo '<pre>';print_r($results);echo '</pre>';


					foreach ($results as $result) {
						$data['footer_manufacturers'][] = array(
							'name' => $result['name'],
							'image' => $this->model_tool_image->resize($result['image'], 126, 60),
							'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
						);
					}
					if(!empty($this->request->post['token'])){
						$apiLoggedIn = $this->model_account_api->verifyToken($this->request->post['token']);
						if($apiLoggedIn){
							$filter_data =array(
								'customer_id' => $this->customer->getId(),
								'filter_sender' => 'user',
								'filter_status' => '0',
							);

							$messageCount = $this->model_api_account_message->getTotalUnreadMessages($filter_data);
							$json['unread_message'] = $messageCount;
						}else{
							$json['unread_message'] = '0';
						}
					}else{
						$json['unread_message'] = '0';
					}

					$currentCurrencyType = $this->model_api_account_customer->getCustomer($this->customer->getId());
					//echo $this->config->get('config_language_id');
					if($currentCurrencyType['currency']){
						$currency = $currentCurrencyType['currency'];
					}else{
						$currency = $this->currency->getCurrency();
					}

					$json['newsletter'] = $currentCurrencyType['newsletter'];
					$json['currency_type'] = $currency;
					$json['language'] = $currentCurrencyType['language'];
					$json['cart_count'] = $this->cart->hasProducts();
					$json['compare_count'] = $this->customer->getCompareCount();
					$json['wishlist_count'] = $this->model_account_wishlist->getTotalWishlist();
					$json['status'] = 1; 
					$json['data'] = $data;
			} else {
				$json['status'] = 0;
				$json['error']['key'] = $this->language->get('error_key');
			}

		}else{
			$json['status'] = 0;
			$json['error'] = $this->error;
		}
		/* print_r($json); */
		$this->response->setOutput(json_encode($json));
	}
}
