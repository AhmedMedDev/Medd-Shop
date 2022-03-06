<?phpclass ControllerAPIAccountProfile extends Controller {	private $error = array();	private $sbmt_err = array();	private $sbmt_val = array();		public function index() {		$this->load->controller('api/common/header');		$this->load->model('account/wishlist');		$this->load->model('api/account/message');		$cartCount = $this->cart->hasProducts();		//echo $compareList = $this->customer->getCountCompareProduct();		$wishListCount = $this->model_account_wishlist->getTotalWishlist();				$this->load->language('account/edit');				if($this->request->post['action'] == 'edit'){						$this->load->model('account/customer');			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {								$this->model_account_customer->editCustomer($this->request->post);				$this->session->data['success'] = $this->language->get('text_success');				$this->load->model('account/activity');				$activity_data = array(					'customer_id' => $this->customer->getId(),					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()				);				$this->model_account_activity->addActivity('edit', $activity_data);				$json['status'] = 1;				$json['redirectURL'] = $this->url->link('api/account/profile', '', 'SSL');				//$this->response->redirect($this->url->link('account/account', '', 'SSL'));				$this->response->setOutput(json_encode($json));			}			if (isset($this->error['warning'])) {				$error['error_warning'] = $this->error['warning'];			}else if (isset($this->sbmt_err['warning'])) {				$error['error_warning'] = $this->sbmt_err['warning'];			} else {				$error['error_warning'] = '';			}			if (isset($this->error['firstname'])) {				$error['error_firstname'] = $this->error['firstname'];			}else if (isset($this->sbmt_err['firstname'])) {				$error['error_firstname'] = $this->sbmt_err['firstname'];			} else {				$error['error_firstname'] = '';			}			if (isset($this->error['lastname'])) {				$error['error_lastname'] = $this->error['lastname'];			}else if (isset($this->sbmt_err['lastname'])) {				$error['error_lastname'] = $this->sbmt_err['lastname'];			} else {				$error['error_lastname'] = '';			}			/* if (isset($this->error['email'])) {				$error['error_email'] = $this->error['email'];			}else if (isset($this->sbmt_err['warning'])) {				$daerrorta['error_email'] = $this->sbmt_err['warning'];			} else {				$error['error_email'] = '';			} */			if (isset($this->error['telephone'])) {				$error['error_telephone'] = $this->error['telephone'];			}else if (isset($this->sbmt_err['telephone'])) {				$error['error_telephone'] = $this->sbmt_err['telephone'];			} else {				$error['error_telephone'] = '';			}			if (isset($this->error['custom_field'])) {				$error['error_custom_field'] = $this->error['custom_field'];			} else {				$error['error_custom_field'] = array();			}												$data['action'] = $this->url->link('account/edit/edit', '', 'SSL');			if ($this->request->server['REQUEST_METHOD'] != 'POST') {				$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());			}			 			if (isset($this->request->post['firstname'])) {				$data['firstname'] = $this->request->post['firstname'];			}elseif (isset($this->sbmt_val['firstname'])) {				$data['firstname'] = $this->sbmt_val['firstname'];			}elseif (!empty($customer_info)) {				$data['firstname'] = $customer_info['firstname'];			} else {				$data['firstname'] = '';			}			if (isset($this->request->post['lastname'])) {				$data['lastname'] = $this->request->post['lastname'];			}elseif (isset($this->sbmt_val['lastname'])) {				$data['lastname'] = $this->sbmt_val['lastname'];			}elseif (!empty($customer_info)) {				$data['lastname'] = $customer_info['lastname'];			} else {				$data['lastname'] = '';			}			if (isset($this->request->post['telephone'])) {				$data['telephone'] = $this->request->post['telephone'];			}elseif (isset($this->sbmt_val['telephone'])) {				$data['telephone'] = $this->sbmt_val['telephone'];			}elseif (!empty($customer_info)) {				$data['telephone'] = $customer_info['telephone'];			} else {				$data['telephone'] = '';			}			if (isset($this->request->post['fax'])) {				$data['fax'] = $this->request->post['fax'];			}elseif (isset($this->sbmt_val['fax'])) {				$data['fax'] = $this->sbmt_val['fax'];			}elseif (!empty($customer_info)) {				$data['fax'] = $customer_info['fax'];			} else {				$data['fax'] = '';			}			$this->load->model('account/custom_field');			$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));			if (isset($this->request->post['custom_field'])) {				$data['account_custom_field'] = $this->request->post['custom_field'];			} elseif (isset($customer_info)) {				$data['account_custom_field'] = json_decode($customer_info['custom_field'], true);			} else {				$data['account_custom_field'] = array();			}			$data['back'] = $this->url->link('api/account/profile', '', 'SSL');							$this->load->model('tool/profile_upload');						$profile_image = $this->model_tool_profile_upload->getProfileImageById();			$profile_image_flag = false;			$this->load->model('tool/image');			if(is_array($profile_image) && count($profile_image)>0){				if (is_file(DIR_PROFILE_UPLOAD . $profile_image['profile_image'])) { 					$profile_image_flag = true;					$data['profile_image']= $this->model_tool_image->resizeProfileImage($profile_image['profile_image'], 500, 500);				}			}						if($profile_image_flag == false){				$data['profile_image']= $this->model_tool_image->resize("profile/default.png", 500, 500);			}			if(count($this->error)>0){				$data_temp = array();				$data_temp['error'] = $this->error;				$data_temp['post'] = $this->request->post;								$error_msgs = '';				foreach($this->error as $k=>$v){					$error_msgs .= $v.'<br/>';				}				$this->session->data['error'] = $error_msgs;				$json['errors'] = $this->error;				$json['status'] = 0;				//$this->response->redirect($this->url->link('account/account',$msg, 'SSL'));			}else{				$json['data'] = $data;				$json['status'] = 1;			}									$json['count_product'] = $this->cart->countProducts();			$this->response->setOutput(json_encode($json));			//echo '<pre>';print_r($json);echo '</pre>';					}else{						$customerDetails = $this->model_account_api->getApiCustomerDetails($this->request->post['token']); 						$filter_data =array(				'customer_id' => $customerDetails['customer_id'],				'filter_sender' => 'user',				'filter_status' => '0',			);			$messageCount = $this->model_api_account_message->getTotalUnreadMessages($filter_data);			$customerInfo = array();			$customerInfo['customer_id'] = $customerDetails['customer_id'];			$customerInfo['cart_count'] = $cartCount;			$customerInfo['unread_message'] = $messageCount;			$customerInfo['compare_count'] = $this->customer->getCompareCount();			//$customerInfo['compare_count'] = count($compareList);			$customerInfo['wishlist_count'] = $wishListCount;			$customerInfo['firstname'] = $customerDetails['firstname'];			$customerInfo['lastname'] = $customerDetails['lastname'];			$customerInfo['email'] = (empty($customerDetails['email'])) ? $customerDetails['social_email'] : $customerDetails['email'];			$customerInfo['telephone'] = $customerDetails['telephone'];			$customerInfo['fax'] = $customerDetails['fax'];			$customerInfo['date_added'] = $customerDetails['date_added'];												$customerInfo['authentication_data'] = array(									'provider' => $customerDetails['provider'], 						);									if(empty($customerDetails['profile_image'])){				$customerInfo['profile_image'] = $customerDetails['photo_url'];			}else{				$customerInfo['profile_image'] = HTTP_SERVER_IMAGE .'profile/'. $customerDetails['profile_image'];			}			$customerInfo['status'] = 1;						$customerInfo['text_change_photo'] = $this->language->get('text_change_photo');						$customerInfo['count_product'] = $this->cart->countProducts();			$this->response->setOutput(json_encode($customerInfo));			$this->response->addHeader('Content-Type: application/json');			//echo '<pre>';print_r($customerInfo);echo '</pre>';		}	}		protected function validate() {		if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {			$this->error['firstname'] = $this->language->get('error_firstname');		}		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {			$this->error['lastname'] = $this->language->get('error_lastname');		}		/* if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {			$this->error['email'] = $this->language->get('error_email');		}		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {			$this->error['warning'] = $this->language->get('error_exists');		} */		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {			$this->error['telephone'] = $this->language->get('error_telephone');		}		// Custom field validation		$this->load->model('account/custom_field');		$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));		foreach ($custom_fields as $custom_field) {			if (($custom_field['location'] == 'account') && $custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['custom_field_id']])) {				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);			}		}		return !$this->error;	}}