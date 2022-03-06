<?php
class ControllerAPICommonCategory extends Controller {
	public function index() {
		$this->load->language('module/category');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
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

			$data['categories'] = array();
			$categories_1 = $this->model_catalog_category->getCategories(0);
			foreach ($categories_1 as $category_1) {
				$level_2_data = array();
				$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
				
				$categoryImage = '';
				if($category_1['image']){
					$categoryImage = HTTP_SERVER_IMAGE.$category_1['image'];
				}
				
				$filter_data = array('filter_category_id' => $category_1['category_id'], 'filter_sub_category' => false);
				$data['categories'][] = array(
					'category_id' => $category_1['category_id'],
					'name'        => $category_1['name']. ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' 		  => $this->url->link('product/category', 'path=' . $category_1['category_id']),
					'category_image' => $categoryImage,
					'children'    => $level_2_data
				);
			}
			return $data;
	}
}