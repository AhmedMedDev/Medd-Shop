<?php
class ControllerAPICommonHeader extends Controller {
	public function index() {
		$header = array();
		
		$this->load->model('account/api');
		$this->load->language('api/login');
		 
		if(!empty($this->request->post['token'])){
			$apiLoggedIn = $this->model_account_api->verifyToken($this->request->post['token']);
			
			if(!$apiLoggedIn){
				$header['status'] = 2;
				$header['error'] = $this->language->get('LOGGED_OUT');
				echo json_encode($header);
				exit;
			}else{
				$header = true;
			}
		}else{
			$header['status'] = 2;
			$header['error'] = $this->language->get('invalid_token');
			echo json_encode($header);
			exit;
		}
	}
	
}