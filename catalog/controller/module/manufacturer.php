<?php
class ControllerModuleMAnufacturer extends Controller {
	public function index($setting) {
		$this->load->language('module/manufacturer');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$this->document->addScript('catalog/view/theme/growcer/js/jquery.tokenize.js');
		$this->document->addStyle('catalog/view/theme/growcer/css/jquery.tokenize.css');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['manufacturer_id'] =  (string)$this->request->get['manufacturer_id'];
		} else {
			$data['manufacturer_id'] = array();
		}
		
		/**custom code - for filter[****/
		
		$parts = explode('_', (string)$this->request->get['path']);
		$category_id = (int)array_pop($parts);
		if($category_id==0){
			if($this->request->get['category_id']){
				$category_id = (int)$this->request->get['category_id'];
			}
		}
		$url = '';
		
		//[custom code]
		if (isset($this->request->get['price_range'])) {
			$url .= '&price_range='.$this->request->get['price_range'];
		}
		if (isset($this->request->get['mid'])) {
			$mid = $this->request->get['mid'];
			$temp = explode(",", $mid);
			foreach($temp AS $tik=>$tid){
				if ((is_int($tid) || ctype_digit($tid)) && (int)$tid > 0 )  continue;
				unset($temp[trim($tik)]); 
			}
			$mid = implode(",", $temp);
			$url .= '&mid='.$mid;
		} 
		
		if (isset($this->request->get['category_id'])) {
			$url .= '&category_id=' . $this->request->get['category_id'];
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
		$current_route = $this->request->get['route'];// valid for product/search and product/category
		
		if($current_route=='product/search'){
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}
		}
		
		$data['action'] = str_replace('&amp;', '&', $this->url->link($current_route, 'path=' . $this->request->get['path'] . $url));
		
		
		if (isset($this->request->get['mid'])) {
			$mid =  $this->request->get['mid'];
			$mid = explode(",", $mid);
			$data['mid'] = $mid;
		} else {
			$data['mid'] = array();
		}
		/***]****/
		
		$this->load->model('tool/image');

		$this->load->model('catalog/manufacturer');

		$this->load->model('catalog/product');

		$data['manufacturer'] = array();
		
		if((int)$category_id>0){
			$temp_data = array('filter_category_id'=>(int)$category_id);
			$manufacturers = $this->model_catalog_manufacturer->getManufacturersByCategoryId($temp_data);
		}else{
			$manufacturers = $this->model_catalog_manufacturer->getManufacturers();
		}
		
		if(empty($manufacturers)) return ;
		
		foreach ($manufacturers as $manufacturer) {
			
		if ($manufacturer['image']) {
					$image = $this->model_tool_image->resize($manufacturer['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}
			

			$data['manufacturers'][] = array(
				'manufacturer_id' => $manufacturer['manufacturer_id'],
				'name'        => $manufacturer['name'] ,
				'href'        => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']),
				'image'		 => $image
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/manufacturer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/manufacturer.tpl', $data);
		} else {
			return $this->load->view('default/template/module/manufacturer.tpl', $data);
		}
	}
}