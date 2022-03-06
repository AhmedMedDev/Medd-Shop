<?php
class ControllerApiAccountRegister extends Controller {
	private $error = array();
	
	public function index() {
		if ($this->customer->isLogged()) {			unset($this->session->data['customer_id']); 			unset($this->session->data['api_token']); 			unset($this->session->data['api_id']);   
		}
		$json = array();
		$this->load->model('account/api');
		$this->load->language('api/register');
		$this->load->model('account/customer');
		$verify_message = $this->language->get('verify_message');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$api_info = $this->model_account_api->getApiByKey( $this->request->post[ 'key' ] );
			
			if ($api_info) {
				$customer_id = $this->model_account_customer->addCustomer($this->request->post);
				$json['success'] = $this->language->get( 'text_success' );
				
				$this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
				//$this->customer->login($this->request->post['email'], $this->request->post['password']);
				unset($this->session->data['guest']);
				$this->load->model('account/activity');
				$activity_data = array(
					'customer_id' => $customer_id,
					'name'        => $this->request->post['firstname'] . ' ' . $this->request->post['lastname']
				);
				$this->model_account_activity->addActivity('register', $activity_data);
				$this->session->data['success'] = $verify_message;
				
				
				$sesion_name = 'temp_session_' . uniqid();
				$session = new Session($this->session->getId(), $sesion_name);
				
				// Set API ID
				$session->data['api_id'] = $api_info['api_id'];
				$json['email'] = $this->request->post['email'];
				$json['id'] = $customer_id;
				$json['name'] = $this->request->post['firstname'];
				$json['profile_image'] = '';
				$json['status'] = 1;
				
				//$json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
				

				//$this->response->redirect($this->url->link('account/success'));
			
			}else {
				$json['status'] = 0;
				$json['error']['key'] = $this->language->get('error_key');
			}
		}else{			$json['status'] = 0;
			$json['validate_error'] = $this->error;
		}
		if (isset($this->request->server['HTTP_ORIGIN'])) {			$this->response->addHeader('Access-Control-Allow-Origin: ' . $this->request->server['HTTP_ORIGIN']);			$this->response->addHeader('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');			$this->response->addHeader('Access-Control-Max-Age: 1000');			$this->response->addHeader('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');		}		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	
	private function validate() {
		if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
			$this->error['lastname'] = $this->language->get('error_lastname');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		if ((utf8_strlen($this->request->post['password']) < 6) || (utf8_strlen($this->request->post['password']) > 20)) {
			$this->error['password'] = $this->language->get('error_password');
		}

		if ($this->request->post['confirm'] != $this->request->post['password']) {
			$this->error['confirm'] = $this->language->get('error_confirm');
		}

		// Captcha
		/* if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array)$this->config->get('config_captcha_page'))) {
			$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

			if ($captcha) {
				$this->error['captcha'] = $captcha;
			}
		}
 */
		// Agree to terms
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			if ($information_info && !isset($this->request->post['agree'])) {
				$this->error['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}

		return !$this->error;
	}
}