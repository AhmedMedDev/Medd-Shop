<?php
class ControllerAPIAccountMessage extends Controller {
	public function index() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);

		$this->load->language('account/message');
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		
		$data['recurring'] = $this->url->link('account/recurring', '', 'SSL');

		$data['delete'] = $this->url->link('account/message/delete', '', 'SSL');
		

		$this->response->setOutput(json_encode($data));
	}
	
	public function delete() {
		$this->load->language('account/message');

		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);

		$this->load->model('api/account/message');

		if ($customerId) {
			$this->model_api_account_message->deleteCustomerMessages($customerId);
			
			//$this->session->data['success'] = $this->language->get('text_modifiy_success');

			$data['success'] = $this->language->get('text_modifiy_success');
			$data['status'] = 1;
		}
		$this->response->setOutput(json_encode($data));
	}

	public function sendMessage() {
		$json = array();
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		$this->load->model('api/account/message');
		$this->language->load('account/message');
		if($customerId) {
			if(empty($this->request->post['message'])) {
				$json['error_warning'] = $this->language->get('error_message');
				$json['status'] = 0;
			}
		
			if(!$json){
				$filter_data = array(
					'customer_id'          => $customerId,
					'sender'               => 'customer',
					'message'              => $this->request->post['message'],
				);
				
				
				$this->model_api_account_message->sendMessage($filter_data);
				$json['success'] = $this->language->get('text_success');
				$json['status'] = 1;
			}
		}
		$this->response->setOutput(json_encode($json));
	}
	
	
	public function viewMessage() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		
		if($customerId) {
			$data['messages'] =array();
			$this->load->language('account/message');
			$this->load->model('api/account/customer');
			$this->load->model('api/account/message');
			$this->load->model('account/wishlist');
			$data['text_administrator']  = $this->language->get('text_administrator');
			$data['text_no_message']  = $this->language->get('text_no_message');
			$data['cart_count'] = $this->cart->hasProducts();
			$data['compare_count'] = $this->customer->getCompareCount();
			$data['wishlist_count'] = $this->model_account_wishlist->getTotalWishlist();
			$customer_info =  $this->model_api_account_customer->getCustomer($customerId);
			
			$data['customer_name'] = ($customer_info) ?  $customer_info['firstname'].' '.$customer_info['lastname'] : '';
			if($customer_info) {
				$filter_data =array(
					'customer_id' => $this->customer->getId(),
					'filter_sender' => 'user',
					'filter_status' => '0',
				);
				$messages =  $this->model_api_account_message->getMessagesByCustomerId($filter_data);
				$messageCount = $this->model_api_account_message->countTotalMessage($filter_data);
				$this->model_api_account_message->updateReadStatus($filter_data);
				
				$total_unread = $this->model_api_account_message->getTotalUnreadMessages($filter_data);
				if($total_unread){
					$data['total_unread'] = '<b>'. $total_unread .'</b>';
				}else{
					$data['total_unread'] = '';
				}
				
				foreach($messages as $message) {
					$data['messages'][] = array(
						'sender'          => $message['sender'],
						//'message'         => html_entity_decode($message['message'], ENT_QUOTES, 'UTF-8'),
						'message'         => $message['message'],
						'name'            => $customer_info['firstname'].' '.$customer_info['lastname'],
						'date_added'      => $this->time_ago($message['date_added']),
					);
				}
			}
			
			$json['count_product'] = $this->cart->countProducts();
			
			$data['message_count'] = $messageCount;
			$data['status'] = 1;
			$this->response->setOutput(json_encode($data));
			$this->response->addHeader('Content-Type: application/json');
		}
	}
	
	public function time_ago($date) {

		if(empty($date)) {

		return "No date provided";

		}

		$periods = array("second", "minute", "hour", "day", "week", "month", "year", "decade");

		$lengths = array("60","60","24","7","4.35","12","10");

		$now = time();

		$unix_date = strtotime($date);

		$timezone = new DateTimeZone(DB_TIMEZONE_SETTING);
		
		$date = new DateTime();
		$date->setTimezone($timezone );
		$current_user_logged_time = $date->format( 'Y-m-d H:i:s' );	
			
		$date = strtotime($date);
		$now = strtotime($current_user_logged_time);		
		
		
		

		// check validity of date

		if(empty($unix_date)) {

		return "Bad date";

		}

		// is it future date or past date

		if($now > $unix_date) {

		$difference = $now - $unix_date;

		$tense = "ago";

		} else {

		$difference = $unix_date - $now;
		$tense = "from now";}

		for($j = 0; $difference >= $lengths[$j] && $j < count($lengths)-1; $j++) {

		$difference /= $lengths[$j];

		}

		$difference = round($difference);

		if($difference != 1) {

		$periods[$j].= "s";

		}

		return "$difference $periods[$j] {$tense}";
	}
}