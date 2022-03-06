<?php
class ControllerAPIProductCompare extends Controller {
	public function index() {
		
		//$this->load->controller('api/common/header');
		$this->load->language('product/compare');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');		
		$this->load->model('account/customer');		
		$this->load->model('account/address');
		
		$this->session->data['compare'] = array();
		$compareList = $this->getCompareProductList();
		$this->session->data['compare'] = $compareList; 
		
		if ($this->config->get('config_tax_customer') == 'payment') {
			$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
		}

		if ($this->config->get('config_tax_customer') == 'shipping') {
			$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
		}
		/* if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		} */

		if (isset($this->request->get['remove']) && intval($this->request->get['remove']) > 0) {
			$key = array_search($this->request->get['remove'], $this->session->data['compare']);
			
			if ($key === false || $key == NULL) {
				
				$data['success'] = $this->language->get('text_not_in_compare_list');
				$data['status'] = 0;
				 
			} else {
			
				$this->model_api_product_compare->deleteOldProducts($this->request->get['remove']);
				$data['success'] = $this->language->get('text_remove');
				$data['status'] = 1;				
			}
			
			echo json_encode($data);
			exit;
		}


		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['review_status'] = $this->config->get('config_review_status');
		$data['compare_count'] = count($compareList);

		$data['products'] = array();

		$data['attribute_groups'] = array();
		$data['html'] = '
		<div id="body">
			<div class="main-area">
				<div class="fix-container" style="margin: 0 auto;max-width: 1200px;padding: 0 10px;position: relative;width: 100%;">
					<div class="row" style="margin-left: -15px;margin-right: -15px;">
						<div class="col-md-12">&nbsp;</div>
					</div>
					<div class="heading" style="padding: 15px 0;color: #000000;font-size: 18px;font-weight: 600;padding: 0;">'.$this->language->get('heading_title').'</div>
					<div class="tbl-scroll">
						<table class="tbl-normal tbl-responsive tbl-comparison" style="border: 1px solid #e7e5e6;border-collapse: collapse;width: 100%;">
							<thead>
								<tr>
									<th colspan="'.(count($this->session->data['compare'])+1).'" style="border: 1px solid #e7e5e6;color: #000;font-size: 16px;font-weight: 600;padding: 10px 15px;text-align: left;"><strong>'.$this->language->get('text_product').'</strong></th>
								</tr>
							</thead>
							<tbody> 
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_name').'</td>';
									foreach($this->getHtmlDetails('name') as $name){
										$data['html'] .= $name;
									}
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_image').'</td>';
									foreach($this->getHtmlDetails('image') as $image){
										$data['html'] .= $image;
									}
									
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_price').'</td>';
									foreach($this->getHtmlDetails('price') as $price){
										$data['html'] .= $price;
									}
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_model').'</td>';
									foreach($this->getHtmlDetails('model') as $model){
										$data['html'] .= $model;
									}
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_manufacturer').'</td>';
									foreach($this->getHtmlDetails('manufacturer') as $model){
										$data['html'] .= $model;
									}
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_availability').'</td>';
									foreach($this->getHtmlDetails('availability') as $model){
										$data['html'] .= $model;
									}
									$data['html'] .= '
								</tr>';
								if($data['review_status']){
									$data['html'] .= '
									<tr>
										<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_rating').'</td>';
										foreach($this->getHtmlDetails('rating') as $rating){
											$data['html'] .= $rating;
										}
										$data['html'] .= '
									</tr>';
								}
									$data['html'] .= '
								
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_weight').'</td>';
									foreach($this->getHtmlDetails('weight') as $weight){
										$data['html'] .= $weight;
									}
									$data['html'] .= '
								</tr>
								<tr>
									<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->language->get('text_dimension').'</td>';
									foreach($this->getHtmlDetails('dimension') as $dimension){
										$data['html'] .= $dimension;
									}
									$data['html'] .= '
								</tr>
							</tbody>';
							foreach($this->getHtmlDetails('attributes') as $attributes){
								$data['html'] .= $attributes;
							}
							$data['html'] .= '
							
						</table>
					</div>
				</div>
			</div>
		</div>
		';
		
		if(count($this->session->data['compare'])>0){
			
			foreach ($this->session->data['compare'] as $key => $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				
				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_compare_width'), $this->config->get('config_image_compare_height'));
					} else {
						$image = false;
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						 $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'))); 
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}

					if ($product_info['quantity'] <= 0) {
						$availability = $product_info['stock_status'];
					} elseif ($this->config->get('config_stock_display')) {
						$availability = $product_info['quantity'];
					} else {
						$availability = $this->language->get('text_instock');
					}

					$attribute_data = array();

					$attribute_groups = $this->model_catalog_product->getProductAttributes($product_id);

					foreach ($attribute_groups as $attribute_group) {
						foreach ($attribute_group['attribute'] as $attribute) {
							$attribute_data[$attribute['attribute_id']] = $attribute['text'];
						}
					}

					$data['products'][$product_id] = array(
						'product_id'   => $product_info['product_id'],
						'name'         => $product_info['name'],
						'thumb'        => $image,
						'price'        => $price,
						'special'      => $special,
						'description'  => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
						'model'        => $product_info['model'],
						'manufacturer' => $product_info['manufacturer'],
						'availability' => $availability,
						'minimum'      => $product_info['minimum'] > 0 ? $product_info['minimum'] : 1,
						'rating'       => (int)$product_info['rating'],
						'reviews'      => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
						'weight'       => $this->weight->format($product_info['weight'], $product_info['weight_class_id']),
						'length'       => $this->length->format($product_info['length'], $product_info['length_class_id']),
						'width'        => $this->length->format($product_info['width'], $product_info['length_class_id']),
						'height'       => $this->length->format($product_info['height'], $product_info['length_class_id']),
						'attribute'    => $attribute_data,
						'href'         => $this->url->link('product/product', 'product_id=' . $product_id),
						'remove'       => $this->url->link('product/compare', 'remove=' . $product_id)
					);

					foreach ($attribute_groups as $attribute_group) {
						$data['attribute_groups'][$attribute_group['attribute_group_id']]['name'] = $attribute_group['name'];

						foreach ($attribute_group['attribute'] as $attribute) {
							$data['attribute_groups'][$attribute_group['attribute_group_id']]['attribute'][$attribute['attribute_id']]['name'] = $attribute['name'];
						}
					}
					$data['status'] = 1;
				} else {
					$data['error'] = 'products are not available';
					$data['status'] = 0;
				}
			}
		}else{
			$data['status'] = 1;
		}
		
		$json['count_product'] = $this->cart->countProducts();
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data));
	}
	
	public function deleteCompareProducts(){
		
		//$this->load->controller('api/common/header');
		
		$data = array();
		$this->load->model('api/product/compare');
		if($this->model_api_product_compare->deleteCompareProducts()){
			$data['success'] = 'Compare List has been deleted';
			$data['status'] = 1;
		}else{
			$data['error'] = '';
			$data['status'] = 0;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data));
	}
	
	public function getHtmlDetails($value){
		$compareList = $this->getCompareProductList();
		$this->session->data['compare'] = $compareList;
		foreach ($this->session->data['compare'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			if ($product_info) {
				switch($value){
					case 'name':
						$content[] = '
						<td class="pro-mame" style="color:#f95e2e; border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">
							<strong>'.$product_info['name'].'</strong>
						</td>
						';
					break;
					case 'image':
					
						if ($product_info['image']) {
							$image = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_compare_width'), $this->config->get('config_image_compare_height'));
						} else {
							$image = false;
						}
					
						$content[] = '
						
						<td class="text-center" style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;text-align: center;">
							<div class="image-thumb-90"> 
							'.(($image)?'<img src="'.$image.'" class="img-effects img-responsive img-thumbnail" alt="'.$product_info['name'].'" title="'.$product_info['name'].'" class="img-thumbnail" />':'<img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects img-responsive img-thumbnail" alt="'.$product_info['name'].'" />').'
							
							 
							</div>
						</td>
						';
					break;
					case 'price':
						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = false;
						}
						
						if ((float)$product_info['special']) {
							$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = false;
						}
						
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">
							'.(($price)?''.((!$special)?$price:'<span class="price-old cros-price">'.$price.'</span> <span class="price-new">'.$special.'</span>').'':'').'</td>
						';
					break;
					
					case 'model':
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$product_info['model'].'</td>';
					break;
					case 'manufacturer':
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$product_info['manufacturer'].'</td>';
					break;
					case 'availability':
					
						if ($product_info['quantity'] <= 0) {
							$availability = $product_info['stock_status'];
						} elseif ($this->config->get('config_stock_display')) {
							$availability = $product_info['quantity'];
						} else {
							$availability = $this->language->get('text_instock');
						}
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$availability.'</td>';	
					break;
					case 'rating':
						$productRating = (int)$product_info['rating'];
						$ratings_review_html = '
						<td style="border: 1px solid #e7e5e6;color: #545353;padding:0px;margin:0px;">
						  
							<ul style="padding:0px;margin:5px 10px;">';
								$max_ratings = 5;
								$min_ratings = 0;
								if($productRating>$min_ratings){
									for($rcount=1; $rcount<=$productRating; $rcount++){
									$max_ratings--;
									
									$ratings_review_html.='<li class="active" style="display: inline-block;vertical-align: top;">
											  <svg style="height: 14px;width: 14px;" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
										<g>
												  <path fill="#f99c2e" d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
												</g>
									  </svg>
									</li>';
									}
								}
								for($rcount=1; $rcount<=$max_ratings; $rcount++){
								
								$ratings_review_html.='<li class="in-active" style="display: inline-block;vertical-align: top;">
										  <svg style="height: 14px;width: 14px;" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
										<g>
												  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
												</g>
									  </svg>
								</li>';
								
								}
							$ratings_review_html.='</ul>
							<div class="rating" style="display: inline-block; font-size:14px; font-weight:400; margin: 5px 10px;vertical-align: top;">
							'.sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']).'
							</div> 
							</td>
							';
							$content[] = $ratings_review_html;
					break;
					case 'summary':
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..'.'</td>';
					break;
					case 'weight':
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->weight->format($product_info['weight'], $product_info['weight_class_id']).'</td>';
					break;
					case 'dimension':
						$content[] = '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$this->length->format($product_info['length'], $product_info['length_class_id']).' x '.$this->length->format($product_info['width'], $product_info['length_class_id']).' x '.$this->length->format($product_info['height'], $product_info['length_class_id']).'</td>';
					break;
					case 'attributes':
						$attribute_groups = $this->model_catalog_product->getProductAttributes($product_id);
						
						foreach ($attribute_groups as $attribute_group) {
							foreach ($attribute_group['attribute'] as $attribute) {
								$attribute_data[$attribute['attribute_id']] = $attribute['text'];
							}
						}
						
						
						
						foreach ($attribute_groups as $attribute_group) {
							$data['attribute_groups'][$attribute_group['attribute_group_id']]['name'] = $attribute_group['name'];
							$attrHtml = '
							<thead>
								<tr>
									<td colspan="'.(count($this->session->data['compare'])+1).'" style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;"><strong>'.$attribute_group['name'].'</strong></td>
								</tr>
							</thead>
							';
							
							foreach ($attribute_group['attribute'] as $attribute) {
								//print_r($attribute);
								//print_r($attribute_data);
								$data['attribute_groups'][$attribute_group['attribute_group_id']]['attribute'][$attribute['attribute_id']]['name'] = $attribute['name'];
								//print_r($attribute_data[$attribute['attribute_id']]);
								$attrHtml .= '
								<tbody>
									<tr>
										<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$attribute['name'].'</td>';
										if($attribute_data[$attribute['attribute_id']]){
											$attrHtml .= '<td style="border: 1px solid #e7e5e6;color: #545353;font-size: 14px;font-weight: 400;line-height: 1.5;padding: 10px 15px;vertical-align: top;">'.$attribute_data[$attribute['attribute_id']].'</td>';
										}
										$attrHtml .= '
									</tr>
								</tbody>
								';
							}
						}
						
						$content[] =$attrHtml;
					break;
				}
			}
		}
		
		return $content;
	}
	
	public function getCompareProductList(){
		$this->load->model('api/product/compare');
		$products = $this->model_api_product_compare->getCompareProducts();
		
		foreach($products as $product){
			$compareProduct[] = $product['product_id'];
		}
		return $compareProduct;
	}
	public function removeProductFromList($product_id){
		$this->load->model('product/compare');
		$result = $this->model_product_compare->removeProduct($product_id);
		
		if($result){
			return true;
		}else{
			return false;
		}
	}
	public function add() {
		//$this->load->controller('api/common/header');
 		$this->load->language('product/compare');
		$this->load->model('api/product/compare');
		$this->session->data['compare'] = array();
		
		$compareList = $this->getCompareProductList();
		$this->session->data['compare'] = $compareList;
		$json = array();
		$product_id = $this->request->post['product_id'];
		
		if(empty($product_id))
		{
			$json['status'] = 0;
			$json['error'] = 'Please select the product';
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}

		$this->load->model('catalog/product');
		$this->load->model('api/product/compare');
		$product_info = $this->model_catalog_product->getProduct($product_id);
		
		if (count($this->session->data['compare']) >= 4) {
			$json['status'] = 0;
			$json['error'] = sprintf($this->language->get('text_maximum_limit'),'4');
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}else{
			if ($product_info) {
				if (!in_array($this->request->post['product_id'], $this->session->data['compare'])) {
					$this->model_api_product_compare->addCompareProduct($this->request->post['product_id']);
					$this->session->data['compare'][] = $this->request->post['product_id'];
				}
				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('product/compare'));
				//$json['total'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
				$json['total'] = (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0);
				$json['status'] = 1;
			}
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
		
	}
}
