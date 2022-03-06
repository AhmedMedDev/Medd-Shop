<?php
class ModelCatalogProductQuote extends Model {
	public function addProductQuoteRequest($data) {
		$referrer = json_encode($data['referrer']);
		$remarks  = (isset($data['remarks']) ? $data['remarks'] : '');
		$this->db->query("INSERT INTO " . DB_PREFIX . "request_product_quote SET `name` = '" .  $this->db->escape($data['name']) . "', `email` = '" .  $this->db->escape($data['email']) . "', `phone` = '" .  $this->db->escape($data['phone']) . "', `comments` = '" .  $this->db->escape($data['comments']) . "', `referrer` = '" . $this->db->escape($referrer). "', `remarks` = '" . $this->db->escape($remarks) . "', `type` = '" . (int)$data['type'] . "' , added = NOW(), modified = NOW()");

		$request_id = $this->db->getLastId();

		return $request_id;
	}

	public function editProductQuoteRequest($id, $data) {
		$remarks  = (isset($data['remarks']) ? $data['remarks'] : '');
		
		$this->db->query("UPDATE " . DB_PREFIX . "request_product_quote SET `name` = '" .  $this->db->escape($data['name']) . "', `email` = '" .  $this->db->escape($data['email']) . "', `phone` = '" .  $this->db->escape($data['phone']) . "', `comments` = '" .  $this->db->escape($data['comments']) . "', `remarks` = '" . $this->db->escape($remarks) . "', modified = NOW() WHERE `id`='".(int)$id."'");
		
		return true;
	}

	public function deleteProductQuoteRequest($id) {
		$this->db->query("UPDATE " . DB_PREFIX . "request_product_quote SET `status`=0 WHERE id = '" . (int)$id . "'");
	}

	public function getProductQuoteRequest($id) {
		$query = $this->db->query("SELECT rpq.* FROM " . DB_PREFIX . "request_product_quote rpq  WHERE rpq.id = '" . (int)$id . "' AND rpq.status=1" );

		return $query->row;
	}

	public function getProductQuoteRequests($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "request_product_quote WHERE status=1";
		if(!empty($data)){
			if(isset($data['sort']) && isset($data['order'])){
				$sql .= " ORDER BY ".$data['sort']." ".$data['order'];
			}
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}

				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
		}		
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getTotalProductQuoteRequests() {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "request_product_quote  WHERE status=1";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}
}