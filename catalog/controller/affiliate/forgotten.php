<?php
class ControllerAffiliateForgotten extends Controller {
	private $error = array();

	public function index() {
		if ($this->affiliate->isLogged()) {
			$this->response->redirect($this->url->link('affiliate/account', '', 'SSL'));
		}

		$this->load->language('affiliate/forgotten');

		$this->document->setTitle($this->language->get('page_heading_title'));

		$this->load->model('affiliate/affiliate');
		$this->document->addStyle('catalog/view/theme/growcer/css/login.css');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$server = '';
			if ($this->request->server['HTTPS']) {
				$server = $this->config->get('config_ssl');
			} else {
				$server = $this->config->get('config_url');
			}		
		
			$this->load->language('mail/forgotten');

			$password = token(10);

			$this->model_affiliate_affiliate->editPassword($this->request->post['email'], $password);
			
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
				

			/* $mail = new Mail();
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
			$mail->send(); */

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByEmail($this->request->post['email']);

			if ($affiliate_info) {
				$this->load->model('affiliate/activity');

				$activity_data = array(
					'affiliate_id' => $affiliate_info['affiliate_id'],
					'name'         => $affiliate_info['firstname'] . ' ' . $affiliate_info['lastname']
				);

				$this->model_affiliate_activity->addActivity('forgotten', $activity_data);
			}

			$this->response->redirect($this->url->link('affiliate/login', '', 'SSL'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('affiliate/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_forgotten'),
			'href' => $this->url->link('affiliate/forgotten', '', 'SSL')
		);

		$data['page_heading_title'] = $this->language->get('page_heading_title');
		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array)$this->config->get('config_captcha_page'))) {
			$data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'), $this->error);
		} else {
			$data['captcha'] = ''; 
		}		

		$data['text_your_email'] = $this->language->get('text_your_email');
		$data['text_email'] = $this->language->get('text_email');

		$data['entry_email'] = $this->language->get('entry_email');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_back'] = $this->language->get('button_back');
		$data['button_submit'] = $this->language->get('button_submit');		

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['action'] = $this->url->link('affiliate/forgotten', '', 'SSL');

		$data['back'] = $this->url->link('affiliate/login', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/affiliate/forgotten.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/affiliate/forgotten.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/affiliate/forgotten.tpl', $data));
		}
	}

	protected function validate() {
		if (!isset($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		} elseif (!$this->model_affiliate_affiliate->getTotalAffiliatesByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		}
		
		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array)$this->config->get('config_captcha_page'))) {
			$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

			if ($captcha) {
				$this->error['captcha'] = $captcha;
			}
		}		

		$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByEmail($this->request->post['email']);

		if ($affiliate_info && !$affiliate_info['approved']) {
		    $this->error['warning'] = $this->language->get('error_approved');
		}

		return !$this->error;
	}
}
