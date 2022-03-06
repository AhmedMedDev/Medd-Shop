<?php
class Customer {
	private $customer_id;
	private $firstname;
	private $lastname;
	private $customer_group_id;
	private $email;
	private $telephone;
	private $fax;
	private $newsletter;
	private $address_id;
	private $share_cart_show_friends;

	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		//echo $registry->post['key'];
		 
		if (isset($this->session->data['customer_id']) || isset($this->request->post['token'])) {
			if (isset($this->session->data['customer_id'])) {
				$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$this->session->data['customer_id'] . "' AND status = '1'");
			}
			if (isset($this->request->post['token'])) {
				$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->request->post['token'] . "' AND status = '1'");
			}
			if ($customer_query->num_rows) {
				$this->customer_id = $customer_query->row['customer_id'];
				$this->firstname = $customer_query->row['firstname'];
				$this->lastname = $customer_query->row['lastname'];
				$this->customer_group_id = $customer_query->row['customer_group_id'];
				$this->email = $customer_query->row['email'];
				$this->telephone = $customer_query->row['telephone'];
				$this->fax = $customer_query->row['fax'];
				$this->newsletter = $customer_query->row['newsletter'];
				$this->address_id = $customer_query->row['address_id'];
				
				$this->share_cart_show_friends = $customer_query->row['share_cart_show_friends'];

				$this->db->query("UPDATE " . DB_PREFIX . "customer SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customer_id = '" . (int)$this->customer_id . "'");

				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_ip WHERE customer_id = '" . (int)$this->session->data['customer_id'] . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");

				if (!$query->num_rows) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_ip SET customer_id = '" . (int)$this->session->data['customer_id'] . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', date_added = NOW()");
				}
			} else {
				$this->logout();
			}
		}
	}

	public function login($email, $password, $override = false) {
		if ($override) {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "' AND status = '1'");
		} else {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1' AND approved = '1'");
		}

		if ($customer_query->num_rows) {
			$this->session->data['customer_id'] = $customer_query->row['customer_id'];

			$this->customer_id = $customer_query->row['customer_id'];
			$this->firstname = $customer_query->row['firstname'];
			$this->lastname = $customer_query->row['lastname'];
			$this->customer_group_id = $customer_query->row['customer_group_id'];
			$this->email = $customer_query->row['email'];
			$this->profile_image = $customer_query->row['profile_image'];
			$this->telephone = $customer_query->row['telephone'];
			$this->fax = $customer_query->row['fax'];
			$this->newsletter = $customer_query->row['newsletter'];
			$this->address_id = $customer_query->row['address_id'];
			$this->share_cart_show_friends = $customer_query->row['share_cart_show_friends'];
			
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customer_id = '" . (int)$this->customer_id . "'");

			return true;
		} else {
			return false;
		}
	}
	
	public function loginWithToken($token, $override = false) {
		if ($override) {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "' AND status = '1'");
		} else {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND status = '1' AND approved = '1'");
		}

		if ($customer_query->num_rows) {
			$this->session->data['customer_id'] = $customer_query->row['customer_id'];

			$this->customer_id = $customer_query->row['customer_id'];
			$this->firstname = $customer_query->row['firstname'];
			$this->lastname = $customer_query->row['lastname'];
			$this->customer_group_id = $customer_query->row['customer_group_id'];
			$this->email = $customer_query->row['email'];
			$this->profile_image = $customer_query->row['profile_image'];
			$this->telephone = $customer_query->row['telephone'];
			$this->fax = $customer_query->row['fax'];
			$this->newsletter = $customer_query->row['newsletter'];
			$this->address_id = $customer_query->row['address_id'];

			$this->db->query("UPDATE " . DB_PREFIX . "customer SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customer_id = '" . (int)$this->customer_id . "'");

			return true;
		} else {
			return false;
		}
	}
	
	public function logout() {
		if(isset($this->session->data)){
			unset($this->session->data['customer_id']);
		}
		
		$this->customer_id = '';
		$this->firstname = '';
		$this->lastname = '';
		$this->customer_group_id = '';
		$this->email = '';
		$this->profile_image = '';
		$this->telephone = '';
		$this->fax = '';
		$this->newsletter = '';
		$this->address_id = '';
	}

	public function isLogged() {
		if(isset($this->request->post['token'])){
			return $this->getCustomerIdByToken($this->request->post['token']);
		}else{
			return $this->customer_id;
		}
	}

	public function getId() {
		
		if(isset($this->request->post['token'])){
			return $this->getCustomerIdByToken($this->request->post['token']);
		}else{
			return $this->customer_id;
		}
	}
	public function getToken() {
		
		return $this->getCustomerTokenById($this->getId());
	}
	public function getFirstName() {
		return $this->firstname;
	}

	public function getLastName() {
		return $this->lastname;
	}
	
	public function getShareCartShowFriendStatus() {
		return $this->share_cart_show_friends;
	}

	public function getGroupId() {
		return $this->customer_group_id;
	}

	public function getEmail() {
		if(isset($this->request->post['token'])){
			return $this->getCustomerEmailByToken($this->request->post['token']);
		}else{
			return $this->email;
		}
	}
	
	public function getProfileImage() {
		return $this->profile_image;
	}
	
	public function getTelephone() {
		return $this->telephone;
	}

	public function getFax() {
		return $this->fax;
	}

	public function getNewsletter() {
		return $this->newsletter;
	}

	public function getAddressId() {
		return $this->address_id;
	}

	public function getBalance() {
		$query = $this->db->query("SELECT SUM(amount) AS total FROM " . DB_PREFIX . "customer_transaction WHERE customer_id = '" . (int)$this->customer_id . "'");

		return $query->row['total'];
	}

	public function getRewardPoints() {
		$query = $this->db->query("SELECT SUM(points) AS total FROM " . DB_PREFIX . "customer_reward WHERE customer_id = '" . (int)$this->customer_id . "'");

		return $query->row['total'];
	}
	
	public function getCustomerIdByToken($token){
		$query = $this->db->query("SELECT `customer_id` FROM `" . DB_PREFIX . "customer` WHERE `token`='".$token."'");
		if(empty($query->row)){
			return false;
		}
		return $query->row['customer_id'];
	}
	
	public function getCustomerTokenById($user_id){
		$query = $this->db->query("SELECT `token` FROM `" . DB_PREFIX . "customer` WHERE `customer_id`='".$user_id."'");
		return $query->row['token'];
	}
	
	public function getCustomerEmailByToken($token){
		$query = $this->db->query("SELECT `email` FROM `" . DB_PREFIX . "customer` WHERE `token`='".$token."'");
		return $query->row['email'];
	}
	public function addSessionId($session_id){
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET session_id = '" . $session_id . "' WHERE customer_id = '" . (int)$this->customer_id . "'");
	}
	
	public function getSessionId(){
		
		$query = $this->db->query("SELECT `session_id` FROM `" . DB_PREFIX . "customer` WHERE `customer_id`='".(int)$this->customer_id."'");
		return $query->row['session_id'];
		//$this->db->query("SELECT " . DB_PREFIX . "customer SET session_id = '" . $session_id . "' WHERE customer_id = '" . (int)$this->customer_id . "'");
	}
	
	public function addSession($token_no,$data){
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "app_session` WHERE user_id = '" . (int)$this->customer_id . "'");
		
		if($query->num_rows){
			$this->db->query("UPDATE " . DB_PREFIX . "app_session SET user_id = '" . (int)$this->getId() . "', session_data = '".$data."' WHERE token = '" . $token_no . "'");
			
		}else{
			$this->db->query("INSERT INTO " . DB_PREFIX . "app_session SET token = '" . $token_no . "', user_id = '" . (int)$this->getId() . "', session_data = '".$data."', date = NOW()");
		}
	}
	
	public function getSessionData($token_no){
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "app_session` WHERE token = '" . $token_no . "'");
		return $query->row;
	}
	
	public function removeSession(){
		$token_no = $this->getCustomerTokenById($this->getId());
		$this->db->query("DELETE FROM " . DB_PREFIX . "app_session WHERE token = '" . $token_no . "'");
	}
	
	public function getCompareCount(){
		
		$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->getId()."'");
		
		return count($query->rows);
	}
}
