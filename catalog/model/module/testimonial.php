<?php

class ModelModuleTestimonial extends Model {

	public function getTestimonials() {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial WHERE status = '1'");



		return $query->rows;

	}

}