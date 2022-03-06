<?php
class ControllerAccountDownload extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/download', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
		$this->document->addStyle('catalog/view/theme/growcer/css/dashboard.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/jQueryTab.css');
		$this->document->addStyle('catalog/view/theme/growcer/css/animation.css');
		$this->document->addScript('catalog/view/theme/growcer/js/jQueryTab.js');
		
		$this->load->language('account/download');

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
			'text' => $this->language->get('text_downloads'),
			'href' => $this->url->link('account/download', '', 'SSL')
		);

		$this->load->model('account/download');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['nav_text_order'] = $this->language->get('nav_text_order');
		$data['nav_text_download'] = $this->language->get('nav_text_download');
		$data['nav_text_return'] = $this->language->get('nav_text_return');
		$data['nav_text_reward'] = $this->language->get('nav_text_reward');
		$data['nav_text_transaction'] = $this->language->get('nav_text_transaction');
		$data['nav_text_recurring'] = $this->language->get('nav_text_recurring');
		$data['nav_text_voucher'] = $this->language->get('nav_text_voucher');
		
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
		
		$data['column_order_id'] = $this->language->get('column_order_id');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_size'] = $this->language->get('column_size');
		$data['column_date_added'] = $this->language->get('column_date_added');
		
		$data['button_download'] = $this->language->get('button_download');
		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['downloads'] = array();

		$download_total = $this->model_account_download->getTotalDownloads();

		$results = $this->model_account_download->getDownloads(($page - 1) * $this->config->get('config_product_limit'), $this->config->get('config_product_limit'));

		foreach ($results as $result) {
			if (file_exists(DIR_DOWNLOAD . $result['filename'])) {
				$size = filesize(DIR_DOWNLOAD . $result['filename']);

				$i = 0;

				$suffix = array(
					'B',
					'KB',
					'MB',
					'GB',
					'TB',
					'PB',
					'EB',
					'ZB',
					'YB'
				);

				while (($size / 1024) > 1) {
					$size = $size / 1024;
					$i++;
				}

				$data['downloads'][] = array(
					'order_id'   => $result['order_id'],
					'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'name'       => $result['name'],
					'size'       => round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i],
					'href'       => $this->url->link('account/download/download', 'download_id=' . $result['download_id'], 'SSL')
				);
			}
		}

		$pagination = new Pagination();
		$pagination->total = $download_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_product_limit');
		$pagination->url = $this->url->link('account/download', 'page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($download_total) ? (($page - 1) * $this->config->get('config_product_limit')) + 1 : 0, ((($page - 1) * $this->config->get('config_product_limit')) > ($download_total - $this->config->get('config_product_limit'))) ? $download_total : ((($page - 1) * $this->config->get('config_product_limit')) + $this->config->get('config_product_limit')), $download_total, ceil($download_total / $this->config->get('config_product_limit')));

		$data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		$data['account_sidebar'] = $this->load->controller('account/account_sidebar');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/download.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/download.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/download.tpl', $data));
		}
	}

	public function download() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/download', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->model('account/download');

		if (isset($this->request->get['download_id'])) {
			$download_id = $this->request->get['download_id'];
		} else {
			$download_id = 0;
		}

		$download_info = $this->model_account_download->getDownload($download_id);

		if ($download_info) {
			$file = DIR_DOWNLOAD . $download_info['filename'];
			$mask = basename($download_info['mask']);

			if (!headers_sent()) {
				if (file_exists($file)) {
					header('Content-Type: application/octet-stream');
					header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));

					if (ob_get_level()) {
						ob_end_clean();
					}

					readfile($file, 'rb');

					exit();
				} else {
					exit('Error: Could not find file ' . $file . '!');
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			$this->response->redirect($this->url->link('account/download', '', 'SSL'));
		}
	}
}