<?php
class ControllerCommonUser extends Controller {

	public function online_user(){
		$this->load->model('checkout/user');
		$this->model_localisation_zone->save($customer_id);
	}	
	
}