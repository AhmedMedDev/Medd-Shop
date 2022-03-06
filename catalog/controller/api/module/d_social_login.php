<?php

/*
 * 	location: catalog/controller/module/d_social_login.php
 */

class ControllerAPIModuleDSocialLogin extends Controller {

    private $route = 'module/d_social_login';
    private $id = 'd_social_login';
    private $setting = array();
    private $sl_redirect = '';
	private $error = array();
    public function index() {

        $this->setup();
		$this->load->model('account/api');
        $this->language->load($this->route);
        $this->load->model($this->route);

		
        $setting = $this->config->get('d_social_login_setting');

        $data['heading_title'] = $this->language->get('heading_title');
        $data['button_sign_in'] = $this->language->get('button_sign_in');
        $data['size'] = $setting['size'];
        $data['islogged'] = $this->customer->isLogged();

        $providers = $setting['providers'];
        $sort_order = array();
        foreach ($providers as $key => $value) {
            if (isset($value['sort_order'])) {
                $sort_order[$key] = $value['sort_order'];
            }
        }
        array_multisort($sort_order, SORT_ASC, $providers);
        $data['providers'] = $providers;
        foreach ($providers as $key => $val) {
            $data['providers'][$key]['heading'] = $this->language->get('text_sign_in_with_' . $val['id']);
        }
        $data['error'] = false;
        if (isset($this->session->data['d_social_login_error'])) {
            $data['error'] = $this->session->data['d_social_login_error'];
            unset($this->session->data['d_social_login_error']);
        }

        $this->session->data['sl_redirect'] = ($setting['return_page_url']) ? $setting['return_page_url'] : $this->getCurrentUrl();

		//facebook fix
        unset($this->session->data['HA::CONFIG']);
        unset($this->session->data['HA::STORE']);

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/d_social_login.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/module/d_social_login.tpl', $data);
        } else {
            return $this->load->view('default/template/module/d_social_login.tpl', $data);
        }
    }

    public function login() {
		$this->setup();
		
		require_once(DIR_SYSTEM . 'library/Hybrid/Auth.php');
		$this->language->load($this->route);
		$this->load->model($this->route);
		$postData =  $this->request->post;
		
		if(empty($postData['identifier'])){
			$this->error['warning'] = 'Error : Identifier not available';
		}
		if(empty($postData['provider'])){
			$this->error['warning'] = 'Error : Who is the provider';
		}
		if(empty($postData['email'])){
			$this->error['warning'] = 'Error : Email address is not available';
		}
		if(empty($postData['first_name'])){
			$this->error['warning'] = 'Error : Name is not available';
		}
		
		if (!$this->error) {
			$authentication_data = array(
				'provider' => $postData['provider'],
				'identifier' => $postData['identifier'],
				'web_site_url' => $postData['web_site_url'],
				'profile_url' => $postData['profile_url'],
				'photo_url' => $postData['photo_url'],
				'display_name' => $postData['display_name'],
				'description' => $postData['description'],
				'first_name' => $postData['first_name'],
				'last_name' => $postData['last_name'],
				'gender' => $postData['gender'],
				'language' => $postData['language'],
				'age' => $postData['age'],
				'birth_day' => $postData['birthDay'],
				'birth_month' => $postData['birthMonth'],
				'birth_year' => $postData['birthYear'],
				'email' => $postData['email'],
				'email_verified' => $postData['email'],
				'phone' => $postData['phone'],
				'address' => $postData['address'],
				'country' => $postData['country'],
				'region' => $postData['region'],
				'city' => $postData['city'],
				'zip' => $postData['zip']
			);
				
			$customer_id = $this->model_module_d_social_login->getCustomerByIdentifier($postData['provider'], $postData['identifier']);
			
			$authentication_added = false;
			if ($customer_id) {
				$authentication_added = true;
				$this->model_module_d_social_login->login($customer_id);

				//$this->response->redirect($this->sl_redirect);
			}
			
			/* $customer_id = $this->model_module_d_social_login->getCustomerByIdentifierOld($postData['provider'], $postData['identifier']); */
				
				//check by email
			if ($postData['email'] && $authentication_added === false) {
				$customer_id = $this->model_module_d_social_login->getCustomerByEmail($postData['email']);
			}
			
				
			if (!$customer_id) {
				
				$address = array();
				if (!empty($postData['address'])) {
					$address[] = $postData['address'];
				}

				if (!empty($postData['region'])) {
					$address[] = $postData['region'];
				}

				if (!empty($postData['country'])) {
					$address[] = $postData['country'];
				}
				$password = $this->db->escape(md5(rand()));
				$customer_data = array(
					'email' => $postData['email'],
					'firstname' => $postData['first_name'],
					'lastname' => $postData['last_name'],
					'phone' => $postData['phone'],
					'fax' => false,
					'newsletter' => 0,
					'customer_group_id' => (isset($postData['customer_group'])) ? $postData['customer_group'] : '1',
					'company' => false,
					'address_1' => ($address ? implode(', ', $address) : false),
					'address_2' => false,
					'city' => $postData['city'],
					'postcode' => $postData['zip'],
					'country_id' => $this->model_module_d_social_login->getCountryIdByName($postData['country']),
					'zone_id' => $this->model_module_d_social_login->getZoneIdByName($postData['region']),
					'password' => $password
				);

				if (!$form) {
					$customer_id = $this->model_module_d_social_login->addCustomer($customer_data);
				} else {
					$this->form($customer_data, $authentication_data);
				}
			}
			
			if ($customer_id) {
				
				$authentication_data['customer_id'] = (int) $customer_id;
				
				if($authentication_added === false) {
					$this->model_module_d_social_login->addAuthentication($authentication_data);
				}
				
				$this->model_module_d_social_login->login($customer_id);
				$json['authentication_data'] = $authentication_data;
				$json['status'] = 1;
				
				
				/* Login */
				$this->load->model('account/api');
				$this->load->model('account/customer');
				$this->load->language('api/login');
				$api_info = $this->model_account_api->getApiByKey( $this->request->post[ 'key' ] );
				
				if ($api_info) {
					$json['success'] = $this->language->get( 'text_success' );

					$sesion_name = 'temp_session_' . uniqid();
					$session = new Session($this->session->getId(), $sesion_name);
					$session->data['api_id'] = $api_info['api_id'];
					$this->session->data['api_id'] = $api_info['api_id'];
					
					$json['email'] = $postData['email'];
					$json['id'] = $customer_id;
					$json['name'] = $postData['first_name'];
					$json['profile_image'] = $postData['photo_url'];
					$json['status'] = 1;
					
					// Create Token
					$json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
					$this->model_account_api->updateUserToken($customer_id,$json['token']);
					$this->session->data['api_token'] = $json['token'];
				} else {
					$json['status'] = 0;
					$json['error']['key'] = $this->language->get('error_key');
				}
			}
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}else{
			$json['status'] = 0;
			$json['message'] = $this->error['warning'];
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
    }

    public function apple_login() {
        $this->setup();
        $json = array();
		
		$this->language->load($this->route);
		$this->load->model($this->route);
        
        $this->load->model('account/api');
        $this->load->model('account/customer');
        $this->load->language('api/login');
		
        $appleResponse = $this->request->post; 
        
        if(empty($appleResponse['id_token'])){
            $json['status'] = 0;
			$json['error'] = 'Error : id_token not available';
		}   
        
        $api_info = $this->model_account_api->getApiByKey( $appleResponse['key'] );
        if (empty($api_info)) {
            $json['status'] = 0;
            $json['error']['key'] = $this->language->get('error_key');
        }         
        
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$base_url = $this->config->get('config_ssl');
		} else {
			$base_url = $this->data['base'] = $this->config->get('config_url');
		} 
		
		if (!$json) { 
             
            $claims = explode('.', $appleResponse['id_token'])[1];
            $claims = json_decode(base64_decode($claims), true);
            $appleUserInfo = isset($appleResponse['user']) ? json_decode($appleResponse['user'], true) : false;

            $isPrivateEmailId = false;
            if (isset($claims['is_private_email']) && $claims['is_private_email'] == true ) {
                $isPrivateEmailId = true;
            }

            $userAppleId = isset($claims['sub']) ? $claims['sub'] : '';

            if (false === $appleUserInfo) {
                if (!isset($claims['email'])) {
                    $message = 'MSG_UNABLE_TO_FETCH_USER_INFO';
                    $json['status'] = 0;
                    $json['error'] = $message;        
                    $this->response->addHeader('Content-Type: application/json');
                    $this->response->setOutput(json_encode($json));
                }
                $appleEmailId = $claims['email'];
            } else {
                $appleEmailId = $appleUserInfo['email'];
            }     
        
            if (true === $isPrivateEmailId && !empty($userAppleId)) {
                $userInfo = $this->model_module_d_social_login->getCustomerInfoByAppleId($userAppleId);
            } else { 
                $userInfo = $this->model_module_d_social_login->getCustomerInfoByEmail($appleEmailId);
            }
            
            if (!empty($userInfo)) {                
                $customer_id = $userInfo['customer_id'];                                 
               /*  $this->model_module_d_social_login->login($customer_id);
                
                $json['status'] = 1;
                //$json['authentication_data'] = $authentication_data;
                $json['success'] = $this->language->get( 'text_success' );
                $sesion_name = 'temp_session_' . uniqid();
                $session = new Session($this->session->getId(), $sesion_name);
                $session->data['api_id'] = $api_info['api_id'];
                $this->session->data['api_id'] = $api_info['api_id'];
                $json['email'] = $userInfo['email'];
                $json['id'] = $customer_id;
                $json['first_name'] = $userInfo['firstname'];
                $json['last_name'] = $userInfo['lastname'];
                $json['profile_image'] = '';
                $json['status'] = 1;

                // Create Token
                $json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
                $this->model_account_api->updateUserToken($customer_id,$json['token']);
                $this->session->data['api_token'] = $json['token']; */
            }
            else {              
                $exp = explode("@", $appleEmailId);
                $appleUserName = substr($exp[0], 0, 80) . rand();                
                $Name = substr($exp[0], 0, 80);                
                $customer_data = array(
                    'email' => $appleEmailId,
                    'firstname' => $Name,
                    'lastname' => $Name,
                    'phone' => '',
                    'fax' => false,
                    'newsletter' => $this->setting['newsletter'],
                    'customer_group_id' => '1',
                    'company' => false,
                    'address_1' => '',
                    'address_2' => false,
                    'city' => '',
                    'postcode' => '',
                    'country_id' => '',
                    'zone_id' => '',
                    'password' => ''
                );
                
                
                $customer_id = $this->model_module_d_social_login->addCustomer($customer_data);                
                
                $authentication_data = array(
                    'provider' => 'Apple',
                    'identifier' => md5($appleEmailId),
                    'web_site_url' => $base_url,
                    'profile_url' => '',
                    'photo_url' => '',
                    'display_name' => $appleUserName,
                    'description' => '',
                    'first_name' => $Name,
                    'last_name' => $Name,
                    'gender' => '',
                    'language' => '',
                    'age' => '',
                    'birth_day' => '',
                    'birth_month' => '',
                    'birth_year' => '',
                    'email' => $appleEmailId,
                    'email_verified' => 1,
                    'phone' => '',
                    'address' => '',
                    'country' => '',
                    'region' => '',
                    'city' => '',
                    'user_apple_id' => $userAppleId,
                    'zip' => ''
                );
                
                                                
                
                if ($customer_id) { 
                    
                        //$authentication_data['customer_id'] = (int) $customer_id;
                        $this->model_module_d_social_login->addAuthentication($authentication_data);  
                        $userInfo = array(
                                    'email' => $authentication_data['email'],
                                    'firstname' => $authentication_data['first_name'] ,
                                    'lastname' => $authentication_data['last_name']
                        
                        );
                        /* $this->model_module_d_social_login->login($customer_id);
                        
                        $json['status'] = 1;
                        //$json['authentication_data'] = $authentication_data;
                        $json['success'] = $this->language->get( 'text_success' );
                        $sesion_name = 'temp_session_' . uniqid();
                        $session = new Session($this->session->getId(), $sesion_name);
                        $session->data['api_id'] = $api_info['api_id'];
                        $this->session->data['api_id'] = $api_info['api_id'];
                        $json['email'] = $appleEmailId;
                        $json['id'] = $customer_id;
                        $json['first_name'] = $authentication_data['first_name'];
                        $json['last_name'] = $authentication_data['last_name'];
                        $json['profile_image'] = '';
                        $json['status'] = 1;
                        
                        $json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
                        $this->model_account_api->updateUserToken($customer_id,$json['token']);
                        $this->session->data['api_token'] = $json['token']; */
                }  
                else {
                    $json['status'] = 0;
                    $json['error'] = 'Error : customer id not available';
                    $this->response->addHeader('Content-Type: application/json');
                    $this->response->setOutput(json_encode($json));
                }
               
            } 
            
            $this->model_module_d_social_login->login($customer_id);
            $json['status'] = 1;
            //$json['authentication_data'] = $authentication_data;
            $json['success'] = $this->language->get( 'text_success' );
            $sesion_name = 'temp_session_' . uniqid();
            $session = new Session($this->session->getId(), $sesion_name);
            $session->data['api_id'] = $api_info['api_id'];
            $this->session->data['api_id'] = $api_info['api_id'];
            $json['email'] = $userInfo['email'];
            $json['id'] = $customer_id;
            $json['first_name'] = $userInfo['firstname'];
            $json['last_name'] = $userInfo['lastname'];
            $json['profile_image'] = '';
            $json['status'] = 1;

            // Create Token
            $json['token'] = $this->model_account_api->addApiSession($api_info['api_id'], $sesion_name, $session->getId(), $this->request->server['REMOTE_ADDR']);
            $this->model_account_api->updateUserToken($customer_id,$json['token']);
            $this->session->data['api_token'] = $json['token'];
            
            $this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
            
        }
        else {               
                $this->response->addHeader('Content-Type: application/json');
                $this->response->setOutput(json_encode($json));
        }
            
    }
    private function form($customer_data, $authentication_data) {
        $this->session->data['customer_data'] = $customer_data;
        $this->session->data['authentication_data'] = $authentication_data;
        $data['provider'] = $this->setting['provider'];
        $data['customer_data'] = $customer_data;
        $data['authentication_data'] = $authentication_data;
        $data['button_sign_in_mail'] = $this->language->get('button_sign_in_mail');
        $data['button_sign_in'] = $this->language->get('button_sign_in');
        $data['text_none'] = $this->language->get('text_none');
        $data['text_select'] = $this->language->get('text_select');
        $data['text_email'] = $this->language->get('text_email');
        $data['text_firstname'] = $this->language->get('text_firstname');
        $data['text_lastname'] = $this->language->get('text_lastname');
        $data['text_phone'] = $this->language->get('text_phone');
        $data['text_address_1'] = $this->language->get('text_address_1');
        $data['text_address_2'] = $this->language->get('text_address_1');
        $data['text_city'] = $this->language->get('text_city');
        $data['text_postcode'] = $this->language->get('text_postcode');
        $data['text_country_id'] = $this->language->get('text_country_id');
        $data['text_zone_id'] = $this->language->get('text_zone_id');
        $data['text_company'] = $this->language->get('text_company');
        // $data['text_company_id'] = $this->language->get('text_company_id');
        // $data['text_tax_id'] = $this->language->get('text_tax_id');
        $data['text_password'] = $this->language->get('text_password');
        $data['text_confirm'] = $this->language->get('text_confirm');
        $data['text_email_intro'] = $this->language->get('text_email_intro');

        $data['background_img'] = $this->setting['background_img'];
        $data['background_color'] = $this->setting['providers'][ucfirst($this->setting['provider'])]['background_color'];
        if ($this->setting['iframe']) {
            $data['iframe'] = $this->sl_redirect;
        } else {
            $data['iframe'] = false;
        }

        $sort_order = array();
        foreach ($this->setting['fields'] as $key => $value) {
            if (isset($value['sort_order'])) {
                $sort_order[$key] = $value['sort_order'];
            }
        }
        array_multisort($sort_order, SORT_ASC, $this->setting['fields']);
        $data['fields'] = $this->setting['fields'];

        $this->load->model('localisation/country');
        $data['countries'] = $this->model_localisation_country->getCountries();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/d_social_login/form.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/d_social_login/form.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/d_social_login/form.tpl', $data));
        }
    }

    public function register() {

        $this->setup();

        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            return false;
        }
        $this->language->load($this->route);
        $this->load->model($this->route);

        $json = array();
        $customer_data = array_merge($this->session->data['customer_data'], $this->request->post);
        $authentication_data = $this->session->data['authentication_data'];
        $this->setting = $this->config->get('d_social_login_setting');
		
        // check email
        if ($this->validate_email($customer_data['email'])) {
            $customer_id = $this->model_module_d_social_login->getCustomerByEmail($customer_data['email']);
            if ($customer_id) {
                if (!$this->model_module_d_social_login->checkAuthentication($customer_id, $this->session->data['provider'])) {
                    $authentication_data['customer_id'] = (int) $customer_id;
                    $this->model_module_d_social_login->addAuthentication($authentication_data);
                } else {
                    $json['error']['email'] = $this->language->get('error_email_taken');
                }
            }
        } else {

            $json['error']['email'] = $this->language->get('error_email_incorrect');
        }

        // fields
        foreach ($this->setting['fields'] as $field) {
            if ($field['enabled']) {
                if ($field['id'] == 'confirm') {
                    if (($customer_data['password'] != $customer_data['confirm'])) {
                        $json['error']['confirm'] = $this->language->get('error_password_and_confirm_different');
                    }
                }
                if ($this->request->post[$field['id']] == "") {
                    $json['error'][$field['id']] = $this->language->get('error_fill_all_fields');
                }
            }
        }


        if (empty($json['error'])) {

            if (!$this->setting['fields']['password']['enabled']) {
                $customer_data['password'] = $this->password();
            }

            $customer_id = $this->model_module_d_social_login->addCustomer($customer_data);
            $this->cart->createNewCart();
            $authentication_data['customer_id'] = (int) $customer_id;
            $this->model_module_d_social_login->addAuthentication($authentication_data);

            //login
            $this->model_module_d_social_login->login($customer_id);
			
			//update profile photo : customer
			
			if(isset($authentication_data['photo_url'])){
				$image_url = file_get_contents($authentication_data['photo_url']);
				
				$newfilename = round(microtime(true)). rand(2,99) . '.jpg';
								
				$file_path   = DIR_PROFILE_UPLOAD.$newfilename;
				
				
				file_put_contents($file_path, $image_url);
				
				$this->load->model('tool/profile_upload');

				$this->model_tool_profile_upload->addUpload($customer_id,$newfilename);
			}
			
            //redirect
            $json['redirect'] = $this->sl_redirect;
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function validate_email($email) {
        if (preg_match('/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/', $email)) {
            return true;
        } else {
            return false;
        }
    }

    private function password($length = 8) {
        $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $count = strlen($chars);

        for ($i = 0, $result = ''; $i < $length; $i++) {
            $index = rand(0, $count - 1);
            $result .= substr($chars, $index, 1);
        }

        return $result;
    }

    private function setup() {
        // correct &amp; in url
        if (isset($this->request->get)) {

            foreach ($this->request->get as $key => $value) {
                $this->request->get[str_replace('amp;', '', $key)] = $value;
            }
        }

        if (isset($_GET)) {
            foreach ($_GET as $key => $value) {
                $_GET[str_replace('amp;', '', $key)] = $value;
            }
        }

        // set redirect address
        if (isset($this->session->data['sl_redirect']) && !stripos($this->session->data['sl_redirect'], 'logout')) {
            $this->sl_redirect = $this->session->data['sl_redirect'];
        } else {
            $this->sl_redirect = $this->url->link('account/account', '', 'SSL');            		
        }
    }

    private function getCountryId($profile) {
        $this->load->model($this->route);

        if ($profile['country']) {
            return $this->model_module_d_social_login->getCountryIdByName($profile['country']);
        }

        if ($profile['region']) {
            return $this->model_module_d_social_login->getCountryIdByName($profile['region']);
        }

        return $this->config->get('config_country_id');
    }

    public function getCurrentUrl($request_uri = true) {
        if (
            isset($_SERVER['HTTPS']) && ( $_SERVER['HTTPS'] == 'on' || $_SERVER['HTTPS'] == 1 ) || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https'
        ) {
            $protocol = 'https://';
        } else {
            $protocol = 'http://';
        }

        $url = $protocol . $_SERVER['HTTP_HOST'];

        if (isset($_SERVER['SERVER_PORT']) && strpos($url, ':' . $_SERVER['SERVER_PORT']) === FALSE) {
            $url .= ($protocol === 'http://' && $_SERVER['SERVER_PORT'] != 80 && !isset($_SERVER['HTTP_X_FORWARDED_PROTO'])) || ($protocol === 'https://' && $_SERVER['SERVER_PORT'] != 443 && !isset($_SERVER['HTTP_X_FORWARDED_PROTO'])) ? ':' . $_SERVER['SERVER_PORT'] : '';
        }

        if ($request_uri) {
            $url .= $_SERVER['REQUEST_URI'];
        } else {
            $url .= $_SERVER['PHP_SELF'];
        }

        // return current url
        return $url;
    }

}