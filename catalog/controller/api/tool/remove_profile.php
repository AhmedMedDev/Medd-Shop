<?php
class ControllerAPIToolRemoveProfile extends Controller {
	public function index() {
		$this->load->controller('api/common/header');
		$this->load->language('tool/upload');
		$json = array();
		if ($this->request->post['action'] == 'remove') {
				
			$this->load->model('account/api');
			$this->load->model('tool/profile_upload');
			$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
			$result = $this->model_tool_profile_upload->removeProfileImageById($customerId,$newfilename);
			if($result == true){
				$json['message'] = $this->language->get('profile_removed');
				
				$json['status'] = 1;
			}else{
				$json['status'] = 0;
				$json['error'] = $this->language->get('error_removed');
			}
		} else {
			$json['status'] = 0;
			$json['error'] = $this->language->get('error_wrong');
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}