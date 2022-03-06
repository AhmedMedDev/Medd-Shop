<?php
class ModelProductCompare extends Model {
	public function addCompareProduct($product_id){
		if($product_id){
			
			$this->db->query("INSERT INTO `" . DB_PREFIX . "compare_product` SET user_id = '".(int)$this->customer->getId()."', product_id = '".$product_id."',date = NOW()");
		}
	}
	
	public function addCompareProducts($product_ids){
		if($product_ids){
			for($i=0; $i<4;$i++){
				$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."' AND product_id = '".$product_ids[$i]."'");
				
				if($query->num_rows < 1 && $product_ids[$i] != 0){
					 	 
					$this->db->query("INSERT INTO `" . DB_PREFIX . "compare_product` SET user_id = '".(int)$this->customer->getId()."', product_id = '".$product_ids[$i]."',date = NOW()");
					 
				}
			}
		}
	}
	
	public function getCompareProducts($product_id=0){
		if($product_id>0){
			$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "compare_product` WHERE product_id = '".$product_id."' AND user_id = '".(int)$this->customer->getId()."'");
		}else{
			$query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."'");
		}
		return $query->rows;
	}
	
	public function deleteOldProducts(){
		$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."' ORDER BY date ASC LIMIT 1");
		return true;
	}
	public function deleteCompareProducts(){
		
		$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."'");
		return true;
	}
	
	public function removeProduct($product_id){
		if($product_id){
			$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."' AND product_id = '".$product_id."'");
			return true;
		}
	}
	
	public function removeProducts(){
		$this->db->query("DELETE FROM `" . DB_PREFIX . "compare_product` WHERE user_id = '".(int)$this->customer->getId()."'");
		return true;
		
	}
	
}