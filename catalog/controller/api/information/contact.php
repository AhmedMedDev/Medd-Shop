<?php
class ControllerAPIInformationContact extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('information/contact');
		$data['heading_title'] = $this->language->get('heading_title');

		$this->document->setTitle($this->language->get('heading_title'));
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

			if(!$this->validate()) {
				$json['status'] = 0;

				$json['error'] = $this->error;
				//$this->response->setOutput(json_encode($json));
				echo json_encode($json);
				exit;
			}

			$this->load->language('mail/contact');
			$server = '';
			if ($this->request->server['HTTPS']) {
				$server = $this->config->get('config_ssl');
			} else {
				$server = $this->config->get('config_url');
			}

			/*$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');*/

			$first_name = $this->request->post['fname'];
			$last_name 	= $this->request->post['lname'];
			$senders_full_name = $first_name.' '.$last_name;
			$phone 		= $this->request->post['phone'];
			$email 		= $this->request->post['email'];
			$enquiry 	= $this->request->post['enquiry'];

			$message = array();
			$message[$this->language->get('text_fname')] 		= $first_name;
			$message[$this->language->get('text_lname')] 		= $last_name;
			$message[$this->language->get('text_phone')] 		= $phone;
			$message[$this->language->get('text_email')] 		= $email;
			$message[$this->language->get('text_enquiry')] 		= $enquiry;

			$data['message']    	= $this->language->get('text_success_message');

			$data['name'] = $this->config->get('config_name');

			if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
				$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
			} else {
				$data['logo'] = '';
			}

			if (is_file(DIR_IMAGE . 'email/banner.jpg')) {
				$data['link_banner_image'] = $server . 'image/email/banner/contact.jpg';
			} else {
				$data['link_banner_image'] = '';
			}

			$data['text_register'] = $this->language->get('text_register');
			$data['text_login'] = $this->language->get('text_login');
			$data['text_about_us'] = $this->language->get('text_about_us');
			$data['text_message_title'] = $this->language->get('text_message_title');

			$data['text_details'] = $this->language->get('text_details');
			$data['text_bottom_top'] = $this->language->get('text_bottom_top');

			$data['text_bottom'] = $this->language->get('text_bottom');

			$data['home'] = $this->url->link('common/home');
			$data['register'] = $this->url->link('account/register', '', 'SSL');
			$data['login'] = $this->url->link('account/login', '', 'SSL');
			$data['about_us'] = $this->url->link('information/information&information_id=4', '', 'SSL');

			$mailHelper = new MailHelper($this->config);
			$mailHelper->setSenderName($senders_full_name);
			$mailHelper->setSenderEmail($this->config->get('config_email'));
			$mailHelper->sendEmail($this->config->get('config_email'),sprintf($this->language->get('text_email_subject'), $first_name), $html, $this->request->post['enquiry']);

			/*$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($email);
			$mail->setSender(html_entity_decode($senders_full_name, ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('text_email_subject'), $first_name), ENT_QUOTES, 'UTF-8'));
			if($html!=''){
				$mail->setHtml($html);
			}
			$mail->setText($this->request->post['enquiry']);
			$mail->send();*/
			$data['status'] = 1;
			//$this->response->setOutput(json_encode($data));
			echo json_encode($data);
			exit;
			//$this->response->redirect($this->url->link('information/contact/success'));
		}



		$string = str_replace("\r", '', $this->config->get('config_address'));
		$string = str_replace("\n", ' ', $string);
		$data['store'] = $this->config->get('config_name');
		$data['address'] = $string;
		$content = html_entity_decode($this->config->get('config_contact_email'));
		//echo strip_tags($content);
		$data['contact_email'] = strip_tags($content);

		$data['geocode_hl'] = $this->config->get('config_language');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['fax'] = $this->config->get('config_fax');
		$data['open'] = nl2br($this->config->get('config_open'));
		$data['comment'] = $this->config->get('config_comment');

		$data['status'] = 1;
		$this->response->setOutput(json_encode($data));

	}

	protected function validate() {
		if ((utf8_strlen($this->request->post['fname']) < 3) || (utf8_strlen($this->request->post['fname']) > 32)) {
			$this->error['fname'] = $this->language->get('error_fname');
		}
		if ((utf8_strlen($this->request->post['lname']) < 3) || (utf8_strlen($this->request->post['lname']) > 32)) {
			$this->error['lname'] = $this->language->get('error_lname');
		}

		if (!preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		if(empty($this->error)){
			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$this->error['captcha'] = $captcha;
				}
			}
		}

		return !$this->error;
	}

	public function success() {
		$this->load->language('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_message'] = $this->language->get('text_success');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/success.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/success.tpl', $data));
		}
	}
}
