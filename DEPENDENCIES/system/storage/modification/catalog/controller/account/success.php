<?php
class ControllerAccountSuccess extends Controller {
	public function index() {
		$this->load->language('account/success');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_success'),
			'href' => $this->url->link('account/success')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($this->config->get('config_customer_group_id'));		
		
		$this->load->model('setting/setting');
		$emailverification = $this->model_setting_setting->getSetting('emailverification');
		if($emailverification['emailverification']['enabled'] == 1){
			$this->load->model('module/emailverification');
			$this->load->model('account/customer');
			$this->load->language('module/emailverification');

			if ($customer_group_info && !$customer_group_info['approval']) {
				$data['text_message'] = sprintf($this->language->get('text_message_after_registration'), $this->url->link('information/contact'));
			} else {
				$data['text_message'] = sprintf($this->language->get('text_approval_after_registration'), $this->config->get('config_name'), $this->url->link('information/contact'));
			}
			if(!$this->model_module_emailverification->isCustomerVerified($this->customer->getId(),$this->config->get('config_store_id'))){
				$this->customer->logout();
				$this->data['continue'] = $this->url->link('account/login', '', 'SSL');
			}
		}else{
			if ($customer_group_info && !$customer_group_info['approval']) {
				$data['text_message'] = sprintf($this->language->get('text_message'), $this->url->link('information/contact'));
			} else {
				$data['text_message'] = sprintf($this->language->get('text_approval'), $this->config->get('config_name'), $this->url->link('information/contact'));
			}		
		}
		
		$data['button_continue'] = $this->language->get('button_continue');
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}		

		if ($this->cart->hasProducts()) {
			$data['continue'] = $this->url->link('checkout/cart');
		} else {
			$data['continue'] = $this->url->link('account/account', '', 'SSL');
		}


				$this->load->model('setting/setting');
				$emailverification = $this->model_setting_setting->getSetting('emailverification');
				if($emailverification['emailverification']['enabled'] == 1){
				$this->load->model('module/emailverification');
				$this->load->model('account/customer');
				$this->load->language('module/emailverification');
			
				if ($customer_group_info && !$customer_group_info['approval']) {
				$data['text_message'] = sprintf($this->language->get('text_message_after_registration'), $this->url->link('information/contact'));
				} else {
				$data['text_message'] = sprintf($this->language->get('text_approval_after_registration'), $this->config->get('config_name'), $this->url->link('information/contact'));
				}
			
				if(!$this->model_module_emailverification->isCustomerVerified($this->customer->getId(),$this->config->get('config_store_id'))){
				$this->customer->logout();
				$data['continue'] = $this->url->link('account/login', '', 'SSL');
					}
				}
			
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/success.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/success.tpl', $data));
		}
	}
}