<?php
class ControllerAPICheckoutDefaultAddress extends Controller {
	public function index() {
		$this->load->language('checkout/checkout');
		$this->load->model('account/address');
		$this->load->model('account/customer');
		
		$customerDetails = $this->model_account_customer->getCustomer($this->customer->getId());
		
		$address_id = $customerDetails['address_id'];
		$data['addresses'] = $this->model_account_address->getAddress($address_id);
	
		$this->load->model('account/custom_field');
		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields($this->config->get('config_customer_group_id'));
		$data['status'] = 1;
		$this->response->setOutput(json_encode($data));
	}

}