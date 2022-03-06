<?php
class Extendeddb extends DB {

	public function __construct($driver, $hostname, $username, $password, $database, $port = NULL) {
		$parent::__construct();
		$this->db->query("SET time_zone='+00:00';");
		echo 'here';
		exit;
	}

}
?>