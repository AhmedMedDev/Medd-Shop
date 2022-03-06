<?php
class ControllerAccountEdit extends Controller {
	private $error = array();
	private $sbmt_err = array();
	private $sbmt_val = array();
	
	public function index() {
		$this->response->redirect($this->url->link('account/account', '', 'SSL'));
	}
	public function edit($edit_msg=''){
		if(!empty($edit_msg)){
			$temp_msg = json_decode(rawurldecode($edit_msg), true);
			
			foreach($temp_msg AS $msgkey=>$msgval):
				if($msgkey=='error'){ 
					foreach($msgval AS $err_key=>$err_val){
						$this->sbmt_err[$err_key] = $err_val;
					}
				}
				else if($msgkey=='post'){ 
					foreach($msgval AS $p_key=>$p_val){
						$this->sbmt_val[$p_key] = $p_val;
					}
				}
			endforeach;
		}
		$this->load->language('account/edit');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_account_customer->editCustomer($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('edit', $activity_data);

			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		$data['nav_text_edit_account'] = $this->language->get('nav_text_edit_account');
		
		$data['text_your_details'] = $this->language->get('text_your_details');
		$data['text_additional'] = $this->language->get('text_additional');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_profile_picture'] = $this->language->get('text_profile_picture');
		$data['text_change_photo'] = $this->language->get('text_change_photo');

		$data['entry_firstname'] = $this->language->get('entry_firstname');
		$data['entry_lastname'] = $this->language->get('entry_lastname');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		$data['entry_fax'] = $this->language->get('entry_fax');
		
		$data['entry_share_cart_show_friends'] = $this->language->get('entry_share_cart_show_friends');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_submit'] = $this->language->get('button_submit');
		
		$data['button_back'] = $this->language->get('button_back');
		$data['button_upload'] = $this->language->get('button_upload');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		}else if (isset($this->sbmt_err['warning'])) {
			$data['error_warning'] = $this->sbmt_err['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['firstname'])) {
			$data['error_firstname'] = $this->error['firstname'];
		}else if (isset($this->sbmt_err['firstname'])) {
			$data['error_firstname'] = $this->sbmt_err['firstname'];
		} else {
			$data['error_firstname'] = '';
		}

		if (isset($this->error['lastname'])) {
			$data['error_lastname'] = $this->error['lastname'];
		}else if (isset($this->sbmt_err['lastname'])) {
			$data['error_lastname'] = $this->sbmt_err['lastname'];
		} else {
			$data['error_lastname'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		}else if (isset($this->sbmt_err['warning'])) {
			$data['error_email'] = $this->sbmt_err['warning'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		}else if (isset($this->sbmt_err['telephone'])) {
			$data['error_telephone'] = $this->sbmt_err['telephone'];
		} else {
			$data['error_telephone'] = '';
		}

		if (isset($this->error['custom_field'])) {
			$data['error_custom_field'] = $this->error['custom_field'];
		} else {
			$data['error_custom_field'] = array();
		}

		$data['action'] = $this->url->link('account/edit/edit', '', 'SSL');

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		}

		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		}elseif (isset($this->sbmt_val['firstname'])) {
			$data['firstname'] = $this->sbmt_val['firstname'];
		}elseif (!empty($customer_info)) {
			$data['firstname'] = $customer_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		}elseif (isset($this->sbmt_val['lastname'])) {
			$data['lastname'] = $this->sbmt_val['lastname'];
		}elseif (!empty($customer_info)) {
			$data['lastname'] = $customer_info['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($customer_info)) {
			$data['email'] = $customer_info['email'];
		} else {
			$data['email'] = '';
		}
		
		if (isset($this->request->post['share_cart_show_friends'])) {
			$data['share_cart_show_friends'] = $this->request->post['share_cart_show_friends'];
		} elseif (!empty($customer_info)) {
			$data['share_cart_show_friends'] = $customer_info['share_cart_show_friends'];
		} else {
			$data['share_cart_show_friends'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		}elseif (isset($this->sbmt_val['telephone'])) {
			$data['telephone'] = $this->sbmt_val['telephone'];
		}elseif (!empty($customer_info)) {
			$data['telephone'] = $customer_info['telephone'];
		} else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['fax'])) {
			$data['fax'] = $this->request->post['fax'];
		}elseif (isset($this->sbmt_val['fax'])) {
			$data['fax'] = $this->sbmt_val['fax'];
		}elseif (!empty($customer_info)) {
			$data['fax'] = $customer_info['fax'];
		} else {
			$data['fax'] = '';
		}

		// Custom Fields
		$this->load->model('account/custom_field');

		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		if (isset($this->request->post['custom_field'])) {
			$data['account_custom_field'] = $this->request->post['custom_field'];
		} elseif (isset($customer_info)) {
			$data['account_custom_field'] = json_decode($customer_info['custom_field'], true);
		} else {
			$data['account_custom_field'] = array();
		}

		$data['back'] = $this->url->link('account/account', '', 'SSL');
			
		$this->load->model('tool/profile_upload');
		
		$profile_image = $this->model_tool_profile_upload->getProfileImageById();
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
	
		if(count($this->error)>0){ 
			$data_temp = array();
			$data_temp['error'] = $this->error;
			$data_temp['post'] = $this->request->post;
			
			$error_msgs = '';
			foreach($this->error as $k=>$v){
				$error_msgs .= $v.'<br/>';
			}
			$this->session->data['error'] = $error_msgs;
			$this->response->redirect($this->url->link('account/account',$msg, 'SSL'));
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/edit.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/account/edit.tpl', $data);
		} else {
			return $this->load->view('default/template/account/edit.tpl', $data);
		}
	}

	protected function validate() {
		if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
			$this->error['lastname'] = $this->language->get('error_lastname');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		// Custom field validation
		$this->load->model('account/custom_field');

		$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		foreach ($custom_fields as $custom_field) {
			if (($custom_field['location'] == 'account') && $custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['custom_field_id']])) {
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}

		return !$this->error;
	}
}