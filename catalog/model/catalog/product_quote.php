<?php
class ModelCatalogProductQuote extends Model {
	public function addProductQuoteRequest($data) {
		$referrer = json_encode($data['referrer']);
		$remarks  = (isset($data['remarks']) ? $data['remarks'] : '');
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "request_product_quote SET `name` = '" .  $this->db->escape($data['name']) . "', `email` = '" .  $this->db->escape($data['email']) . "', `phone` = '" .  $this->db->escape($data['phone']) . "', `comments` = '" .  $this->db->escape($data['comments']) . "', `referrer` = '" . $this->db->escape($referrer). "', `remarks` = '" . $this->db->escape($remarks) . "', `type` = '".$this->db->escape($data['type'])."', added = NOW(), modified = NOW()");

		$request_id = $this->db->getLastId();

		return $request_id;
	}
}