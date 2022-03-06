<?php
class ControllerAPIAccountNewsletter extends Controller {
	public function index() {
		$this->load->controller('api/common/header');
		$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
		$this->load->language('account/newsletter');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('api/account/customer');

			$this->model_api_account_customer->editNewsletter($customerId, $this->request->post['newsletter']);
			
			$customerDetails = $this->model_api_account_customer->getCustomer($customerId);
			//print_r($customerDetails['newsletter']);
			$data['status'] = 1;
			if($customerDetails['newsletter']){
				$data['success'] = $this->language->get('text_activated');
			}else{
				$data['success'] = $this->language->get('text_deactivated');
			}
			
		}else{
			$data['status'] = 0;
		}
		$this->response->setOutput(json_encode($data));
	}
}