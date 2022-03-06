<?php
class Cart {
	private $data = array();

	public function __construct($registry) {

		$this->config = $registry->get('config');
		$this->customer = $registry->get('customer');
		$this->session = $registry->get('session');
		$this->db = $registry->get('db');
		$this->tax = $registry->get('tax');
		$this->weight = $registry->get('weight');

		// Remove all the expired carts with no customer ID
		$multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = 0 AND " . DB_PREFIX . "multi_cart.mc_datetime < DATE_SUB(NOW(), INTERVAL 1 HOUR)");

		foreach ($multi_cart_query->rows as $multi_cart_rows) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart WHERE mc_cart_id = '" . (int)$multi_cart_rows['mcu_cart_id'] . "'");
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_users WHERE mcu_cart_id = '" . (int)$multi_cart_rows['mcu_cart_id'] . "'");
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_products WHERE cart_id = '" . (int)$multi_cart_rows['mcu_cart_id'] . "'");
		}

		if ($this->customer->getId()) {
		
			// We want to change the session ID on all the old items in the customers cart
			$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' WHERE mcu_user_id = '" . (int)$this->customer->getId() . "'");

			// Once the customer is logged in we want to update the customer ID on all items he has
			$cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products  ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id   WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = 0 AND " . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "'");

			foreach ($cart_query->rows as $cart) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart WHERE mc_cart_id = '" . (int)$cart['mcu_cart_id'] . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_users WHERE mcu_cart_id = '" . (int)$cart['mcu_cart_id'] . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_products WHERE cart_id = '" . (int)$cart['mcu_cart_id'] . "'");

				// The advantage of using $this->add is that it will check if the products already exist and increaser the quantity if necessary.
				$this->add($cart['product_id'], $cart['quantity'], json_decode($cart['option']), $cart['recurring_id']);
			}
