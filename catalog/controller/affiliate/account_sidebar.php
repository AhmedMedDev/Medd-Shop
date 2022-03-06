<?php
class ControllerAffiliateAccountSidebar extends Controller {
	public function index() {
	
		if (!$this->affiliate->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('affiliate/dashboard', '', 'SSL');

			$this->response->redirect($this->url->link('affiliate/login', '', 'SSL'));
		}
		
		if(isset($this->request->get['route'])){
			$data['route'] = $this->url->link($this->request->get['route'], '', 'SSL');
		}
		
		$this->load->language('affiliate/account_sidebar');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');

		if ($this->affiliate->isLogged()) {
			$data['welcome_username'] = ucwords($this->affiliate->getFirstName().' '.$this->affiliate->getLastName());
		}
		$this->load->model('tool/affiliate_profile_upload');
		
		$profile_image = $this->model_tool_affiliate_profile_upload->getProfileImageById();
		
		$data['profile_image']= DIR_IMAGE.'images/default.png';
		$profile_image_flag = false;
		$this->load->model('tool/image');
		if(is_array($profile_image) && count($profile_image)>0){
			if (is_file(DIR_PROFILE_UPLOAD . $profile_image['profile_image'])) {
				$profile_image_flag = true;
				$data['profile_image']= $this->model_tool_image->resizeProfileImage($profile_image['profile_image'], 101, 101);
			}
		}
		
		if($profile_image_flag == false){
			$data['profile_image']= $this->model_tool_image->resize("no_image.png", 71, 71);
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_my_account'] = $this->language->get('text_my_account');
		$data['text_dashboard'] = $this->language->get('text_dashboard');
		$data['text_my_payments'] = $this->language->get('text_my_payments');
		$data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_tracking'] = $this->language->get('text_tracking');
		$data['text_payment'] = $this->language->get('text_payment');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_recurring'] = $this->language->get('text_recurring');
		
		$data['help_text_my_account'] = $this->language->get('help_text_my_account');
		$data['help_text_dashboard'] = $this->language->get('help_text_dashboard');
		$data['help_text_my_payments'] = $this->language->get('help_text_my_payments');
		$data['help_text_my_tracking'] = $this->language->get('help_text_my_tracking');
		$data['help_text_tracking'] = $this->language->get('help_text_tracking');
		$data['help_text_edit'] = $this->language->get('help_text_edit');
		$data['help_text_password'] = $this->language->get('help_text_password');
		$data['help_text_address'] = $this->language->get('help_text_address');
		$data['help_text_wishlist'] = $this->language->get('help_text_wishlist');
		$data['help_text_payment'] = $this->language->get('help_text_payment');
		$data['help_text_download'] = $this->language->get('help_text_download');
		$data['help_text_reward'] = $this->language->get('help_text_reward');
		$data['help_text_return'] = $this->language->get('help_text_return');
		$data['help_text_transaction'] = $this->language->get('help_text_transaction');
		$data['help_text_recurring'] = $this->language->get('help_text_recurring');

		$data['edit'] = $this->url->link('affiliate/edit', '', 'SSL');
		$data['account'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['password'] = $this->url->link('affiliate/password', '', 'SSL');
		$data['payment'] = $this->url->link('affiliate/payment', '', 'SSL');
		$data['transaction'] = $this->url->link('affiliate/transaction', '', 'SSL');
		$data['tracking'] = $this->url->link('affiliate/tracking', '', 'SSL');

		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/affiliate/account_sidebar.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/affiliate/account_sidebar.tpl', $data);
		} else {
			return $this->load->view('default/template/common/column_left.tpl', $data);
		}
	}
}