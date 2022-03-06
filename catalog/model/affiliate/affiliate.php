<?php
class ModelAffiliateAffiliate extends Model {
	public function addAffiliate($data) {
		$this->event->trigger('pre.affiliate.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "affiliate SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', company = '" . $this->db->escape($data['company']) . "', website = '" . $this->db->escape($data['website']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', code = '" . $this->db->escape(uniqid()) . "', commission = '" . (float)$this->config->get('config_affiliate_commission') . "', tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', paypal = '" . $this->db->escape($data['paypal']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "', status = '1', approved = '" . (int)!$this->config->get('config_affiliate_approval') . "', date_added = NOW()");

		$affiliate_id = $this->db->getLastId();

		$this->load->language('mail/affiliate');

		$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

		$text_message_title = sprintf($this->language->get('text_welcome'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";

		if (!$this->config->get('config_affiliate_approval')) {
			$message .= $this->language->get('text_login') . "\n";
		} else {
			$message .= $this->language->get('text_approval') . "\n";
		}

		$message .= $this->url->link('affiliate/login', '', 'SSL') . "\n\n";
		$message .= $this->language->get('text_services') . "\n\n";

		$data['message1'] = $message;

		$temp1 = $this->language->get('text_thanks') . "\n";
		$message .= $temp1;
		$temp2 = html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');
		$message .= $temp2;

		$data['message2'] = $temp1.$temp2;

		$message = $text_message_title.$message;
		$message =  nl2br($message);
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
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/affiliate_register.tpl')) {
			$html = $this->load->view($this->config->get('config_template') . '/template/mail/affiliate_register.tpl', $data);
		} else {
			$html = '';
		}

		$mailHelper = new MailHelper($this->config);
		$mailHelper->sendEmail($this->request->post['email'], $subject, $html, $message);

		/*$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setTo($this->request->post['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject($subject);
		if($html!=''){
			$mail->setHtml($html);
		}
		$mail->setText($message);
		$mail->send();*/

		// Send to main admin email if new affiliate email is enabled
		if ($this->config->get('config_affiliate_mail')) {
			$message_to_admin  = $this->language->get('text_signup') . "\n\n";
			$message_to_admin .= $this->language->get('text_store') . ' ' . html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8') . "\n";
			$message_to_admin .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
			$message_to_admin .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";

			if ($data['website']) {
				$message_to_admin .= $this->language->get('text_website') . ' ' . $data['website'] . "\n";
			}

			if ($data['company']) {
				$message_to_admin .= $this->language->get('text_company') . ' '  . $data['company'] . "\n";
			}

			$message_to_admin .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
			$message_to_admin .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";
			$message_to_admin =  nl2br($message_to_admin);

			$message = array();

			$data['text_message_title'] = $this->language->get('text_signup');

			$message[$this->language->get('text_store')]  = html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');
			$message[$this->language->get('text_website')]  = $data['website'] ;
			$message[$this->language->get('text_firstname')] = $data['firstname'] ;
			$message[$this->language->get('text_lastname')] = $data['lastname'];
			$message[$this->language->get('text_company')] =  $data['company'];
			$message[$this->language->get('text_email')] =  $data['email'];
			$message[$this->language->get('text_telephone')] = $data['telephone'];

			$data['message']	= $message;//overrride value

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/affiliate.tpl')) {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/affiliate.tpl', $data);
			} else {
				$html = '';
			}

			$mailHelper->sendEmail($this->config->get('config_email'), $this->language->get('text_new_affiliate'), $html, $message_to_admin);

			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {

					$mailHelper->sendEmail($email, $this->language->get('text_new_affiliate'), $html, $message_to_admin);
				}
			}

			/*$mail->setTo($this->config->get('config_email'));
			$mail->setSubject(html_entity_decode($this->language->get('text_new_affiliate'), ENT_QUOTES, 'UTF-8'));
			if($html!=''){
				echo $mail->setHtml($html);
			}
			$mail->setText($message_to_admin);
			$mail->send();*/

			// Send to additional alert emails if new affiliate email is enabled
			/*$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}*/
		}

		$this->event->trigger('post.affiliate.add', $affiliate_id);

		return $affiliate_id;
	}

	public function editAffiliate($data) {
		$this->event->trigger('pre.affiliate.edit', $data);

		$affiliate_id = $this->affiliate->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', company = '" . $this->db->escape($data['company']) . "', website = '" . $this->db->escape($data['website']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "' WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		$this->event->trigger('post.affiliate.edit', $affiliate_id);
	}

	public function editPayment($data) {
		$this->event->trigger('pre.affiliate.edit.payment', $data);

		$affiliate_id = $this->affiliate->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', paypal = '" . $this->db->escape($data['paypal']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "' WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		$this->event->trigger('post.affiliate.edit.payment', $affiliate_id);
	}

	public function editPassword($email, $password) {
		$affiliate_id = $this->affiliate->getId();

		$this->event->trigger('pre.affiliate.edit.password', $affiliate_id);

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET salt = '" . $this->db->escape($salt = token(9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		$this->event->trigger('post.affiliate.edit.password', $affiliate_id);
	}

	public function getAffiliate($affiliate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		return $query->row;
	}

	public function getAffiliateByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getAffiliateByCode($code) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE code = '" . $this->db->escape($code) . "'");

		return $query->row;
	}

	public function getTotalAffiliatesByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}

	public function addTransaction($affiliate_id, $amount = '', $order_id = 0) {
		$affiliate_info = $this->getAffiliate($affiliate_id);

		if ($affiliate_info) {
			$this->event->trigger('pre.affiliate.add.transaction');

			$this->load->language('mail/affiliate');

			$this->db->query("INSERT INTO " . DB_PREFIX . "affiliate_transaction SET affiliate_id = '" . (int)$affiliate_id . "', order_id = '" . (float)$order_id . "', description = '" . $this->db->escape($this->language->get('text_order_id') . ' #' . $order_id) . "', amount = '" . (float)$amount . "', date_added = NOW()");

			$affiliate_transaction_id = $this->db->getLastId();

			$message  = sprintf($this->language->get('text_transaction_received'), $this->currency->format($amount, $this->config->get('config_currency'))) . "\n\n";
			$message .= sprintf($this->language->get('text_transaction_total'), $this->currency->format($this->getTransactionTotal($affiliate_id), $this->config->get('config_currency')));
			$message =  nl2br($message);
			$subject = sprintf($this->language->get('text_transaction_subject'), $this->config->get('config_name'));
			$mailHelper = new MailHelper($this->config);
			//$mailHelper->sendEmail($affiliate_info['email'], $subject, '', $message);
			$mailHelper->sendEmail($affiliate_info['email'], $subject, $message, '');

			/*$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($affiliate_info['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(sprintf($this->language->get('text_transaction_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')));
			$mail->setText($message);
			$mail->send();*/

			$this->event->trigger('post.affiliate.add.transaction', $affiliate_transaction_id);
		}
	}

	public function deleteTransaction($order_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "affiliate_transaction WHERE order_id = '" . (int)$order_id . "'");
	}

	public function getTransactionTotal($affiliate_id) {
		$query = $this->db->query("SELECT SUM(amount) AS total FROM " . DB_PREFIX . "affiliate_transaction WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		return $query->row['total'];
	}
}
