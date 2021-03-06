<?php
class ControllerAPIModuleFilters extends Controller {
	public function index() {
		$this->load->model('design/layout');
		
		if (isset($this->request->get['route'])) {
			$route = (string)$this->request->get['route'];
		} else {
			$route = 'common/home';
		}
		/* echo $this->request->get['category_id']; */
		$layout_id = 0;

		if ($route == 'api/module/filters' && isset($this->request->get['category_id'])) {
			$this->load->model('catalog/category');

			//$path = explode('_', (string)$this->request->get['category_id']);
			$path = $this->request->get['category_id'];
			$layout_id = $this->model_catalog_category->getCategoryLayoutId($path);
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

		$modules = $this->model_design_layout->getLayoutModules($layout_id, 'column_left');
		
		foreach ($modules as $module) {
			$part = explode('.', $module['code']);
			
			if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
				$data['modules'][] = $this->load->controller('api/module/filters/' . $part[0]);
			}

			if (isset($part[1])) {
				$setting_info = $this->model_extension_module->getModule($part[1]);

				if ($setting_info && $setting_info['status']) {
					$data['modules'][] = $this->load->controller('api/module/filters/' . $part[0], $setting_info);
				}
			}
		}
		$data['status'] = 1; 
		$this->response->setOutput(json_encode($data));
	}
}