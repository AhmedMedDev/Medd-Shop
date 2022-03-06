<?php
class ControllerModuleTestimonial extends Controller {
	public function index() {
			
			$this->load->model('module/testimonial');
			
			$data['testimonials'] = array();
			
			$results = $this->model_module_testimonial->getTestimonials();
			//print_r($results);
			
			foreach ($results as $result) {
				
					$data['testimonials'][] = array(
						'title' => $result['title'],
						'description'  => $result['description'],
					);
			}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/testimonial.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/testimonial.tpl', $data);
			} else {
				return $this->load->view('default/template/module/carousel.tpl', $data);
			}
		/* if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['html_heading_name'] = $setting['name'];
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/html.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/html.tpl', $data);
			} else {
				return $this->load->view('default/template/module/html.tpl', $data);
			}
		} */
	}
}