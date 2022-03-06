<?php
class ControllerAPILocalisationZone extends Model {
	public function index() {
		
		$this->load->model('localisation/zone');
		$country_id = $this->request->get['country_id'];
		if($country_id){
			$data['zones'] = $this->model_localisation_zone->getZonesByCountryId($country_id);
			$data['status'] = 1;
		}else{
			$data['message'] = 'Invalid Country Id';
			$data['status'] = 0;
		}
		$this->response->setOutput(json_encode($data));
	}
}