<?php
class ModelAccountCustomer extends Model {
	public function addCustomer($data) {

		$this->event->trigger('pre.customer.add', $data);

		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? json_encode($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");

		$customer_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['address']) ? json_encode($data['custom_field']['address']) : '') . "'");

		$address_id = $this->db->getLastId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");

		$this->load->language('mail/customer');

		$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

		$this->load->language('mail/register');

		$text_message_title = sprintf($this->language->get('text_welcome'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";

		$this->load->model('setting/setting');
		$emailverification = $this->model_setting_setting->getSetting('emailverification', $this->config->get('config_store_id'));
		$skip_verification = false;

		if(isset($this->session->data['skipverification']) && $this->session->data['skipverification'] == true)
		{
			$skip_verification = true;
			unset($this->session->data['skipverification']);
		}
		if(!$skip_verification && $emailverification['emailverification']['enabled'] == 1){
			$this->load->model('module/emailverification');
			if($this->model_module_emailverification->validateCustomerGroup($customer_group_id)){
				$this->model_module_emailverification->sendVerificationEmail($customer_id);
			}
		}

		if ($customer_group_info['approval']) {
			$message_to_customer = '';

		    if(!$skip_verification && $emailverification['emailverification']['enabled'] == 1){
	                $message_to_customer .= $this->language->get('text_registration_message'). "\n";
	            } else {
	                $message_to_customer .= $this->language->get('text_login') . "\n";
	            }


		} else {
			$message_to_customer = $this->language->get('text_approval') . "\n";
		}

		if($emailverification['emailverification']['enabled'] != 1){
			$message_to_customer .= $this->url->link('account/login', '', 'SSL') . "\n\n";
			$message_to_customer .= $this->language->get('text_services') . "\n\n";
		}

		$data['message1'] = $message_to_customer;

		$message_to_customer = $this->language->get('text_thanks') . "<br/>";
		$message_to_customer .= html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');

		$data['message2'] = $message_to_customer;


		$server = '';
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}


		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		if (is_file(DIR_IMAGE . 'email/banner.jpg')) {
			$data['link_banner_image'] = $server . 'image/email/banner.jpg';
		} else {
			$data['link_banner_image'] = '';
		}

		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_about_us'] = $this->language->get('text_about_us');
		if($text_message_title==''){
			$data['text_message_title'] = $this->language->get('text_message_title');
		}else{
			$data['text_message_title'] = $text_message_title;
		}
		$data['text_bottom_top'] = $this->language->get('text_bottom_top');
		$data['text_bottom'] = $this->language->get('text_bottom');

		$data['home'] = $this->url->link('common/home');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['about_us'] = $this->url->link('information/information&information_id=4', '', 'SSL');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/customer_register.tpl')) {
			$html = $this->load->view($this->config->get('config_template') . '/template/mail/customer_register.tpl', $data);
		} else {
			$html = '';
		}

		$mailHelper = new MailHelper($this->config);
		$mailHelper->sendEmail($data['email'], $subject, $html, $message_to_customer);

		/*$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		if($html!=''){
			$mail->setHtml($html);
		}
		$mail->setText($message_to_customer);
		$mail->send();*/

		// Send to main admin email if new account email is enabled
		if ($this->config->get('config_account_mail')) {
			$message_to_admin  = $this->language->get('text_signup') . "\n\n";
			$message_to_admin .= $this->language->get('text_website') . ' ' . html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8') . "\n";
			$message_to_admin .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
			$message_to_admin .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
			$message_to_admin .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";
			$message_to_admin .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
			$message_to_admin .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";

			$message = array();

			$data['text_message_title'] = $this->language->get('text_signup');

			$message[$this->language->get('text_website')]  = html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8') ;
			$message[$this->language->get('text_firstname')] = $data['firstname'] ;
			$message[$this->language->get('text_lastname')] = $data['lastname'];
			$message[$this->language->get('text_customer_group')] =  $customer_group_info['name'];
			$message[$this->language->get('text_email')] =  $data['email'];
			$message[$this->language->get('text_telephone')] = $data['telephone'];

			$data['message']	= $message;//overrride value

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/register.tpl')) {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/register.tpl', $data);
			} else {
				$html = '';
			}

			$mailHelper = new MailHelper($this->config);

			$mailHelper->sendEmail($this->config->get('config_email'), $this->language->get('text_new_customer'), $html, $message_to_admin);

			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {

					$mailHelper->sendEmail($email, $this->language->get('text_new_customer'), $html, $message_to_admin);
				}
			}

			/*$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
			if($html!=''){
				echo $mail->setHtml($html);
			}
			$mail->setText($message_to_admin);
			$mail->send();*/

			// Send to additional alert emails if new account email is enabled
			/*$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}*/
		}

		$this->event->trigger('post.customer.add', $customer_id);

		return $customer_id;
	}

	public function editCustomer($data) {
		$this->event->trigger('pre.customer.edit', $data);

		$customer_id = $this->customer->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', share_cart_show_friends = '" . $this->db->escape($data['share_cart_show_friends']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']) ? json_encode($data['custom_field']) : '') . "' WHERE customer_id = '" . (int)$customer_id . "'");

		$this->event->trigger('post.customer.edit', $customer_id);
	}

	public function updateCurrency($currency_code,$customer_id){
		if($currency_code){
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET currency = '" . $currency_code . "' WHERE customer_id = '" . (int)$customer_id . "'");
		}
	}
	public function updateLanguage($language_code,$customer_id){
		if($language_code){
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET language = '" . $language_code . "' WHERE customer_id = '" . (int)$customer_id . "'");
		}
	}
	public function editPassword($email, $password) {
		$this->event->trigger('pre.customer.edit.password');

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		$this->event->trigger('post.customer.edit.password');
	}

	public function updateShareCartFriendStatus($customer_id, $status=0) {
		return $this->db->query("UPDATE " . DB_PREFIX . "customer SET share_cart_show_friends = '" . (int)$status . "' WHERE customer_id = '" . (int)$customer_id . "'");

	}


	public function editNewsletter($newsletter) {
		$this->event->trigger('pre.customer.edit.newsletter');

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int)$newsletter . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		$this->event->trigger('post.customer.edit.newsletter');
	}

	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row;
	}

	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getCustomerByToken($token) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");

		return $query->row;
	}

	public function getTotalCustomersByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}

	public function getRewardTotal($customer_id) {
		$query = $this->db->query("SELECT SUM(points) AS total FROM " . DB_PREFIX . "customer_reward WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row['total'];
	}

	public function getIps($customer_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->rows;
	}

	public function addLoginAttempt($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_login WHERE email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");

		if (!$query->num_rows) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_login SET email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', total = 1, date_added = '" . $this->db->escape(date('Y-m-d H:i:s')) . "', date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_login SET total = (total + 1), date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "' WHERE customer_login_id = '" . (int)$query->row['customer_login_id'] . "'");
		}
	}

	public function getLoginAttempts($email) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function deleteLoginAttempts($email) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}
}
