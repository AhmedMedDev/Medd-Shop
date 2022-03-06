<?php
class ControllerAPIToolProfileUpload extends Controller {
	public function index() {
		$this->load->controller('api/common/header');
		$this->load->language('tool/upload');
		$json = array();
		if (!empty($this->request->files['user_profile_image']['name']) && is_file($this->request->files['user_profile_image']['tmp_name'])) {
			// Sanitize the filename
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['user_profile_image']['name'], ENT_QUOTES, 'UTF-8')));

			// Validate the filename length
			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
				$json['error'] = $this->language->get('error_filename');
			}

			// Allowed file extension types
			$allowed = array();

			$filetypes = array('png','jpe','jpeg','jpg');

			foreach ($filetypes as $filetype) {
				$allowed[] = trim($filetype);
			}

			if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
				$json['error'] = $this->language->get('error_filetype');
			}

			// Allowed file mime types
			$allowed = array();
	
			$filetypes = array('image/png','image/jpeg');
			
			foreach ($filetypes as $filetype) {
				$allowed[] = trim($filetype);
			}

			if (!in_array($this->request->files['user_profile_image']['type'], $allowed)) {
				$json['error'] = $this->language->get('error_filetype');
			}

			// Check to see if any PHP files are trying to be uploaded
			$content = file_get_contents($this->request->files['user_profile_image']['tmp_name']);

			if (preg_match('/\<\?php/i', $content)) {
				$json['error'] = $this->language->get('error_filetype');
			}

			// Return any upload error
			if ($this->request->files['user_profile_image']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['user_profile_image']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
			$json['status'] = 0;
		}

		if (!$json) {
			
			$temp = explode(".", $filename);
			
			$newfilename = round(microtime(true)). rand(2,99) . '.' . end($temp);
			
			if (!is_dir(DIR_PROFILE_UPLOAD)) {
				@mkdir(DIR_PROFILE_UPLOAD, 0777);
			}
			
			move_uploaded_file($this->request->files['user_profile_image']['tmp_name'], DIR_PROFILE_UPLOAD . $newfilename);

			// Hide the uploaded file name so people can not link to it directly.
			$this->load->model('tool/profile_upload');
			$this->load->model('account/api');
			$customerId = $this->model_account_api->getCustomerIdByToken($this->request->post['token']);
			
			$result = $this->model_tool_profile_upload->addUpload($customerId,$newfilename);
			$json['profile'] = false;
			if($result!=false){
				$json['success'] = $this->language->get('text_upload');
				$json['status'] = 1;
				
				$this->load->model('tool/profile_upload');
				
				if(is_array($result) && count($result)>0){
					if (is_file(DIR_PROFILE_UPLOAD . $result['profile_image'])) { 
						$this->load->model('tool/image');
						
						$json['profile_image_1'] = $this->model_tool_image->resizeProfileImage($result['profile_image'], 500, 500);
						
						$json['profile_image_2'] =  HTTP_SERVER_IMAGE .'profile/'. $result['profile_image'];
						
						$json['profile'] = true;
					}
				}
			}
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}