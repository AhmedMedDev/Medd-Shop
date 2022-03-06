<?php
class ModelCommonNewsletter extends Model {
	
	public function createNewsletter()
	{
			
		$res0 = $this->db->query("SHOW TABLES LIKE '". DB_PREFIX ."newsletter'");
		if($res0->num_rows == 0){
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `".DB_PREFIX."newsletter` (
				  `news_id` int(11) NOT NULL AUTO_INCREMENT,
				  `news_email` varchar(255) NOT NULL,
				  PRIMARY KEY (`news_id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
		
		
	}
	
	public function getNewsLetter($data) {
		$sql = "SELECT n.*, cu.customer_id, concat(cu.firstname,' ', cu.lastname) as customer_name FROM ". DB_PREFIX ."newsletter n LEFT JOIN " . DB_PREFIX . "customer cu ON (n.email = cu.email) order by n.date_added"; 
		
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
	}
	
	public function getTotalSubscribers() {
		$sql = "SELECT count(*) as total_subscriber FROM ". DB_PREFIX ."newsletter n";
		$query = $this->db->query($sql);
		return $query->row['total_subscriber'];
	}
    
    public function deleteSubscriber($id) {        
        $this->db->query("DELETE FROM " . DB_PREFIX . "newsletter WHERE id = " . (int)$id);
    }
}