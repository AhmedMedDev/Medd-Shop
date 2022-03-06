<?php
class ControllerAPILocalisationCountry extends Model {
	public function index() {
		$this->load->model('localisation/country');
		
		$data['countries'] = $this->model_localisation_country->getCountries();
		$data['status'] = 1;
		
		$this->response->setOutput(json_encode($data));
	}
}