<?php
class ControllerAPIAccountAddress extends Controller {
	private $error = array();

	public function index() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('api/account/message');
		$this->load->model('api/account/address');

		$this->getList($customerId);
	}

	public function add() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('api/account/address');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_api_account_address->addAddress($customerId, $this->request->post);
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('address_add', $activity_data);

			$data['text_add'] = $this->language->get('text_add');
			$data['status'] = 1;
			$this->response->setOutput(json_encode($data));
			
		
		}else{
			$data['text_add'] = $this->error;
			$data['status'] = 0;
			$this->response->setOutput(json_encode($data));
		}
		//$this->getForm();
	}

	public function edit() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		$this->load->language('account/address');

		$this->load->model('api/account/address');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_api_account_address->editAddress($customerId, $this->request->get['address_id'], $this->request->post);



			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('address_edit', $activity_data);

			$data['text_edit'] = $this->language->get('text_edit');
			$data['status'] = 1;
			$this->response->setOutput(json_encode($data));
		}

		
	}

	public function delete() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);

		$this->load->language('account/address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('api/account/address');
	
		if (isset($this->request->get['address_id']) && $this->validateDelete()) {
			$this->model_api_account_address->deleteAddress($customerId, $this->request->get['address_id']);

			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);

			$this->model_account_activity->addActivity('address_delete', $activity_data);

			
			$data['text_edit'] = $this->language->get('text_delete');
			$data['status'] = 1;
			$this->response->setOutput(json_encode($data));
			return;
		}
		
		$json['status'] = 0;
		$json['error'] = $this->error;
		$this->response->setOutput(json_encode($json));
	}

	protected function getList($customerId) {
		$this->load->model('account/wishlist');
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
		$data['compare_count'] = $this->customer->getCompareCount();
		$data['cart_count'] = $this->cart->hasProducts();
		$data['wishlist_count'] = $this->model_account_wishlist->getTotalWishlist();
		$data['addresses'] = array();
		
		$results = $this->model_api_account_address->getAddresses($customerId);
		$getDefaultAddressId = $this->model_api_account_address->getDefaultAddressId($customerId);
		$filter_data =array(
			'customer_id' => $customerId,
			'filter_sender' => 'user',
			'filter_status' => '0',
		);
		$messageCount = $this->model_api_account_message->getTotalUnreadMessages($filter_data);
		foreach ($results as $result) {
			if ($result['address_format']) {
				$format = $result['address_format'];
			} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}

			$find = array(
				'{firstname}',
				'{lastname}',
				'{company}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);

			$replace = array(
				'firstname' => $result['firstname'],
				'lastname'  => $result['lastname'],
				'company'   => $result['company'],
				'address_1' => $result['address_1'],
				'address_2' => $result['address_2'],
				'city'      => $result['city'],
				'postcode'  => $result['postcode'],
				'zone'      => $result['zone'],
				'zone_code' => $result['zone_code'],
				'country'   => $result['country']
			);
			
			$data['addresses'][] = array(
				'address_id' => $result['address_id'],
				'firstname' => $result['firstname'],
				'lastname' => $result['lastname'],
				'company' => $result['company'],
				'address_1' => $result['address_1'],
				'address_2' => $result['address_2'],
				'city' => $result['city'],
				'postcode' => $result['postcode'],
				'zone' => $result['zone'],
				'zone_id' => $result['zone_id'],
				'zone_code' => $result['zone_code'],
				'country' => $result['country'],
				'country_id' => $result['country_id'],
				'address'    => str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format)))),
				'update'     => $this->url->link('account/address/edit', 'address_id=' . $result['address_id'], 'SSL'),
				'delete'     => $this->url->link('account/address/delete', 'address_id=' . $result['address_id'], 'SSL')
			);
		}

		$data['add'] = $this->url->link('account/address/add', '', 'SSL');
		$data['back'] = $this->url->link('account/account', '', 'SSL');
		$data['default_address'] = $getDefaultAddressId;
		$data['unread_message'] = $messageCount;
		$data['status'] = 1;
		
		$this->response->setOutput(json_encode($data));
		$this->response->addHeader('Content-Type: application/json');
	}

	protected function validateForm() {
		if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
			$this->error['lastname'] = $this->language->get('error_lastname');
		}

		if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128)) {
			$this->error['address_1'] = $this->language->get('error_address_1');
		}

		if ((utf8_strlen(trim($this->request->post['city'])) < 2) || (utf8_strlen(trim($this->request->post['city'])) > 128)) {
			$this->error['city'] = $this->language->get('error_city');
		}

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

		if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
			$this->error['postcode'] = $this->language->get('error_postcode');
		}

		if ($this->request->post['country_id'] == '' || !is_numeric($this->request->post['country_id'])) {
			$this->error['country'] = $this->language->get('error_country');
		}

		if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '' || !is_numeric($this->request->post['zone_id'])) {
			$this->error['zone'] = $this->language->get('error_zone');
		}

		// Custom field validation
		$this->load->model('account/custom_field');

		$custom_fields = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));

		foreach ($custom_fields as $custom_field) {
			if (($custom_field['location'] == 'address') && $custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['custom_field_id']])) {
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if ($this->model_api_account_address->getTotalAddresses($customerId) == 1) {
			$this->error['warning'] = $this->language->get('error_delete');
		}

		if ($this->customer->getAddressId() == $this->request->get['address_id']) {
			$this->error['warning'] = $this->language->get('error_default');
		}

		return !$this->error;
	}
}
