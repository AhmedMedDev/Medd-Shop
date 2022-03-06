<?php
class ControllerAccountDashboard extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/dashboard', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		$this->load->language('account/dashboard');
		
		$this->load->language('account/account');
		$this->load->language('total/credit');		

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_dashboard'),
			'href' => $this->url->link('account/dashboard', '', 'SSL')
		);
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['heading_title'] = $this->language->get('text_dashboard');

		

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}
		
		$this->load->language('account/order');
		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_order'] = $this->language->get('text_order');
		
		$data['text_dashboard_wishlist']    = $this->language->get('text_dashboard_wishlist');
		$data['text_wishlist_link']    		= $this->language->get('text_wishlist_link');

		$data['text_total_credits'] 		= $this->language->get('text_total_credits');
		$data['text_total_credits_link'] 	= $this->language->get('text_total_credits_link');

		$data['text_total_orders']   		= $this->language->get('text_total_orders');
		$data['text_total_orders_link']   	= $this->language->get('text_total_orders_link');
		
		$data['text_total_rewards'] 		= $this->language->get('text_total_rewards');
		$data['text_total_rewards_link'] 	= $this->language->get('text_total_rewards_link');		
		
		
		$data['column_order_id'] = $this->language->get('column_order_id');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_customer'] = $this->language->get('column_customer');
		$data['column_product'] = $this->language->get('column_product');
		$data['column_total'] = $this->language->get('column_total');
		$data['column_action'] = $this->language->get('column_action');
		$data['button_view'] = $this->language->get('button_view');
		$data['button_continue'] = $this->language->get('button_continue');
			
		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');
			$data['total_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
		} else {
			$data['total_wishlist'] = (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0);
		}
		
		$data['orders'] = array();

		$this->load->model('account/order');

		$order_total = $this->model_account_order->getTotalOrders();
		
		$data['total_orders'] = $order_total;
		
		$results = $this->model_account_order->getOrders();

		foreach ($results as $result) {
			$product_total = $this->model_account_order->getTotalOrderProductsByOrderId($result['order_id']);
			$voucher_total = $this->model_account_order->getTotalOrderVouchersByOrderId($result['order_id']);

			$data['orders'][] = array(
				'order_id'   => $result['order_id'],
				'name'       => $result['firstname'] . ' ' . $result['lastname'],
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'products'   => ($product_total + $voucher_total),
				'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'href'       => $this->url->link('account/order/info', 'order_id=' . $result['order_id'], 'SSL'),
			);
		}
		
		$data['total_balance'] = $this->currency->format($this->customer->getBalance());		
		
		$data['total_rewards'] = (int)$this->customer->getRewardPoints();
		$data['manage_rewards_link'] = $this->url->link('account/reward', '', 'SSL');
		$data['manage_credits_link'] = $this->url->link('account/transaction', '', 'SSL');		
		
		
		$data['wishlist_link'] 		= $this->url->link('account/wishlist', '', 'SSL');
		$data['manage_account_link'] = $this->url->link('account/account', '', 'SSL');
		$data['view_order_history_link'] = $this->url->link('account/order', '', 'SSL');
		
		$data['account_sidebar'] = $this->load->controller('account/account_sidebar');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/dashboard.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/dashboard.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/account.tpl', $data));
		}
	}

}
