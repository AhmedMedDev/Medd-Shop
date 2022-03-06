<?php
class ModelSettingpushnotification extends Model {
    
    public function saveNotification($data){   
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "pushnotifications SET  title = '" . (string)$data['title'] . "', type = '" . $data['type'] . "' , content = '".(string)$data['message']."', launch_url = '".(string)$data['launch_url']."', icon = '".(string)$data['icon']."', date_added = '".$this->db->escape(date('Y-m-d'))."', time_added = '".$this->db->escape(time('H:i:s'))."'");
		return $notification_id = $this->db->getLastId();
    }
    
    public function add_notify_customer($data){    
         $this->db->query("INSERT INTO " . DB_PREFIX . "app_notified_users SET  notification_id = '" . (int)$data['notification_id'] . "', customer_id = '" . (int)$data['customer_id'] . "' , read_status = '".(int)$data['read_status']."', date_added = '".$this->db->escape(date('Y-m-d H:i:s'))."'");	
    }
    
    public function update_read_status($customer_id,$read_status){    
         $this->db->query("UPDATE " . DB_PREFIX . "app_notified_users SET read_status = '" . (int)$read_status . "' WHERE customer_id = '" . (int)$customer_id . "'");	
    }
    
    public function deleteNotification($notification_id){
        $this->db->query("DELETE FROM " . DB_PREFIX . "pushnotifications WHERE id = '" . (int)$notification_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "app_notified_users WHERE notification_id = '" . (int)$notification_id . "'");
    }
    
    public function getTotalNotifications($data=array()){
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "pushnotifications";

		$implode = array();

		if (!empty($data['filter_title'])) {
			$implode[] = "title LIKE '%" . $this->db->escape($data['filter_title']) . "%'";
		}

		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
    }
    
    public function getNotifications($data=array()){
        
        $sql = "SELECT * FROM " . DB_PREFIX . "pushnotifications p ";

		$implode = array();

		if (!empty($data['filter_title'])) {
			$implode[] = "p.title LIKE '%" . $this->db->escape($data['filter_title']) . "%'";
		}

		if (!empty($data['filter_date_added'])) {
            $date_added = date("Y-m-d", strtotime($this->db->escape($data['filter_date_added'])));
			$implode[] = "DATE(p.date_added) = '".$date_added."'";
		}

		if ($implode) {            
			//$sql .= " AND " . implode(" AND ", $implode);
			$sql .= " where " . implode(" AND ", $implode);
		}

		$sort_data = array(
			'title',
			'content',			
			'launch_url',
			'date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {

			$sql .= " ORDER BY p." . $data['sort'];
		} else {
			$sql .= " ORDER BY p.date_added";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
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
    }
    
    public function getTotalNotificationUsers($data){
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "app_notified_users where notification_id = ".$data['notification_id'];
		$query = $this->db->query($sql);
		return $query->row['total'];
    }
    
    public function getNotificationUsers($data){
    
        $sql = "SELECT an.*,p.title,CONCAT(c.firstname, ' ', c.lastname) AS customer_name FROM " . DB_PREFIX . "app_notified_users an ";
        
        $sql .= "LEFT JOIN " . DB_PREFIX . "pushnotifications p ON (an.notification_id = p.id) ";
        $sql .= "LEFT JOIN " . DB_PREFIX . "customer c ON (an.customer_id = c.customer_id) ";
        $sql .= "WHERE an.notification_id = ".$data['notification_id'];
        
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
    
    public function deleteNotificationUser($id){
        $this->db->query("DELETE FROM " . DB_PREFIX . "app_notified_users WHERE id = '" . (int)$id . "'");
    }
}