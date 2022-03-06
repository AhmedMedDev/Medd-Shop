<?php
class ControllerAPIAccountLogin extends Controller {
	private $error = array();
	public function index() {
		$json = array();
		$this->load->model('account/api');
		$this->load->language('api/login');
		$this->load->model('account/customer');
		// Check if IP is allowed

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('login', $activity_data);

			// Trigger customer post login event
			$this->event->trigger('post.customer.login');

			$ip_data = array();

			$results = $this->model_account_api->getApiIps($this->config->get('config_api_id'));
			foreach ($results as $result) {
				$ip_data[] = $result['ip'];
			}

			if (!$json) {
				// Login with API Key
				$api_info = $this->model_account_api->getApiByKey( $this->request->post[ 'key' ] );

				if ($api_info) {
					$json['success'] = $this->language->get( 'text_success' );
					$sesion_name = 'temp_session_' . uniqid();
					$session = new Session($this->session->getId(), $sesion_name);
					// Set API ID
					$session->data['api_id'] = $api_info['api_id'];
					$this->session->data['api_id'] = $api_info['api_id'];
					$json['email'] = $this->customer->getEmail();
					$json['id'] = $this->customer->getId();
					$json['name'] = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
					$json['profile_image'] = HTTP_SERVER_IMAGE .'profile/'. $this->customer->getProfileImage();
					$json['status'] = 1;
					// Create Token
					$json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
					$this->model_account_api->updateUserToken($this->customer->getId(),$json['token']);
					$this->session->data['api_token'] = $json['token'];
				} else {
					$json['status'] = 0;
					$json['error']['key'] = $this->language->get('error_key');
				}
			}
		}else{
			$json['status'] = 0;
			$json['error'] = $this->error;
		}
		if (isset($this->request->server['HTTP_ORIGIN'])) {
			$this->response->addHeader('Access-Control-Allow-Origin: ' . $this->request->server['HTTP_ORIGIN']);
			$this->response->addHeader('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
			$this->response->addHeader('Access-Control-Max-Age: 1000');
			$this->response->addHeader('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	protected function validate() {
		if(isset($this->session->data['provider']) && $this->session->data['provider']!=''){
			$this->session->data['provider'] = '';
		}

		$this->event->trigger('pre.customer.login');

		// Check how many login attempts have been made.
		$login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);

		if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
			$this->error = $this->language->get('error_attempts');
		}

		// Check if customer has been approved.
		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
		$email_verification_module = $this->config->get("emailverification");

		if(isset($email_verification_module ['enabled']) && $email_verification_module ['enabled']==1){
			if(!empty($customer_info) && $customer_info['verified']!=1){
				$this->language->load('module/emailverification');
				$this->error = $this->language->get('error_verified');
			}
		}

		if ($customer_info && !$customer_info['approved']) {

			$this->error = $this->language->get('error_approved');
		}

		if ($customer_info && !$customer_info['status']) {
			$this->error = $this->language->get('error_deactivated');
		}

		/*if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error = $this->language->get('error_email');
		}*/
		if (!$this->error) {
			if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$this->error = $this->language->get('error_login');
				$this->model_account_customer->addLoginAttempt($this->request->post['email']);
			} else {
				$this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
			}
		}
		return !$this->error;
	}
}
