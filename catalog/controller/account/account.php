<?php
class ControllerAccountAccount extends Controller {

	public function index() {
            
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/account');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/jQueryTab.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/animation.css');
		$this->document->addScript('catalog/view/theme/growcer/js/jQueryTab.js');
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}						
		
		/****** Message System Starts *****/
		$this->language->load('account/message');
		$data['text_message_system'] = $this->language->get('text_message_system');
		$data['message'] = $this->url->link('account/message', '', 'SSL');
				$filter_data =array(
			'filter_sender'   => 'user',
			'filter_status'   => '0',
			'customer_id'     => $this->customer->getId(),
		);
		$this->load->model('account/message');
		$data['alert_messages'] = $this->model_account_message->getTotalUnreadMessages($filter_data);
		/****** Message System Ends *****/		

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['nav_text_account'] = $this->language->get('nav_text_account');
		
		$data['text_your_details'] = $this->language->get('text_your_details');
		$data['text_change_password'] = $this->language->get('text_change_password');

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}
		$data['account_sidebar'] = $this->load->controller('account/account_sidebar');	
		
		$edit_msg = '';
		if(isset($this->request->get['msg'])){
			$edit_msg = $this->request->get['msg'];
		}
		
		$data['edit'] = $this->load->controller('account/edit/edit', $edit_msg);
		$data['password_link'] = $this->url->link('account/password', '', 'SSL');
		$data['profile_link'] = $this->url->link('account/account', '', 'SSL');
			
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/account.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/account.tpl', $data));
		}
	}


	public function share_cart_status(){
		if ($this->customer->isLogged()) {
			$this->load->model('account/customer');
			$res = $this->model_account_customer->updateShareCartFriendStatus($this->customer->getId(), $this->request->get['status']);
			if($res){
				die('Status updated');
			}
		}else{
			die('Not authorized');
		}
	}
	
	public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
