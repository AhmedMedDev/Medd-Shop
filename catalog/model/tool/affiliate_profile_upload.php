<?php
class ModelToolAffiliateProfileUpload extends Model {
	public function addUpload($affiliate_id='', $filename) {
		if($affiliate_id==''){
			$affiliate_id = $this->affiliate->getId();
		}
		if($affiliate_id){
						
			$this->db->query("UPDATE `" . DB_PREFIX . "affiliate` SET `profile_image` = '" . $this->db->escape($filename) . "' WHERE `affiliate_id`='".$affiliate_id."'");

			// Add to activity log
			$this->load->model('affiliate/activity');

			$activity_data = array(
				'affiliate_id' 	=> $this->affiliate->getId(),
				'profile_image' => $this->db->escape($filename)
			);

			$this->model_affiliate_activity->addActivity('edit', $activity_data);
			
			return $this->getProfileImageById($affiliate_id);
		
		}
		return false;
	}

	public function getProfileImageById($affiliate_id='') {
		if($affiliate_id==''){
			$affiliate_id = $this->affiliate->getId();
		}
		$query = $this->db->query("SELECT `profile_image` FROM `" . DB_PREFIX . "affiliate` WHERE `affiliate_id`='".$affiliate_id."'");

		return $query->row;
	}
}