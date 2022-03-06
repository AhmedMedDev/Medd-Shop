<?php
class ControllerAPIAccountDownload extends Controller {
	public function index() {
		$this->load->controller('api/common/header');
		
		$this->load->language('account/download');

		$this->document->setTitle($this->language->get('heading_title'));
		$customerDetails = $this->model_account_api->getApiCustomerDetails($this->request->post['token']);
		$currentCustomerId = $customerDetails['customer_id'];
		$this->load->model('account/download');

		

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
					'download_id'       => $result['download_id'],
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
		$data['status'] = 1;
		$this->response->setOutput(json_encode($data));
	}

	public function download() {
		$this->load->controller('api/common/header');
		
		$this->load->model('account/download');
		
		
		
		if (isset($this->request->get['download_id'])) {
			$download_id = $this->request->get['download_id'];
		} else {
			$download_id = 0;
		}
		
		$download_info = $this->model_account_download->getDownload($download_id);
		/* print_r($download_info);
		echo DIR_DOWNLOAD; */
		if ($download_info) {
			$file = DIR_DOWNLOAD . $download_info['filename'];
			$mask = basename($download_info['mask']);
			
			if (file_exists($file)) {
				$data['status'] = 1;
				
			} else {
				$data['status'] = 0;
				$data['error'] = 'Error: Could not find file ' . $file . '!';
			}
			
			if (!headers_sent()) {
				
				if (file_exists($file)) {
					$filename = ($mask ? $mask : basename($file));
					
					copy($file, DIR_DOWNLOAD.'api/'.$filename.'');
					
					$data['file'] = HTTP_DIR_DOWNLOAD.'api/'.$filename;
					/* header('Content-Type: application/octet-stream');
					
					header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
					
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));

					if (ob_get_level()) {
						ob_end_clean();
					}
					
					readfile($file, 'rb');
					
					exit(); */
				} else {
					exit('Error: Could not find file ' . $file . '!');
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			$data['status'] = 0;
			$data['error'] = 'Do not found download item related this id.';
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data));
	}
}