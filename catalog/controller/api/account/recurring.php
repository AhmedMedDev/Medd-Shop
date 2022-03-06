<?php
class ControllerAPIAccountRecurring extends Controller {
	public function index() {
		
		$this->load->controller('api/common/header');
		$this->language->load('account/recurring');
		$this->load->model('account/recurring');
		
		$this->document->setTitle($this->language->get('heading_title'));
		$url = '';
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}
		$data['current_page_url'] = $_SERVER['REQUEST_URI'];
		
		$data['button_view'] = $this->language->get('button_view');
		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['orders'] = array();
		
		$recurring_total = $this->model_account_recurring->getTotalRecurring();
		/* print_r($recurring_total); */
		$results = $this->model_account_recurring->getAllProfiles(($page - 1) * 10, 10);

		$data['recurrings'] = array();
		
		/* Dummy Custom Content */		
		
		/* $results = array(array('order_recurring_id'=>20,'product_name'=>'test','status'=>1,'date_added'=>'2017-05-20')); */
		
		/* Dummy Custom Content */
		
		if ($results) {
			foreach ($results as $result) {
				$data['recurrings'][] = array(
					'id'                    => $result['order_recurring_id'],
					'name'                  => $result['product_name'],
					'status'                => $result['status'],
					'date_added'               => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'href'                  => $this->url->link('account/recurring/info', 'recurring_id=' . $result['order_recurring_id'], 'SSL'),
				);
			}
		}

		$data['status_types'] = array(
			1 => $this->language->get('text_status_inactive'),
			2 => $this->language->get('text_status_active'),
			3 => $this->language->get('text_status_suspended'),
			4 => $this->language->get('text_status_cancelled'),
			5 => $this->language->get('text_status_expired'),
			6 => $this->language->get('text_status_pending'),
		);

		$pagination = new Pagination();
		$pagination->total = $recurring_total;
		$pagination->page = $page;
		$pagination->limit = 10;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/recurring', 'page={page}', 'SSL');
		$data['pagination'] = $pagination->render();
		$data['continue'] = $this->url->link('account/account', '', 'SSL');
		$data['status'] = 1;
		$this->response->setOutput(json_encode($data));
	}

	public function info() {
		$this->load->model('account/recurring');
		$this->load->language('account/recurring');
		$this->load->controller('api/common/header');
		
		if (isset($this->request->get['recurring_id'])) {
			$recurring_id = $this->request->get['recurring_id'];
		} else {
			$recurring_id = 0;
		}
		
		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$recurring = $this->model_account_recurring->getProfile($this->request->get['recurring_id']);

		$data['status_types'] = array(
			1 => $this->language->get('text_status_inactive'),
			2 => $this->language->get('text_status_active'),
			3 => $this->language->get('text_status_suspended'),
			4 => $this->language->get('text_status_cancelled'),
			5 => $this->language->get('text_status_expired'),
			6 => $this->language->get('text_status_pending'),
		);

		$data['transaction_types'] = array(
			0 => $this->language->get('text_transaction_date_added'),
			1 => $this->language->get('text_transaction_payment'),
			2 => $this->language->get('text_transaction_outstanding_payment'),
			3 => $this->language->get('text_transaction_skipped'),
			4 => $this->language->get('text_transaction_failed'),
			5 => $this->language->get('text_transaction_cancelled'),
			6 => $this->language->get('text_transaction_suspended'),
			7 => $this->language->get('text_transaction_suspended_failed'),
			8 => $this->language->get('text_transaction_outstanding_failed'),
			9 => $this->language->get('text_transaction_expired'),
		);
		
		/* Dummy Custom Content */		
		
		$recurring = array('order_recurring_id'=>20,'product_name'=>'test','status'=>1,'date_added'=>'2017-05-20','payment_code'=>'pp_standard');
		
		/* Dummy Custom Content */
		
		if ($recurring) {
			$recurring['transactions'] = $this->model_account_recurring->getProfileTransactions($this->request->get['recurring_id']);

			$recurring['date_added'] = date($this->language->get('date_format_short'), strtotime($recurring['date_added']));
			$recurring['product_link'] = $this->url->link('product/product', 'product_id=' . $recurring['product_id'], 'SSL');
			$recurring['order_link'] = $this->url->link('account/order/info', 'order_id=' . $recurring['order_id'], 'SSL');

			$this->document->setTitle($this->language->get('text_recurring'));
			$data['recurring'] = $recurring;

			$data['buttons'] = $this->load->controller('payment/' . $recurring['payment_code'] . '/recurringButtons');
			
			$data['status'] = 1;
			
		} else {
			$data['status'] = 0;
			
		}
		$this->response->setOutput(json_encode($data));
	}
}