<?php
class ModelCatalogReview extends Model {
	public function addReview($product_id, $data) {
		$this->event->trigger('pre.review.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', text = '" . $this->db->escape($data['text']) . "',  title = '" . $this->db->escape($data['title']) . "', rating = '" . (int)$data['rating'] . "', date_added = NOW()");

		$review_id = $this->db->getLastId();

		if ($this->config->get('config_review_mail')) {
			$this->load->language('mail/review');
			$this->load->model('catalog/product');
			$server = '';
			if ($this->request->server['HTTPS']) {
				$server = $this->config->get('config_ssl');
			} else {
				$server = $this->config->get('config_url');
			}
			$product_info = $this->model_catalog_product->getProduct($product_id);

			$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

			$text_message_title  = $this->language->get('text_waiting') . "\n";

			$message = array();
			$message[$this->language->get('text_product')] = html_entity_decode($product_info['name'], ENT_QUOTES, 'UTF-8');
			$message[$this->language->get('text_reviewer')] = html_entity_decode($data['name'], ENT_QUOTES, 'UTF-8');
			$message[$this->language->get('text_title')] = html_entity_decode($data['title'], ENT_QUOTES, 'UTF-8');
			$message[$this->language->get('text_rating')] = $data['rating'];
			$message[$this->language->get('text_review')] = html_entity_decode($data['text'], ENT_QUOTES, 'UTF-8');

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
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/review.tpl')) {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/review.tpl', $data);
			} else {
				$html = '';
			}

			$mailHelper = new MailHelper($this->config);
			$mailHelper->setSenderName($order_info['store_name']);
			$mailHelper->sendEmail($this->config->get('config_email'), $subject, $html);

			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mailHelper->sendEmail($email, $subject, $html);
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
			$mail->setSubject($subject);
			$mail->setHtml($html);
			$mail->send();*/

			// Send to additional alert emails
			/*$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->setHtml($html);
					$mail->send();
				}
			}*/
		}

		$this->event->trigger('post.review.add', $review_id);
	}

	public function getReviewsByProductId($product_id, $start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 20;
		}

		$query = $this->db->query("SELECT r.review_id, r.author, r.rating, r.text, r.title,r.customer_id, p.product_id, pd.name, p.price, p.image, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY r.date_added DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	public function getTotalReviewsByProductId($product_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row['total'];
	}

	public function getTotalReviewsCountByProductId($product_id) {
		$query = '
		SELECT
		sum(case when product_id = '.(int)$product_id.' AND rating = 1 AND status = 1 then 1 else 0 end) as rating_count_1,
		sum(case when product_id = '.(int)$product_id.' AND rating = 2 AND status = 1 then 1 else 0 end) as rating_count_2,
		sum(case when product_id = '.(int)$product_id.' AND rating = 3 AND status = 1 then 1 else 0 end) as rating_count_3,
		sum(case when product_id = '.(int)$product_id.' AND rating = 4 AND status = 1 then 1 else 0 end) as rating_count_4,
		sum(case when product_id = '.(int)$product_id.' AND rating = 5 AND status = 1 then 1 else 0 end) as rating_count_5
		FROM '.DB_PREFIX. 'review';

		$query = $this->db->query($query);
		return $query->row;
	}


}
