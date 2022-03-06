<?php
class ControllerCatalogProductQuote extends Controller {
	private $error = array();

	public function index() {
		$this->language->load('catalog/product_quote');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_quote');

		$this->getList();
	}

	public function add() {
		$this->language->load('catalog/product_quote');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_quote');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			
			$this->model_catalog_product_quote->addProductQuoteRequest($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() { 
		$this->language->load('catalog/product_quote');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_quote');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) { 
			$this->model_catalog_product_quote->editProductQuoteRequest($this->request->get['id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->response->redirect($this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		} 
		
		$this->getForm();
	}

	public function delete() {
		$this->language->load('catalog/product_quote');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_quote');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $id) {
				$this->model_catalog_product_quote->deleteProductQuoteRequest($id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->response->redirect($this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	} 

	protected function getList() {
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'id';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('catalog/product_quote/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data['delete'] = $this->url->link('catalog/product_quote/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['product_quote_info'] = array();
		
		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start'           => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'           => $this->config->get('config_limit_admin')
		);
		
		$product_quote_info_total = $this->model_catalog_product_quote->getTotalProductQuoteRequests($filter_data);

		$results = $this->model_catalog_product_quote->getProductQuoteRequests($filter_data);

		foreach ($results as $result) {
			$referrer = json_decode($result['referrer'], true);
			$html_content = '';
			foreach($referrer AS $rfrkey=>$rfrval){
					if($rfrkey=='ip' || $rfrkey=='user_ip' || $rfrkey=='client_ip'){
						$html_content .= '<a href="http://www.ip2location.com/'.$rfrval.'" target="_blank">'.$rfrval.'</a><br/>';
						continue;
					}
					$html_content .=ucfirst(str_replace("_", " ", $rfrkey)).': '.$rfrval.'<br/>';
			}
			
			$data['product_quote_info'][] = array(
				'id' 			=> $result['id'],
				'name'        	=> $result['name'],
				'email'        	=> $result['email'],
				'phone'        	=> $result['phone'],
				'comment'      	=> $result['comment'],
				'referrer'      => $html_content,
				'type'      	=> $result['type'],
				'remarks'      	=> $result['remarks'],
				'added'        	=> date($this->language->get('date_format_short'), strtotime($result['added'])),
				'modified'      => date($this->language->get('date_format_short'), strtotime($result['modified'])),
				'status'        => $result['status'],
				'edit'        	=> $this->url->link('catalog/product_quote/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id'] . $url, 'SSL'),
				'delete'      => $this->url->link('catalog/product_quote/delete', 'token=' . $this->session->data['token'] . '&id=' . $result['id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] 		= $this->language->get('column_name');
		$data['column_email']      	= $this->language->get('column_email');
		$data['column_phone'] 		= $this->language->get('column_phone');
		$data['column_comments'] 	= $this->language->get('column_comments');
		$data['column_referrer'] 	= $this->language->get('column_referrer');
		$data['column_remarks']     = $this->language->get('column_remarks');
		$data['column_type']     	= $this->language->get('column_type');
		$data['column_added']     	= $this->language->get('column_added');
		$data['column_modified']    = $this->language->get('column_modified');
		$data['column_sort_order']  = $this->language->get('column_sort_order');
		$data['column_action'] 		= $this->language->get('column_action');
		
		
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_rebuild'] = $this->language->get('button_rebuild');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		$data['sort_name'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_type'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . '&sort=type' . $url, 'SSL');
		$data['sort_added'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . '&sort=added' . $url, 'SSL');
		$data['sort_modified'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . '&sort=modified' . $url, 'SSL');
		$data['sort_sort_order'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		$pagination = new Pagination();
		$pagination->total = $product_quote_info_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($product_quote_info_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($product_quote_info_total - $this->config->get('config_limit_admin'))) ? $product_quote_info_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $product_quote_info_total, ceil($product_quote_info_total / $this->config->get('config_limit_admin')));
		
		$data['sort'] = $sort;
		$data['order'] = $order;
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/product_quote_list.tpl', $data));
	}

	protected function getForm() { 
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name']            	= $this->language->get('entry_name');
		$data['entry_email']      		= $this->language->get('entry_email');
		$data['entry_phone'] 			= $this->language->get('entry_phone');
		$data['entry_comments'] 	 	= $this->language->get('entry_comments');
		$data['entry_referrer'] 		= $this->language->get('entry_referrer');
		$data['entry_status']           = $this->language->get('entry_status');
		$data['entry_remarks']          = $this->language->get('entry_remarks');

		$data['column_added']           = $this->language->get('column_added');
		$data['column_modified']   		= $this->language->get('column_modified');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

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

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['id'])) {
			$data['action'] = $this->url->link('catalog/product_quote/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('catalog/product_quote/edit', 'token=' . $this->session->data['token'] . '&id=' . $this->request->get['id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('catalog/product_quote', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$product_quote_info = $this->model_catalog_product_quote->getProductQuoteRequest($this->request->get['id']);
			$data['product_quote_info'] = $product_quote_info;
		}else{
			$data['product_quote_info'] = array();
			$temp = array();
			if (isset($this->request->post['name'])) {
				$temp['name'] = $this->request->post['name'];
			}
			if (isset($this->request->post['email'])) {
				$temp['email'] = $this->request->post['email'];
			}
			if (isset($this->request->post['phone'])) {
				$temp['phone'] = $this->request->post['phone'];
			}
			if (isset($this->request->post['comments'])) {
				$temp['comments'] = $this->request->post['comments'];
			}
			if (isset($this->request->post['remarks'])) {
				$temp['remarks'] = $this->request->post['remarks'];
			}
			if(!empty($temp)) $data['product_quote_info']= $temp;
		}
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['path'])) {
			$data['path'] = $this->request->post['path'];
		} elseif (!empty($product_quote_info)) {
			$data['path'] = $product_quote_info['path'];
		} else {
			$data['path'] = '';
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($product_quote_info)) {
			$data['status'] = $product_quote_info['status'];
		} else {
			$data['status'] = true;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/product_quote_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/product_quote')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		$value = $this->request->post;
	
		if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 50)) { 
			$this->error['name'] = $this->language->get('error_name');
		}
		if ((utf8_strlen($value['email']) < 7) || (utf8_strlen($value['email']) > 50)) {
			$this->error['email'] = $this->language->get('error_email');
		}else if (!preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}
		
		if ((utf8_strlen($value['phone']) < 10) || (utf8_strlen($value['phone']) > 14)) {
			$this->error['phone'] = $this->language->get('error_phone');
		}


		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/product_quote')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	} 
}