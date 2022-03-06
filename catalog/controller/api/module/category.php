<?php
	class ControllerAPIModuleCategory extends Controller {
		public function index() {
			$this->load->language('module/category');
			$this->load->model('tool/image');
			$this->load->model('account/api');
			$this->load->model('account/wishlist');
			$this->load->model('api/account/wishlist');
			$this->load->model('api/account/address');
			$this->load->model('api/account/message');
			$this->load->model('account/customer');
			$this->load->model('account/address');

			$data['heading_title'] = $this->language->get('heading_title');
			$data['cart_count'] = $this->cart->hasProducts();
			$data['compare_count'] = $this->customer->getCompareCount();
			$data['wishlist_count'] = $this->model_account_wishlist->getTotalWishlist();

			$currentCustomerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);

			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if ($this->config->get('config_tax_customer') == 'shipping') {
				$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if (isset($this->request->get['path'])) {
				$parts = explode('_', (string)$this->request->get['path']);
				} else {
				$parts = array();
			}

			if (isset($this->request->post['currency'])) {
				$currentCurrency = $this->currency->getCurrentCurrency($this->request->post['currency']);
				}else{
				$currentCurrency = $this->currency->getCurrentCurrency($this->currency->getCurrency());
			}

			if (isset($parts[0])) {
				$data['category_id'] = $parts[0];
				} else {
				$data['category_id'] = 0;
			}

			if (isset($parts[1])) {
				$data['child_id'] = $parts[1];
				} else {
				$data['child_id'] = 0;
			}

			if (isset($parts[2])) {
				$data['child_child_id'] = $parts[2];
				} else {
				$data['child_child_id'] = 0;
			}


			$this->load->model('catalog/category');

			$this->load->model('catalog/product');



			if($this->request->get['category_id']){
				$categories_2 = $this->model_catalog_category->getCategories($this->request->get['category_id']);
				foreach ($categories_2 as $category_2) {
					//print_r($category_2);
					//echo HTTP_SERVER_IMAGE;
					$categoryImage = '';
					if($category_2['image']){
						$categoryImage = HTTP_SERVER_IMAGE.$category_2['image'];
					}

					$filter_data = array('filter_category_id' => $category_2['category_id'], 'filter_sub_category' => true);
					$data['subcategories'][] = array(
					'category_id' => $category_2['category_id'],
					'name'        => $category_2['name']. ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' 		  => str_replace('&amp;', '&', $this->url->link('product/category','path=' . $category_1['category_id'] . '_' . $category_2['category_id'])),
					'category_image' => $categoryImage,
					);

				}
				if (isset($this->request->get['price_range'])) {
					$price_range = $this->request->get['price_range'];
					} else {
					$price_range = '';
				}
				if (isset($this->request->get['mid'])) {
					$mid = $this->request->get['mid'];
					$temp = explode(",", $mid);
					foreach($temp AS $tik=>$tid){
						if ((is_int($tid) || ctype_digit($tid)) && (int)$tid > 0 )  continue;
						unset($temp[trim($tik)]);
					}
					$mid = implode(",", $temp);
					} else {
					$mid = '';
				}
				if (isset($this->request->get['filter'])) {
					$filter = $this->request->get['filter'];
					} else {
					$filter = '';
				}
				if (isset($this->request->get['sort'])) {
					$sort = $this->request->get['sort'];
					} else {
					$sort = 'p.sort_order';
				}
				if (isset($this->request->get['order'])) {
					$order = $this->request->get['order'];
					} else {
					$order = 'ASC';
				}
				if (isset($this->request->get['page'])) {
					$page = $this->request->get['page'];
					} else {
					$page = 1;
				}

				if (isset($this->request->get['limit'])) {
					$limit = (int)$this->request->get['limit'];
					} else {
					$limit = $this->config->get('config_product_limit');
				}
				$filter_data = array(
				'filter_category_id' => $this->request->get['category_id'],
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
				);
				if(isset($price_range) && $price_range!=''){
					$filter_data['price_range'] = $price_range;
				}
				if(isset($mid) && $mid!=''){
					$filter_data['mid'] = $mid;
				}
				$product_total = $this->model_catalog_product->getTotalProducts($filter_data);
				$data['total_pages'] = ceil($product_total / $limit);
				$data['product_total'] = $product_total;
				$data['cart_count'] = $this->cart->hasProducts();
				$data['compare_count'] = $this->customer->getCompareCount();
				$data['wishlist_count'] = $this->model_account_wishlist->getTotalWishlist();
				$productsData = $this->model_catalog_product->getProducts($filter_data);
				foreach($productsData as $productData){
					if ($productData['image']) {
						$image = $this->model_tool_image->resize($productData['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$unitPrice = $this->tax->calculate($productData['price'], $productData['tax_class_id'], $this->config->get('config_tax'), '', '', false);
						} else {
						$unitPrice = false;
					}

					if ((float)$productData['special']) {
						$special = $this->tax->calculate($productData['special'], $productData['tax_class_id'], $this->config->get('config_tax'), '', '', false);
						} else {
						$special = false;
					}


					if ($this->config->get('config_tax')) {
						$tax = (float)$productData['special'] ? $productData['special'] : $productData['price'];
						} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = (int)$productData['rating'];
						} else {
						$rating = false;
					}


					$wishlistResults = $this->model_account_wishlist->getWishlist();
					//echo '<pre>';print_r($wishlistResults);echo '<pre>';


					$option['options'] = array();
					$getProductOptions = $this->model_catalog_product->getProductOptions($productData['product_id']);

					$WishlistProduct = $this->model_api_account_wishlist->getProductWishlist($productData['product_id']);
					if($WishlistProduct){
						$WishlistProduct = 1;
						}else{
						$WishlistProduct = 0;
					}

					foreach ($getProductOptions as $getProductOption) {
						$product_option_value_data = array();
						if($getProductOption['type']=='file'){
							continue;
						}
						foreach ($getProductOption['product_option_value'] as $option_value) {
							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
								if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
									$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), '', '', false);
									} else {
									$price = false;
								}

								$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
								'price'                   => $price,
								'currency'   			  => $currentCurrency,
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

					if ($productData['quantity'] <= 0) {
						$stock = $productData['stock_status'];
					} elseif ($this->config->get('config_stock_display')) {
						$stock = $productData['quantity'];
					} else {
						$stock = $this->language->get('text_instock');
					}

					$data['products'][] = array(
					'product_id'  => $productData['product_id'],
					'thumb'       => $image,
					'full_image'  => HTTP_SERVER_IMAGE.$productData['image'],
					'name'        => $productData['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($productData['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'currency'    => $currentCurrency,
					'wishlist_product' => $WishlistProduct,
					'price'       => $unitPrice,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $productData['minimum'] > 0 ? $productData['minimum'] : 1,
					'rating'      => $productData['rating'],
					'href'        => str_replace('&amp;', '&', $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $productData['product_id'] . $url)),
					'options'        => $option['options'],
					'stock'        => $stock,
					);
				}
				$url = '';

				if (isset($this->request->get['filter'])) {
					$url .= '&filter=' . $this->request->get['filter'];
				}

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$pagination = new Pagination();
				$pagination->total = $product_total;
				$pagination->page = $page;
				$pagination->limit = $limit;
				$pagination->url =  str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}'));

				if(stripos('category_id', $url)!==false){/**matched**/}
				else{$url.='&category_id='.$category_id;}
				$url.='&sub_category=true';

				$category_pagination_url = $this->url->link('product/category/listing',$url);

				$data['pagination_array'] = array(
				'total' =>$pagination->total,
				'page' =>$pagination->page,
				'limit' =>$pagination->limit,
				'url' =>$pagination->url,

				);

				$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

				if(!empty($this->request->post['token'])){
					$apiLoggedIn = $this->model_account_api->verifyToken($this->request->post['token']);
					if($apiLoggedIn){
						$filter_data =array(
						'customer_id' => $this->customer->getId(),
						'filter_sender' => 'user',
						'filter_status' => '0',
						);

						$messageCount = $this->model_api_account_message->countTotalMessage($filter_data);
						$data['message_count'] = $messageCount;
						}else{
						$data['message_count'] = '0';
					}
					}else{
					$data['message_count'] = '0';
				}

				$data['status'] = 1;

				$this->response->setOutput(json_encode($data));
				$this->response->addHeader('Content-Type: application/json');
				//echo '<pre>';print_r($data);echo '</pre>';
				}else{
				$data['categories'] = array();
				$categories_1 = $this->model_catalog_category->getCategories(0);

				foreach ($categories_1 as $category_1) {
					$level_2_data = array();
					$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
					$categoryImage = '';
					if($category_1['image']){
						$categoryImage = HTTP_SERVER_IMAGE.$category_1['image'];
					}

					//'category_image' => HTTP_SERVER_IMAGE.$category_2['image'],
					$filter_data = array('filter_category_id' => $category_1['category_id'], 'filter_sub_category' => true);
					$data['categories'][] = array(
					'category_id' => $category_1['category_id'],
					'name'        => $category_1['name']. ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' 		  => $this->url->link('product/category', 'path=' . $category_1['category_id']),
					'category_image' => $categoryImage,
					'children'    => $level_2_data
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
						$data['unread_message'] = $messageCount;
						}else{
						$data['unread_message'] = '0';
					}
					}else{
					$data['unread_message'] = '0';
				}

				$json['count_product'] = $this->cart->countProducts();
				$data['status'] = 1;
				//print_r($data);
				$this->response->setOutput(json_encode($data));
				$this->response->addHeader('Content-Type: application/json');
			}

		}
	}
