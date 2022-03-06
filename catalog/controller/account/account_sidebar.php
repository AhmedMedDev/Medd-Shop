<?php
class ControllerAccountAccountSidebar extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/dashboard', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		if(isset($this->request->get['route'])){
			$data['route'] = $this->url->link($this->request->get['route'], '', 'SSL');
		}		
		
		$this->load->language('account/account_sidebar');
		
		/****** Message System Starts *****/
		$data['text_messages'] = $this->language->get('text_messages');
		$filter_data =array(
			'filter_sender'   => 'user',
			'filter_status'   => '0',
			'customer_id'     => $this->customer->getId(),
		);
		$this->load->model('account/message');
		$countMessage = $this->model_account_message->getTotalUnreadMessages($filter_data);
		$data['text_messages'] .= ($countMessage>0)?' ('.$countMessage.')':'';
		
		/****** Message System Ends *****/			
		

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');

		if ($this->customer->isLogged()) {
			$data['welcome_username'] = ucwords($this->customer->getFirstName().' '.$this->customer->getLastName());
		}
		$this->load->model('tool/profile_upload');
		
		$profile_image = $this->model_tool_profile_upload->getProfileImageById();
	
		$placeholder_profile_image= DIR_IMAGE.'no_image.png';
		$profile_image_flag = false;
		$this->load->model('tool/image');
		if(is_array($profile_image) && count($profile_image)>0){
			if (is_file(DIR_PROFILE_UPLOAD . $profile_image['profile_image'])) {
				$profile_image_flag = true;
				$data['profile_image']= $this->model_tool_image->resizeProfileImage($profile_image['profile_image'], 101, 101);
			}
		}
		if($profile_image_flag == false){
			$data['profile_image']= $this->model_tool_image->resize('no_image.png', 101, 101);
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_my_account'] = $this->language->get('text_my_account');
		$data['text_dashboard'] = $this->language->get('text_dashboard');
		$data['text_my_orders'] = $this->language->get('text_my_orders');
		$data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_recurring'] = $this->language->get('text_recurring');
		
		$data['help_text_my_account'] = $this->language->get('help_text_my_account');
		$data['help_text_dashboard'] = $this->language->get('help_text_dashboard');
		$data['help_text_my_orders'] = $this->language->get('help_text_my_orders');
		$data['help_text_my_newsletter'] = $this->language->get('help_text_my_newsletter');
		$data['help_text_newsletter'] = $this->language->get('help_text_newsletter');
		$data['help_text_edit'] = $this->language->get('help_text_edit');
		$data['help_text_password'] = $this->language->get('help_text_password');
		$data['help_text_address'] = $this->language->get('help_text_address');
		$data['help_text_wishlist'] = $this->language->get('help_text_wishlist');
		$data['help_text_order'] = $this->language->get('help_text_order');
		$data['help_text_download'] = $this->language->get('help_text_download');
		$data['help_text_reward'] = $this->language->get('help_text_reward');
		$data['help_text_return'] = $this->language->get('help_text_return');
		$data['help_text_transaction'] = $this->language->get('help_text_transaction');
		$data['help_text_recurring'] = $this->language->get('help_text_recurring');
		$data['help_text_messages'] = $this->language->get('help_text_messages');

		$data['edit'] = $this->url->link('account/edit', '', 'SSL');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['dashboard'] = $this->url->link('account/dashboard', '', 'SSL');
		$data['password'] = $this->url->link('account/password', '', 'SSL');
		$data['address'] = $this->url->link('account/address', '', 'SSL');
		$data['address_add'] = $this->url->link('account/address/add', '', 'SSL');
		$data['address_edit'] = $this->url->link('account/address/edit', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['order_info'] = $this->url->link('account/order/info', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['return'] = $this->url->link('account/return', '', 'SSL');
		$data['return_add'] = $this->url->link('account/return/add', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['recurring'] = $this->url->link('account/recurring', '', 'SSL');
		$data['message'] = $this->url->link('account/message', '', 'SSL');

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}

		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account_sidebar.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/account/account_sidebar.tpl', $data);
		} else {
			return $this->load->view('default/template/common/column_left.tpl', $data);
		}
	}
}