//                        $cart_id = $this->getActiveCartId();
//                        if($cart_id == 0){                           
//                            $cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '".(int)$this->customer->getId()."'");
//                            if(isset($cart_query->row['mc_cart_id'])){
//                                $user_first_cart_id = $cart_query->row['mc_cart_id'];
//                                $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 1," . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' WHERE mcu_user_id = '".(int)$this->customer->getId()."' AND mcu_cart_id = '" . (int)$user_first_cart_id . "'");                                
//                            }
//                        }                        
		}
	}

	public function getProducts() {
		$product_data = array();
               
                $active_cart_id = $this->getActiveCartId();
		
		if( ((int)$this->customer->getId()) > 0 ){
			$cart_query = $this->db->query("SELECT " . DB_PREFIX . "multi_cart.*," . DB_PREFIX . "multi_cart_users.*," . DB_PREFIX . "multi_cart_products.*,firstname FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products  ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "customer ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart_products.added_by   WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_is_active=1 AND " . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' AND " . DB_PREFIX . "multi_cart.mc_cart_id='".(int)$active_cart_id."'");
		}else{
			$cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products  ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id   WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_is_active=1 AND " . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "'");				
		}
	 
		foreach ($cart_query->rows as $cart) {
			$stock = true;

			$product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store p2s LEFT JOIN " . DB_PREFIX . "product p ON (p2s.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p2s.product_id = '" . (int)$cart['product_id'] . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");
			
			if ($product_query->num_rows && ($cart['quantity'] > 0)) {
				$option_price = 0;
				$option_points = 0;
				$option_weight = 0;

				$option_data = array();

				foreach (json_decode($cart['option']) as $product_option_id => $value) {
					$option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$cart['product_id'] . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

					if ($option_query->num_rows) {
						if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
							$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

							if ($option_value_query->num_rows) {
								if ($option_value_query->row['price_prefix'] == '+') {
									$option_price += $option_value_query->row['price'];
								} elseif ($option_value_query->row['price_prefix'] == '-') {
									$option_price -= $option_value_query->row['price'];
								}

								if ($option_value_query->row['points_prefix'] == '+') {
									$option_points += $option_value_query->row['points'];
								} elseif ($option_value_query->row['points_prefix'] == '-') {
									$option_points -= $option_value_query->row['points'];
								}

								if ($option_value_query->row['weight_prefix'] == '+') {
									$option_weight += $option_value_query->row['weight'];
								} elseif ($option_value_query->row['weight_prefix'] == '-') {
									$option_weight -= $option_value_query->row['weight'];
								}

								if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $cart['quantity']))) {
									$stock = false;
								}

								$option_data[] = array(
									'product_option_id'       => $product_option_id,
									'product_option_value_id' => $value,
									'option_id'               => $option_query->row['option_id'],
									'option_value_id'         => $option_value_query->row['option_value_id'],
									'name'                    => $option_query->row['name'],
									'value'                   => $option_value_query->row['name'],
									'type'                    => $option_query->row['type'],
									'quantity'                => $option_value_query->row['quantity'],
									'subtract'                => $option_value_query->row['subtract'],
									'price'                   => $option_value_query->row['price'],
									'price_prefix'            => $option_value_query->row['price_prefix'],
									'points'                  => $option_value_query->row['points'],
									'points_prefix'           => $option_value_query->row['points_prefix'],
									'weight'                  => $option_value_query->row['weight'],
									'weight_prefix'           => $option_value_query->row['weight_prefix']
								);
							}
						} elseif ($option_query->row['type'] == 'checkbox' && is_array($value)) {
							foreach ($value as $product_option_value_id) {
								$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

								if ($option_value_query->num_rows) {
									if ($option_value_query->row['price_prefix'] == '+') {
										$option_price += $option_value_query->row['price'];
									} elseif ($option_value_query->row['price_prefix'] == '-') {
										$option_price -= $option_value_query->row['price'];
									}

									if ($option_value_query->row['points_prefix'] == '+') {
										$option_points += $option_value_query->row['points'];
									} elseif ($option_value_query->row['points_prefix'] == '-') {
										$option_points -= $option_value_query->row['points'];
									}

									if ($option_value_query->row['weight_prefix'] == '+') {
										$option_weight += $option_value_query->row['weight'];
									} elseif ($option_value_query->row['weight_prefix'] == '-') {
										$option_weight -= $option_value_query->row['weight'];
									}

									if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $cart['quantity']))) {
										$stock = false;
									}

									$option_data[] = array(
										'product_option_id'       => $product_option_id,
										'product_option_value_id' => $product_option_value_id,
										'option_id'               => $option_query->row['option_id'],
										'option_value_id'         => $option_value_query->row['option_value_id'],
										'name'                    => $option_query->row['name'],
										'value'                   => $option_value_query->row['name'],
										'type'                    => $option_query->row['type'],
										'quantity'                => $option_value_query->row['quantity'],
										'subtract'                => $option_value_query->row['subtract'],
										'price'                   => $option_value_query->row['price'],
										'price_prefix'            => $option_value_query->row['price_prefix'],
										'points'                  => $option_value_query->row['points'],
										'points_prefix'           => $option_value_query->row['points_prefix'],
										'weight'                  => $option_value_query->row['weight'],
										'weight_prefix'           => $option_value_query->row['weight_prefix']
									);
								}
							}
						} elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
							$option_data[] = array(
								'product_option_id'       => $product_option_id,
								'product_option_value_id' => '',
								'option_id'               => $option_query->row['option_id'],
								'option_value_id'         => '',
								'name'                    => $option_query->row['name'],
								'value'                   => $value,
								'type'                    => $option_query->row['type'],
								'quantity'                => '',
								'subtract'                => '',
								'price'                   => '',
								'price_prefix'            => '',
								'points'                  => '',
								'points_prefix'           => '',
								'weight'                  => '',
								'weight_prefix'           => ''
							);
						}
					}
				}

				$price = $product_query->row['price'];

				// Product Discounts
				$discount_quantity = 0;

				$cart_2_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products  ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id   WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_is_active=1 AND " . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "'");					
				

				foreach ($cart_2_query->rows as $cart_2) {
					if ($cart_2['product_id'] == $cart['product_id']) {
						$discount_quantity += $cart_2['quantity'];
					}
				}

				$product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$cart['product_id'] . "' AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

				if ($product_discount_query->num_rows) {
					$price = $product_discount_query->row['price'];
				}

				// Product Specials
				$product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$cart['product_id'] . "' AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

				if ($product_special_query->num_rows) {
					$price = $product_special_query->row['price'];
				}

				// Reward Points
				$product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$cart['product_id'] . "' AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'");

				if ($product_reward_query->num_rows) {
					$reward = $product_reward_query->row['points'];
				} else {
					$reward = 0;
				}

				// Downloads
				$download_data = array();

				$download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$cart['product_id'] . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

				foreach ($download_query->rows as $download) {
					$download_data[] = array(
						'download_id' => $download['download_id'],
						'name'        => $download['name'],
						'filename'    => $download['filename'],
						'mask'        => $download['mask']
					);
				}

				// Stock
				if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $cart['quantity'])) {
					$stock = false;
				}

				$recurring_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "recurring r LEFT JOIN " . DB_PREFIX . "product_recurring pr ON (r.recurring_id = pr.recurring_id) LEFT JOIN " . DB_PREFIX . "recurring_description rd ON (r.recurring_id = rd.recurring_id) WHERE r.recurring_id = '" . (int)$cart['recurring_id'] . "' AND pr.product_id = '" . (int)$cart['product_id'] . "' AND rd.language_id = " . (int)$this->config->get('config_language_id') . " AND r.status = 1 AND pr.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'");

				if ($recurring_query->num_rows) {
					$recurring = array(
						'recurring_id'    => $cart['recurring_id'],
						'name'            => $recurring_query->row['name'],
						'frequency'       => $recurring_query->row['frequency'],
						'price'           => $recurring_query->row['price'],
						'cycle'           => $recurring_query->row['cycle'],
						'duration'        => $recurring_query->row['duration'],
						'trial'           => $recurring_query->row['trial_status'],
						'trial_frequency' => $recurring_query->row['trial_frequency'],
						'trial_price'     => $recurring_query->row['trial_price'],
						'trial_cycle'     => $recurring_query->row['trial_cycle'],
						'trial_duration'  => $recurring_query->row['trial_duration']
					);
				} else {
					$recurring = false;
				}
				
				$firstname = '';
				$logged_user_id = (int)$this->customer->getId();
				if( ($logged_user_id) > 0 ){
					if($logged_user_id==$cart['added_by']){
						$firstname =  'You';
					}else{
						$firstname = $cart['firstname'];
					}
				}

				$product_data[] = array(
					'cart_id'         => $cart['cart_id'],
					'firstname'       => $firstname,
					'added_by'        => $cart['added_by'],
					'mcp_id'          => $cart['mcp_id'],
					'product_id'      => $product_query->row['product_id'],
					'name'            => $product_query->row['name'],
					'model'           => $product_query->row['model'],
					'shipping'        => $product_query->row['shipping'],
					'image'           => $product_query->row['image'],
					'option'          => $option_data,
					'download'        => $download_data,
					'quantity'        => $cart['quantity'],
					'minimum'         => $product_query->row['minimum'],
					'subtract'        => $product_query->row['subtract'],
					'stock'           => $stock,
					'price'           => ($price + $option_price),
					'total'           => ($price + $option_price) * $cart['quantity'],
					'reward'          => $reward * $cart['quantity'],
					'points'          => ($product_query->row['points'] ? ($product_query->row['points'] + $option_points) * $cart['quantity'] : 0),
					'tax_class_id'    => $product_query->row['tax_class_id'],
					'weight'          => ($product_query->row['weight'] + $option_weight) * $cart['quantity'],
					'weight_class_id' => $product_query->row['weight_class_id'],
					'length'          => $product_query->row['length'],
					'width'           => $product_query->row['width'],
					'height'          => $product_query->row['height'],
					'length_class_id' => $product_query->row['length_class_id'],
					'recurring'       => $recurring
				);
			} else {
				$this->remove($cart['mcp_id']);
			}
		}
		
		return $product_data;
	}

	public function add($product_id, $quantity = 1, $option = array(), $recurring_id = 0) {
		
		$query = $this->db->query("SELECT cart_id,COUNT(*) AS total FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products  ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' AND mcu_is_active=1 AND product_id = '" . (int)$product_id . "' AND recurring_id = '" . (int)$recurring_id . "' AND `option` = '" . $this->db->escape(json_encode($option)) . "'");
		 
		if (!$query->row['total']) {
		
			$query = $this->db->query("SELECT mc_cart_id,COUNT(*) AS total FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id  WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' AND mcu_is_active=1 ");		
			
			if (!$query->row['total']) {
			
				$this->db->query("INSERT " . DB_PREFIX . "multi_cart (`mc_cart_id`, `mc_name`, `mc_description`, `mc_datetime`, `mc_current_stage`) VALUES (NULL, '', '', NOW(), '0')");
				
				$new_cart_id = $this->db->getLastId();				
				
				$this->db->query("INSERT " . DB_PREFIX . "multi_cart_users (`mcu_id`, `mcu_cart_id`, `mcu_user_id`, `mcu_session_id`, `mcu_is_owner`,`mcu_is_active`) VALUES (NULL, '".$new_cart_id."', '" . (int)$this->customer->getId() . "', '" . $this->db->escape($this->session->getId()) . "', 1,1)");	
				
				$this->db->query("INSERT " . DB_PREFIX . "multi_cart_products SET product_id = '" . (int)$product_id . "', recurring_id = '" . (int)$recurring_id . "', `option` = '" . $this->db->escape(json_encode($option)) . "', quantity = '" . (int)$quantity . "', date_added = NOW(), cart_id = '" . $new_cart_id . "', added_by = " . (int)$this->customer->getId());					
				
			}else{
			
				$new_cart_id = $query->row['mc_cart_id'];
				
				$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 1 WHERE mcu_cart_id = '" . $new_cart_id . "' AND mcu_session_id = '" . $this->db->escape($this->session->getId()) . "'");
				
				$this->db->query("INSERT " . DB_PREFIX . "multi_cart_products SET product_id = '" . (int)$product_id . "', recurring_id = '" . (int)$recurring_id . "', `option` = '" . $this->db->escape(json_encode($option)) . "', quantity = '" . (int)$quantity . "', date_added = NOW(), cart_id = '" . $new_cart_id . "', added_by = " . (int)$this->customer->getId());
				
			}
			
		} else {
		
			$cart_id = $query->row['cart_id'];
	
			$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_products SET quantity = (quantity + " . (int)$quantity . ") WHERE cart_id = '" . $cart_id . "' AND product_id = '" . (int)$product_id . "' AND recurring_id = '" . (int)$recurring_id . "' AND `option` = '" . $this->db->escape(json_encode($option)) . "'");
		}
	}

	public function update($mcp_id, $quantity) {
		$cart_id = $this->getActiveCartId();
		if( intval($cart_id)> 0 ){
			$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_products SET quantity = '" . (int)$quantity . "' WHERE mcp_id = '" . (int)$mcp_id . "' AND cart_id = '" . $cart_id. "'");
		}
	}

	public function remove($mcp_id) {
	
		$cart_id = $this->getActiveCartId();
		if( intval($cart_id)> 0 ){
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_products WHERE mcp_id = '" . (int)$mcp_id . "' AND cart_id = '" . $cart_id. "'");
			$query = $this->db->query("SELECT count(mcp_id) FROM " . DB_PREFIX . "multi_cart_products WHERE cart_id = '" . $cart_id. "'");
			if (isset($query->row['num_rows'])) {	
				$this->db->query("UPDATE " . DB_PREFIX . "multi_cart SET mc_current_stage = 0, mc_checkout_by_user = 0 WHERE mc_cart_id = '" . (int)$cart_id . "'");
			}                        
		}
	}

	public function clear() {
	
		$cart_id = $this->getActiveCartId();
		if( intval($cart_id)> 0 ){
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart WHERE mc_cart_id = '" . $cart_id. "'");
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_users WHERE mcu_cart_id = '" . $cart_id. "'");
			$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_products WHERE cart_id = '" . $cart_id. "'");
                        $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_user_last_tracked SET mcult_tracked_time = CURRENT_TIMESTAMP, mcult_checkout_tracked_time = NULL WHERE mcult_user_id = '" . (int)$this->customer->getId() . "'");	
		}
	}
	
	public function getActiveCartId(){
		//die($this->db->escape($this->session->getId()));
		$query = $this->db->query("SELECT mcu_cart_id,COUNT(*) AS total FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id  WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' AND mcu_is_active=1 ");		
		
		$cart_id = 0;
		if (intval($query->row['total'])>0) {
			$cart_id = $query->row['mcu_cart_id'];
		}
	
		return $cart_id;
	}

	public function getRecurringProducts() {
		$product_data = array();

		foreach ($this->getProducts() as $value) {
			if ($value['recurring']) {
				$product_data[] = $value;
			}
		}

		return $product_data;
	}

	public function getWeight() {
		$weight = 0;

		foreach ($this->getProducts() as $product) {
			if ($product['shipping']) {
				$weight += $this->weight->convert($product['weight'], $product['weight_class_id'], $this->config->get('config_weight_class_id'));
			}
		}

		return $weight;
	}

	public function getSubTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $product['total'];
		}

		return $total;
	}

	public function getTaxes() {
		$tax_data = array();

		foreach ($this->getProducts() as $product) {
			if ($product['tax_class_id']) {
				$tax_rates = $this->tax->getRates($product['price'], $product['tax_class_id']);

				foreach ($tax_rates as $tax_rate) {
					if (!isset($tax_data[$tax_rate['tax_rate_id']])) {
						$tax_data[$tax_rate['tax_rate_id']] = ($tax_rate['amount'] * $product['quantity']);
					} else {
						$tax_data[$tax_rate['tax_rate_id']] += ($tax_rate['amount'] * $product['quantity']);
					}
				}
			}
		}

		return $tax_data;
	}

	public function getTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'];
		}

		return $total;
	}

	public function countProducts() {
		$product_total = 0;

		$products = $this->getProducts();
		
		foreach ($products as $product) {
			$product_total += $product['quantity'];
		}

		return $product_total;
	}

	public function hasProducts() {
		return count($this->getProducts());
	}

	public function hasRecurringProducts() {
		return count($this->getRecurringProducts());
	}

	public function hasStock() {
		$stock = true;

		foreach ($this->getProducts() as $product) {
			if (!$product['stock']) {
				$stock = false;
			}
		}

		return $stock;
	}

	public function hasShipping() {
		$shipping = false;
		foreach ($this->getProducts() as $product) {
			if ($product['shipping']) {
				$shipping = true;

				break;
			}
		}

		return $shipping;
	}

	public function hasDownload() {
		$download = false;

		foreach ($this->getProducts() as $product) {
			if ($product['download']) {
				$download = true;

				break;
			}
		}

		return $download;
	}
	
	public function getAllCarts(){
		$multi_cart_query = $this->db->query("SELECT *,sum(quantity) as total_items FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "multi_cart_products ON " . DB_PREFIX . "multi_cart_products.cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE mcu_user_id = '" . (int)$this->customer->getId() . "' AND " . DB_PREFIX . "multi_cart_users.mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' GROUP BY mc_cart_id");
		$mc_data = array();
		foreach ($multi_cart_query->rows as $multi_cart_rows) {
			$mc_data[$multi_cart_rows['mc_cart_id']]['mc_name'] = $multi_cart_rows['mc_name'];
			$mc_data[$multi_cart_rows['mc_cart_id']]['mc_description'] = $multi_cart_rows['mc_description'];
			$mc_data[$multi_cart_rows['mc_cart_id']]['mc_datetime'] = $multi_cart_rows['mc_datetime'];
			$mc_data[$multi_cart_rows['mc_cart_id']]['mc_current_stage'] = $multi_cart_rows['mc_current_stage'];
			$mc_data[$multi_cart_rows['mc_cart_id']]['mc_checkout_by_user'] = $multi_cart_rows['mc_checkout_by_user'];
                        $mc_data[$multi_cart_rows['mc_cart_id']]['total_items'] = ($multi_cart_rows['total_items'] != NULL )?$multi_cart_rows['total_items']:0;
		}
		return $mc_data;
	
	}
	
	public function getAllCartUsers(){
            
        $cart_id = $this->getActiveCartId();
	
		$multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "customer  ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart_users.mcu_user_id LEFT JOIN " . DB_PREFIX . "multi_cart_user_last_tracked ON " . DB_PREFIX . "multi_cart_user_last_tracked.mcult_user_id = " . DB_PREFIX . "customer.customer_id WHERE mc_cart_id = '" . (int)$cart_id . "' group by customer_id");
		$mc_data = array();
		foreach ($multi_cart_query->rows as $multi_cart_rows) {
                    //echo '<pre>';    print_r($multi_cart_rows); exit();
                   
			$mc_data[$multi_cart_rows['mcu_id']]['firstname'] = $multi_cart_rows['firstname'];
			$mc_data[$multi_cart_rows['mcu_id']]['mcu_id'] = $multi_cart_rows['mcu_id'];
                        $mc_data[$multi_cart_rows['mcu_id']]['mc_cart_id'] = $multi_cart_rows['mc_cart_id'];
                        $mc_data[$multi_cart_rows['mcu_id']]['mcu_is_owner'] = $multi_cart_rows['mcu_is_owner'];
                        $mc_data[$multi_cart_rows['mcu_id']]['mcu_is_active'] = $multi_cart_rows['mcu_is_active'];
                        $mc_data[$multi_cart_rows['mcu_id']]['customer_id'] = $multi_cart_rows['customer_id'];
                        $mc_data[$multi_cart_rows['mcu_id']]['mcult_tracked_time'] = $multi_cart_rows['mcult_tracked_time'];
                        
                        
		}
		return $mc_data;
	
		}
        
        public function getCartOwner(){
            $cart_id = $this->getActiveCartId();
            $multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE mcu_is_owner = 1 AND mc_cart_id = '" . (int)$cart_id . "'");
		if( $multi_cart_query->num_rows > 0 ){
			return $multi_cart_query->row['mcu_user_id'];
		}
		return array();

        }
        
        public function isValidCart($cart_id){
            $multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart WHERE mc_cart_id= '" . (int)$cart_id . "'");
            $num_rows = $multi_cart_query->num_rows;
            return ($num_rows >0)? 1:0;
        }
        
        public function checkCartUser($cart_id,$customer_id){
            $multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id WHERE mcu_user_id = '" . (int)$customer_id . "' AND mc_cart_id= '" . (int)$cart_id . "'");
            $num_rows = $multi_cart_query->num_rows;
            return ($num_rows >0)? 1:0;        
        }

        public function addUserToCart($cart_id){
            $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 0 WHERE mcu_user_id = '" . (int)$this->customer->getId() . "'");
            if( !$this->db->query("INSERT " . DB_PREFIX . "multi_cart_users (`mcu_id`, `mcu_cart_id`, `mcu_user_id`, `mcu_session_id`, `mcu_is_owner`,`mcu_is_active`) VALUES (NULL, '".$cart_id."', '" . (int)$this->customer->getId() . "', '" . $this->db->escape($this->session->getId()) . "', 0,1)")){
                return false;
            }
            
            return true;
        }
        
        public function removeUserFromCart($user_id){
            
            $cart_id = $this->getActiveCartId();

            if( !$this->db->query("DELETE FROM " . DB_PREFIX . "multi_cart_users WHERE mcu_user_id = '" . (int)$user_id . "' AND mcu_cart_id = '" . (int)$cart_id . "' AND mcu_is_owner != 1 ")){
                return false;
            }
            $multi_cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "multi_cart_users WHERE mcu_user_id = '" . (int)$user_id . "'");
            foreach ($multi_cart_query->rows as $multi_cart_rows) {
                $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 1 WHERE mcu_user_id = '" . (int)$user_id. "' AND mcu_cart_id = '" . (int)$multi_cart_rows['mcu_cart_id'] . "'");
                return true;
            }
            return false;
        }
        
        public function getCartOwnerName($cart_id){

            $query = $this->db->query("SELECT firstname,lastname FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "customer ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart_users.mcu_user_id WHERE mc_cart_id= '" . (int)$cart_id . "' AND mcu_is_owner = 1");
            return $query->row['firstname'].' '.$query->row['lastname'];
        }
        
        public function updateActiveCart($cart_id){
            $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 0 WHERE mcu_user_id = '" . (int)$this->customer->getId() . "'");
            $this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 1 WHERE mcu_user_id = '" . (int)$this->customer->getId() . "' AND mcu_cart_id= '" . (int)$cart_id . "'");
            return true;
        }
        
        public function createNewCart($cart_name='',$cart_description='', $user_id = 0){
			if( $user_id == 0 ){
				$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_is_active = 0 WHERE mcu_user_id = '" . (int)$this->customer->getId() . "'");
				$this->db->query("INSERT " . DB_PREFIX . "multi_cart (`mc_cart_id`, `mc_name`, `mc_description`, `mc_datetime`, `mc_current_stage`) VALUES (NULL, '".$this->db->escape($cart_name)."', '".$this->db->escape($cart_description)."', NOW(), '0')");
				$new_cart_id = $this->db->getLastId();
				if($new_cart_id>0){
					$this->db->query("INSERT " . DB_PREFIX . "multi_cart_users (`mcu_id`, `mcu_cart_id`, `mcu_user_id`, `mcu_session_id`, `mcu_is_owner`,`mcu_is_active`) VALUES (NULL, '".$new_cart_id."', '" . (int)$this->customer->getId() . "', '" . $this->db->escape($this->session->getId()) . "', 1,1)");	            
					return true;
				}
				return false;
			}else{
				
				// We want to change the session ID on all the old items in the customers cart
				$this->db->query("UPDATE " . DB_PREFIX . "multi_cart_users SET mcu_session_id = '" . $this->db->escape($this->session->getId()) . "' WHERE mcu_user_id = '" . $user_id . "'");
				
				$query = $this->db->query("SELECT mcu_cart_id,COUNT(*) AS total FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id  WHERE " . DB_PREFIX . "multi_cart_users.mcu_user_id = '" . $user_id . "' AND mcu_session_id = '" . $this->db->escape($this->session->getId()) . "'");
				if( isset($query->row['mcu_cart_id']) && intval($query->row['mcu_cart_id']) > 0  ){
					$cart_id = $query->row['mcu_cart_id'];
					$this->updateActiveCart($cart_id);		
				}
			}
        }
        
        public function checkoutStage(){
            $cart_id = $this->getActiveCartId();
            $query = $this->db->query("SELECT firstname,lastname,mc_current_stage,mc_checkout_by_user,mcult_tracked_time FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "customer ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart.mc_checkout_by_user LEFT JOIN " . DB_PREFIX . "multi_cart_user_last_tracked ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart_user_last_tracked.mcult_user_id WHERE mc_cart_id= '" . (int)$cart_id . "' group by mc_checkout_by_user");
            $row_data = $query->row;

			if( $query->num_rows > 0 ){
				
				$timezone = new DateTimeZone(DB_TIMEZONE_SETTING);
				$date = new DateTime();
				$date->setTimezone($timezone );
				$time1 = strtotime($row_data['mcult_tracked_time']);
				$time2 = strtotime($date->format( 'Y-m-d H:i:s' ));

				$diff = ($time2-$time1)/60;              

				if( ( isset($row_data['mcult_tracked_time'])&& $row_data['mcult_tracked_time']==NULL ) || $diff >  5 ){
					$this->db->query("UPDATE " . DB_PREFIX . "multi_cart SET mc_current_stage = 0, mc_checkout_by_user = 0 WHERE mc_cart_id = " . (int)$cart_id );            
					$query = $this->db->query("SELECT firstname,lastname,mc_current_stage,mc_checkout_by_user,mcult_tracked_time FROM " . DB_PREFIX . "multi_cart LEFT JOIN " . DB_PREFIX . "multi_cart_users  ON " . DB_PREFIX . "multi_cart_users.mcu_cart_id = " . DB_PREFIX . "multi_cart.mc_cart_id LEFT JOIN " . DB_PREFIX . "customer ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart.mc_checkout_by_user LEFT JOIN " . DB_PREFIX . "multi_cart_user_last_tracked ON " . DB_PREFIX . "customer.customer_id = " . DB_PREFIX . "multi_cart_user_last_tracked.mcult_user_id WHERE mc_cart_id= '" . (int)$cart_id . "' group by mc_checkout_by_user");
					$row_data = $query->row;                
				}
				return $row_data;
			}else{
				return array();
			}

        }
        
        public function updateCheckoutStage($stage,$mc_checkout_by_user){
            $cart_id = $this->getActiveCartId();
            $this->db->query("UPDATE " . DB_PREFIX . "multi_cart SET mc_current_stage = ".(int)$stage.", mc_checkout_by_user = ".(int)$mc_checkout_by_user." WHERE mc_cart_id = " . (int)$cart_id );
        }        
        
}