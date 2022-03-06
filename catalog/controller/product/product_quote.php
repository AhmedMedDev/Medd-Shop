<?php
class ControllerProductProductQuote extends Controller {
	private $error = array();

	public function index() {
		$this->language->load('product/product_quote');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');

		echo $this->getForm();
		die();
	}

	public function add() {
		if($this->request->server['REQUEST_METHOD'] !== 'POST'){
			die('Unauthorized request');
		}
		$this->language->load('product/product_quote');

		$this->load->model('catalog/product_quote');

		$result = array(
			'success' => '',
			'error' => '',
			'referrer' => '',
		);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$value = $this->request->post;
			$postedData = array();
			$postedData['name']  	= html_entity_decode($value['name'], ENT_QUOTES, 'UTF-8');
			$postedData['email']	= html_entity_decode($value['email'], ENT_QUOTES, 'UTF-8');
			$postedData['phone']	= $this->getPhoneNumber($value['phone']);
			$postedData['comments'] = html_entity_decode($value['comments'], ENT_QUOTES, 'UTF-8');
			$pid = (intval($value['product_id'])>0) ? (int)$value['product_id'] : 'NA';

			$client_ip = '<a href="http://www.ip2location.com/'.$_SERVER['REMOTE_ADDR'].'" target="_blank">'.$_SERVER['REMOTE_ADDR'].'</a>';

			$referrer = array(
				'product_id' => $pid,
				'product_name' => $value['product_name'],
				'quantity' => (int)$value['quantity'],
				'Referrer' => html_entity_decode($value['url_referrer'], ENT_QUOTES, 'UTF-8'),
				'User IP' => $client_ip,
			);
			$postedData['referrer'] = $referrer;
			$postedData['type'] = html_entity_decode($value['type'], ENT_QUOTES, 'UTF-8');
			$this->model_catalog_product_quote->addProductQuoteRequest($postedData);

			$this->load->language('mail/product_quote');
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

			$message = array();
			$message[$this->language->get('text_name')] 		= $postedData['name'];
			$message[$this->language->get('text_phone')] 		= $postedData['phone'];
			$message[$this->language->get('text_email')] 		= $postedData['email'];
			$message[$this->language->get('text_comments')] 	= $postedData['comments'];
			$message[$this->language->get('referrer')] 	= $referrer;

			$data['message']    	= $message;

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
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/product_quote.tpl')) {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/product_quote.tpl', $data);
			} else {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/contact.tpl', $data);
			}

			$subject = html_entity_decode(sprintf($this->language->get('text_email_subject'), $postedData['name']), ENT_QUOTES, 'UTF-8');

			if(isset($value['route'])){
				$route_array = array('product/search');
				if(in_array($value['route'], $route_array)){
					$subject = html_entity_decode(sprintf($this->language->get('text_message_title_others'), $postedData['name']), ENT_QUOTES, 'UTF-8');//new product
				}
			}

			$mailHelper = new MailHelper($this->config);
			$mailHelper->setSenderName($postedData['name']);
			$mailHelper->setSenderEmail($this->config->get('config_email'));
			$mailHelper->sendEmail($this->config->get('config_email'), $subject, $html);

			/*$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($postedData['email']);
			$mail->setSender(html_entity_decode($postedData['name'], ENT_QUOTES, 'UTF-8'));
			$mail->setSubject($subject);
			if($html!=''){
				$mail->setHtml($html);
			}
			#$mail->setText($postedData['comments']);
			$mail->send();*/

			/******************EMAIL TO CUSTOMER*************************/
			$data = array();
			$subject = html_entity_decode(sprintf($this->language->get('text_email_subject_customer'), $postedData['name']), ENT_QUOTES, 'UTF-8');

			$data['message1'] = $this->language->get('text_customer_message');

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
			$mailHelper->sendEmail($postedData['email'], $subject, $html);

			/*$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($postedData['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject($subject);
			if($html!=''){
				$mail->sethtml($html);
			}
			$mail->send();*/

			$result['success']  = $this->language->get('text_success');
			$result['referrer'] = $value['url_referrer'];
		}
		if(!empty($this->error)){
			$html_error = '<ul class="error">';
			foreach($this->error AS $key=>$error){
				$html_error .= '<li>'.ucwords(str_replace("_", " ",$key)).': '.$error.'</li>';
			}
			$html_error .= '</ul>';

			$temperror = array();
			foreach($this->error AS $key=>$error){
				$temperror[$key] = $error;
			}
			$temperror = json_encode($temperror);

			$result['error'] = $temperror;
			//$result['error'] = $html_error;
		}
		die(json_encode($result));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_product']     		= $this->language->get('text_product');
		$data['text_quantity']      	= $this->language->get('text_quantity');
		$data['text_name']            	= $this->language->get('text_name');
		$data['text_email']      		= $this->language->get('text_email');
		$data['text_phone'] 			= $this->language->get('text_phone');
		$data['text_comments'] 	 		= $this->language->get('text_comments');
		$data['text_comments_help'] 	= $this->language->get('text_comments_help');

		if ($this->customer->isLogged()) {
			$data['entry_name'] = trim($this->customer->getFirstName()).' '.trim($this->customer->getLastName());
			$data['entry_email'] = trim($this->customer->getEmail());
			$data['entry_phone'] = trim(str_replace(" ","",$this->customer->getTelephone()));
		}

		$data['text_button'] = $this->language->get(text_button);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = array();
		}

		if (isset($this->error['phone'])) {
			$data['error_phone'] = $this->error['phone'];
		} else {
			$data['error_phone'] = '';
		}

		// Captcha
		if ($this->config->get('basic_captcha_status')) {
			$data['captcha'] = $this->load->controller('captcha/basic_captcha', $this->error);
		} else {
			$data['captcha'] = '';
		}


		$data['action'] = $this->url->link('product/product_quote/add');

		if (isset($this->request->get['product_id'])) {
			$product_quote_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
			$data['product_quote_info'] = $product_quote_info;
		}else{
			$data['product_quote_info'] = array();
		}

		if (isset($this->request->get['route'])) {
			$data['route'] = $this->request->get['route'];
		}
		if (isset($this->request->get['type'])) {
			$data['type'] = $this->request->get['type'];
		}

		$data['url_referrer'] = $_SERVER['HTTP_REFERER'];

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product_quote.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/product/product_quote.tpl', $data);
		} else {
			return $this->load->view('default/template/product/product_quote.tpl', $data);
		}
	}

	protected function validateForm() {
		$value = $this->request->post;

		if ((utf8_strlen($value['quantity']) < 1)) {
			$this->error['quantity'] = $this->language->get('error_quantity');
		}
		if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 50)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		if ((utf8_strlen($value['email']) < 7) || (utf8_strlen($value['email']) > 50)) {
			$this->error['email'] = $this->language->get('error_email');
		}else if (!preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($value['phone']) < 10) || (utf8_strlen($value['phone']) > 20)) {
			$this->error['phone'] = $this->language->get('error_phone');
		}
		if ((utf8_strlen($value['comments']) < 20) || (utf8_strlen($value['comments']) > 500)) {
			$this->error['comments'] = $this->language->get('error_comments');
		}
		if(isset($value['how_day']) && utf8_strlen($value['how_day'])>0) {
			$this->error['request'] = 'Unauthorized';
		}

		if(empty($this->error)){
			// Captcha
			if ($this->config->get('basic_captcha_status') ) {
				$captcha = $this->load->controller('captcha/basic_captcha/validate');
				if ($captcha) {
					$this->error['captcha'] = $captcha;
				}
			}
		}


		return !$this->error;
	}
	protected function getPhoneNumber($phoneNumber){
		$phoneNumber = preg_replace("/[^0-9]/","",$phoneNumber);
		return $phoneNumber;
	}
}
