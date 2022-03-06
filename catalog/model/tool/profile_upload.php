<?php
class ModelToolProfileUpload extends Model {
	public function addUpload($customer_id='', $filename) {
		if($customer_id==''){
			$customer_id = $this->customer->getId();
		}
		if($customer_id){
						
			$this->db->query("UPDATE `" . DB_PREFIX . "customer` SET `profile_image` = '" . $this->db->escape($filename) . "' WHERE `customer_id`='".$customer_id."'");

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' 	=> $this->customer->getId(),
				'name'        	=> $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
				'profile_image' => $this->db->escape($filename)
			);

			$this->model_account_activity->addActivity('edit', $activity_data);
			
			return $this->getProfileImageById($customer_id);
		
		}
		return false;
	}

	public function getProfileImageById($customer_id='') {
		if($customer_id==''){
			$customer_id = $this->customer->getId();
		}
		$query = $this->db->query("SELECT `profile_image` FROM `" . DB_PREFIX . "customer` WHERE `customer_id`='".$customer_id."'");

		return $query->row;
	}
}