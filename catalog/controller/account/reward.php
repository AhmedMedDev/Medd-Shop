<?php
class ControllerAccountReward extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/reward', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/jQueryTab.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/animation.css');
		$this->document->addScript('catalog/view/theme/growcer/js/jQueryTab.js');
		
		$this->load->language('account/reward');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_reward'),
			'href' => $this->url->link('account/reward', '', 'SSL')
		);

		$this->load->model('account/reward');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['nav_text_order'] = $this->language->get('nav_text_order');
		$data['nav_text_download'] = $this->language->get('nav_text_download');
		$data['nav_text_return'] = $this->language->get('nav_text_return');
		$data['nav_text_reward'] = $this->language->get('nav_text_reward');
		$data['nav_text_transaction'] = $this->language->get('nav_text_transaction');
		$data['nav_text_recurring'] = $this->language->get('nav_text_recurring');
		$data['nav_text_voucher'] = $this->language->get('nav_text_voucher');
		
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_description'] = $this->language->get('column_description');
		$data['column_points'] = $this->language->get('column_points');

		$data['text_total'] = $this->language->get('text_total');
		$data['text_empty'] = $this->language->get('text_empty');

		$data['text_order'] = $this->language->get('text_order');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_recurring'] = $this->language->get('text_recurring');
		
		$data['help_text_order'] = $this->language->get('help_text_order');
		$data['help_text_download'] = $this->language->get('help_text_download');
		$data['help_text_reward'] = $this->language->get('help_text_reward');
		$data['help_text_return'] = $this->language->get('help_text_return');
		$data['help_text_transaction'] = $this->language->get('help_text_transaction');
		$data['help_text_recurring'] = $this->language->get('help_text_recurring');
		
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['return'] = $this->url->link('account/return', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['recurring'] = $this->url->link('account/recurring', '', 'SSL');

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}
		$data['current_page_url'] = $_SERVER['REQUEST_URI'];
		
		
		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['rewards'] = array();

		$filter_data = array(
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);

		$reward_total = $this->model_account_reward->getTotalRewards();

		$results = $this->model_account_reward->getRewards($filter_data);

		foreach ($results as $result) {
			$data['rewards'][] = array(
				'order_id'    => $result['order_id'],
				'points'      => $result['points'],
				'description' => $result['description'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'href'        => $this->url->link('account/order/info', 'order_id=' . $result['order_id'], 'SSL')
			);
		}

		$pagination = new Pagination();
		$pagination->total = $reward_total;
		$pagination->page = $page;
		$pagination->limit = 10;
		$pagination->url = $this->url->link('account/reward', 'page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($reward_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($reward_total - 10)) ? $reward_total : ((($page - 1) * 10) + 10), $reward_total, ceil($reward_total / 10));

		$data['total'] = (int)$this->customer->getRewardPoints();

		$data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		$data['account_sidebar'] = $this->load->controller('account/account_sidebar');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/reward.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/reward.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/reward.tpl', $data));
		}
	}
}