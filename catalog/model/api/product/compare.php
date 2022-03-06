<?php	
	class ModelAPIProductCompare extends Model {		
		public function addCompareProduct($product_id){			
			if($product_id){				 
				$this->db->query("INSERT INTO `" . DB_PREFIX . "compare_product` SET user_id = '".(int)$this->customer->getId()."', product_id = '".$product_id."',date = NOW()");				
			}			
		}		 
		public function getCompareProducts(){			
			$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."'");			
			return $query->rows;			
		}		 
		public function deleteOldProducts($product_id){			
			$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."' AND product_id = '".(int)$product_id."' ORDER BY date ASC LIMIT 1");			
			return true;			
		}		
		public function deleteCompareProducts(){			
			$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."'");			
			return true;			
		}		 
		public function removeProduct($product_id){			
			if($product_id){				
				$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."' product_id = '".$product_id."'");				
				return true;				
			}			
		}		
	}	