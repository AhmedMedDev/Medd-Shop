<?php
class ControllerCommonAPIHeader extends Controller {
	public function index() {
		$header = array();
		
		$this->load->model('account/api');
		$this->load->language('api/login');
		//echo $this->request->get['token'];
		/* echo $this->session->data['api_id'];
		
		echo '<pre>';print_r($this->session);echo '</pre>';
		echo $this->session->data['api_id']; */
		if(!empty($this->request->post['token'])){
			$apiLoggedIn = $this->model_account_api->verifyToken($this->request->post['token']);
			
			if(!$apiLoggedIn){
				$header['status'] = 0;
				$header['error'] = $this->language->get('invalid_token');
				echo json_encode($header);
				exit;
			}else{
				$header = true;
				//echo $header;
			}
		}else{
			$header['status'] = 0;
			$header['error'] = $this->language->get('invalid_token');
			echo json_encode($header);
			exit;
		}
	}
}
