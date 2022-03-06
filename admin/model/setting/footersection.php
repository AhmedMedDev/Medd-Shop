<?php
class ModelSettingfootersection extends Model {
	public function addfootersection($data) {
	
		$this->db->query("INSERT INTO " . DB_PREFIX . "footersection SET  status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "'");

		$footer_id = $this->db->getLastId(); 
		
		foreach ($data['footersection_description'] as $language_id => $value) {
			
			$this->db->query("INSERT INTO " . DB_PREFIX . "footersection_description SET footer_id = '" . (int)$footer_id . "', language_id = '" . (int)$language_id . "', heading = '" . $this->db->escape($value['heading']) . "', content = '" . $this->db->escape($value['content']) . "', title = '" . $this->db->escape($value['title']) . "'");
		}

		$this->cache->delete('footersection');
	}
	
	public function editfootersection($footersection_id, $data) {		 
	
		$this->db->query("UPDATE " . DB_PREFIX . "footersection SET status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE id = '" . (int)$footersection_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "footersection_description WHERE footer_id = '" . (int)$footersection_id . "'");
		
		foreach ($data['footersection_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "footersection_description SET footer_id = '" . (int)$footersection_id . "', language_id = '" . (int)$language_id . "', heading = '" . $this->db->escape($value['heading']) . "', content = '" . $this->db->escape($value['content']) . "', title = '" . $this->db->escape($value['title']) . "'");
		}	
		
		$this->cache->delete('footersection');
	}
	
	public function deletefootersection($footersection_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "footersection WHERE id = '" . (int)$footersection_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "footersection_description WHERE footer_id = '" . (int)$footersection_id . "'");		
		$this->cache->delete('footersection');
	}	
	public function getfootersection($footersection_id) {
	
			$sql = "SELECT * FROM " . DB_PREFIX . "footersection where id='".$footersection_id."' ";
			$query = $this->db->query($sql);
			return $query->row;
		
	}
		

	
	public function getfootersections($data = array()) {
		if ($data) {
			
			$sql = "SELECT * FROM " . DB_PREFIX . "footersection i LEFT JOIN " . DB_PREFIX . "footersection_description id ON (i.id = id.footer_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";			
			
		
			$sort_data = array(
				'id.title',
				'i.sort_order'
			);		
		
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY i.sort_order";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'ASC')) {
				$sql .= " ASC";
			} else {
				$sql .= " DESC";
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
			
			$query = $this->db->query($sql);
			return $query->rows;
		} else {
			$footersection_data = $this->cache->get('footersection.' . (int)$this->config->get('config_language_id'));
		
			if (!$footersection_data) {
			
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "footersection i LEFT JOIN " . DB_PREFIX . "footersection_description id ON (i.id = id.footer_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");			

				$footersection_data = $query->rows;

			
				$this->cache->set('footersection.' . (int)$this->config->get('config_language_id'), $footersection_data);
			}	
	
			return $footersection_data;			
		}
	}
	
	public function getfootersectionDescriptions($footersection_id) {
		$footersection_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "footersection_description WHERE footer_id = '" . (int)$footersection_id . "'");

		foreach ($query->rows as $result) {
			$footersection_description_data[$result['language_id']] = array(
				'footersection_id'       => $result['footer_id'],
				'title'       => $result['title'],
				'heading'       => $result['heading'],
				'content'       => $result['content'],
				);
		}
		
		return $footersection_description_data;
	}
	
	
		
	public function getTotalfootersections() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "footersection");
		
		return $query->row['total'];
	}	
	
	
}
?>