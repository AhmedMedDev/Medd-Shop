<?php
class ControllerAPICommonSlideshow extends Controller {
	public function index($setting) {
		static $module = 0;
		//print_r($setting);
		$this->load->model('design/banner');
		$this->load->model('tool/image');

		
		$data['banners'] = array();
		
		$data['slider_type'] = isset($setting['slider_type']) ? $setting['slider_type'] : '';
		
		$data['text_banner_show_now']  = $this->language->get('text_banner_show_now');	
		
		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				if($setting['slider_type']==''){
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				}else{
					$image = $this->model_tool_image->getActualImage($result['image']);
				}
				$data['banners'][] = array(
					'title' => $result['title'],
					'entry_heading_h3' => $result['entry_heading_h3'],
					'entry_heading_h2' => $result['entry_heading_h2'],
					'entry_heading_h4' => $result['entry_heading_h4'],
					'link'  => $result['link'],
					'image' => $image
				);
			}
		}

		$data['module'] = $module++;
		return $data;
	}
}