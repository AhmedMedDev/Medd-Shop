<?php
class ControllerApiAccountForgot extends Controller {
	private $error = array();

	public function index() {
		/* if ($this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
		} */
		$this->load->language('api/forgot');
		$this->document->setTitle($this->language->get('page_heading_title'));
		$this->load->model('account/api');
		$this->load->model('account/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$api_info = $this->model_account_api->getApiByKey( $this->request->post[ 'key' ] );
			if ($api_info) {

				$this->load->language('mail/forgotten');

				$server = '';
				if ($this->request->server['HTTPS']) {
					$server = $this->config->get('config_ssl');
				} else {
					$server = $this->config->get('config_url');
				}

				$password = substr(sha1(uniqid(mt_rand(), true)), 0, 10);

				$this->model_account_customer->editPassword($this->request->post['email'], $password);

				$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

				$text_message_title  = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

				$message = array();
				$message[$this->language->get('text_password')] = $password;
				$data['message'] = $message;

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
				$data['text_details'] = $this->language->get('text_details');
				$data['text_bottom_top'] = $this->language->get('text_bottom_top');

				$data['text_bottom'] = $this->language->get('text_bottom');

				$data['home'] = $this->url->link('common/home');
				$data['register'] = $this->url->link('account/register', '', 'SSL');
				$data['login'] = $this->url->link('account/login', '', 'SSL');
				$data['about_us'] = $this->url->link('information/information&information_id=4', '', 'SSL');
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/forgotpass.tpl')) {
					$html = $this->load->view($this->config->get('config_template') . '/template/mail/forgotpass.tpl', $data);
				} else {
					$html = '';
				}

				$mailHelper = new MailHelper($this->config);
				$mailHelper->sendEmail($this->request->post['email'], $subject, $html);

				/*
				$mail = new Mail();
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
				$mail->setHtml($html);
				$mail->send();
				*/

				$this->session->data['success'] = $this->language->get('text_success');

				// Add to activity log
				$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

				if ($customer_info) {
					$this->load->model('account/activity');

					$activity_data = array(
						'customer_id' => $customer_info['customer_id'],
						'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
					);

					$this->model_account_activity->addActivity('forgotten', $activity_data);
				}
				$json['status'] = 1;
				$json['text_success'] = $this->language->get( 'text_success' );
				//$this->response->redirect($this->url->link('account/login', '', 'SSL'));
			}else {
				$json['status'] = 0;
				$json['error']['key'] = $this->language->get('error_key');
			}
		}else{
			$json['status'] = 0;
			$json['error'] = $this->error;
		}
		$this->response->setOutput(json_encode($json));
	}

	protected function validate() {
		if (!isset($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		} elseif (!$this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		}

		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

		if ($customer_info && !$customer_info['approved']) {
		    $this->error['warning'] = $this->language->get('error_approved');
		}
		/* print_r($this->error);
		exit; */
		return !$this->error;
	}
}
