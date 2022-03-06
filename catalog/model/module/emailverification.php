<?php

class ModelModuleEmailVerification extends Model {
	public function sendVerificationEmail($customer_id)
	{

		$this->load->model('setting/setting');
		$this->load->model('account/customer');
		$this->load->model('localisation/language');
		$this->load->model('account/customer_group');

		//get language ID
		$settings = $this->model_setting_setting->getSetting('emailverification', $this->config->get('config_store_id'));
		$customer = $this->model_account_customer->getCustomer($customer_id);


		//get customer email
		$customer_email = $customer['email'];

		//generate link
		$email_link = $this->url->link('module/emailverification/verifyCustomer', 'customer_id='.base64_encode($customer_id));

		//generate message
		$messageToCustomer = html_entity_decode($settings['emailverification']['message'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		$wordTemplates = array("{first_name}", "{last_name}","{email_link}","{logo}","{site_url}","{web_name}");

		$web_name = $this->config->get('config_name');

		$server = '';
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$logo = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$logo = '';
		}

		$site_url = $server;

		$words   = array($customer['firstname'], $customer['lastname'],$email_link, $logo, $site_url, $web_name);

		$messageToCustomer = str_replace($wordTemplates, $words, $messageToCustomer);
		$messageToCustomer =  nl2br($messageToCustomer);
		$subject = $settings['emailverification']['subject'][$this->config->get('config_language_id')];

		$mailHelper = new MailHelper($this->config);
		$mailHelper->sendEmail($customer_email, $subject, $messageToCustomer);
	}

	public function verifyCustomer ($customer_id, $store_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET verified = 1  WHERE customer_id = '" . (int)$customer_id . "' AND store_id='".(int)$store_id."'");
	}

	public function approveCustomer ($customer_id, $store_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET approved = 1  WHERE customer_id = '" . (int)$customer_id . "' AND store_id='".(int)$store_id."'");
	}

	public function validateCustomerGroup($customer_group_id){
		$this->load->model('setting/setting');
		$settings = $this->model_setting_setting->getSetting('emailverification', $this->config->get('config_store_id'));
		$customer_groups = $settings['emailverification']['customerGroups'];
		return array_key_exists($customer_group_id, $customer_groups);
	}

	public function isCustomerVerified ($customer_id, $store_id){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "' AND store_id='".(int)$store_id."'");
		if($query->num_rows){
			return $query->row['verified'];
		}
	}

}
