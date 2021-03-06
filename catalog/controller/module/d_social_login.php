<?php

/*
 * 	location: catalog/controller/module/d_social_login.php
 */

class ControllerModuleDSocialLogin extends Controller {

    private $route = 'module/d_social_login';
    private $id = 'd_social_login';
    private $setting = array();
    private $sl_redirect = '';

    public function index() {

        $this->setup();

        $this->language->load($this->route);
        $this->load->model($this->route);

        $this->document->addStyle('catalog/view/theme/default/stylesheet/d_social_login/styles.css');
        $this->document->addScript('catalog/view/javascript/d_social_login/spin.min.js');

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

        $this->setting = $this->config->get('d_social_login_setting');

        $this->setting['base_url'] = $this->config->get('config_secure') ? HTTPS_SERVER . 'd_social_login.php' : HTTP_SERVER . 'd_social_login.php';
        $this->setting['debug_file'] = DIR_LOGS . $this->setting['debug_file'];
        $this->setting['debug_mode'] = (bool) $this->setting['debug_mode'];

        if (isset($this->request->get['provider'])) {
        
            if($this->request->get['provider'] == 'Apple') {	
                $this->response->redirect('module/d_social_login/apple_login');	
            }
            $this->session->data['provider'] = $this->setting['provider'] = $this->request->get['provider'];
        } else {

            // Save error to the System Log
            $this->log->write('Missing application provider.');

            // Set Message
            $this->session->data['error'] = sprintf("An error occurred, please <a href=\"%s\">notify</a> the administrator.", $this->url->link('information/contact'));

            // Redirect to the Login Page
            $this->response->redirect($this->sl_redirect);
        }

        //facebook fix
        if ($this->setting['provider'] == 'Facebook') {
            $this->setting['base_url'] = HTTP_SERVER . 'd_social_login.php';
        }

        if ($this->setting['provider'] == 'Live') {
            $this->setting['base_url'] = $this->config->get('config_secure') ? HTTPS_SERVER . 'd_social_login_live.php' : HTTP_SERVER . 'd_social_login_live.php';
        }

        try {
            $hybridauth = new Hybrid_Auth($this->setting);
            Hybrid_Auth::$logger->info('d_social_login: Start authantication.');
            $adapter = $hybridauth->authenticate($this->setting['provider']);
            Hybrid_Auth::$logger->info('d_social_login: Start getUserProfile.');
            //get the user profile 
            $profile = $adapter->getUserProfile();
            $this->setting['profile'] = (array) $profile;

            Hybrid_Auth::$logger->info('d_social_login: got UserProfile.' . serialize($this->setting['profile']));
            $authentication_data = array(
                'provider' => $this->setting['provider'],
                'identifier' => $this->setting['profile']['identifier'],
                'web_site_url' => $this->setting['profile']['webSiteURL'],
                'profile_url' => $this->setting['profile']['profileURL'],
                'photo_url' => $this->setting['profile']['photoURL'],
                'display_name' => $this->setting['profile']['displayName'],
                'description' => $this->setting['profile']['description'],
                'first_name' => $this->setting['profile']['firstName'],
                'last_name' => $this->setting['profile']['lastName'],
                'gender' => $this->setting['profile']['gender'],
                'language' => $this->setting['profile']['language'],
                'age' => $this->setting['profile']['age'],
                'birth_day' => $this->setting['profile']['birthDay'],
                'birth_month' => $this->setting['profile']['birthMonth'],
                'birth_year' => $this->setting['profile']['birthYear'],
                'email' => $this->setting['profile']['email'],
                'email_verified' => $this->setting['profile']['emailVerified'],
                'phone' => $this->setting['profile']['phone'],
                'address' => $this->setting['profile']['address'],
                'country' => $this->setting['profile']['country'],
                'region' => $this->setting['profile']['region'],
                'city' => $this->setting['profile']['city'],
                'zip' => $this->setting['profile']['zip']
            );

            Hybrid_Auth::$logger->info('d_social_login: set authentication_data ' . serialize($authentication_data));

            //check by identifier
            $customer_id = $this->model_module_d_social_login->getCustomerByIdentifier($this->setting['provider'], $this->setting['profile']['identifier']);

            if ($customer_id) {
                Hybrid_Auth::$logger->info('d_social_login: getCustomerByIdentifier success.');
                //login
                $this->model_module_d_social_login->login($customer_id);

                //redirect
                $this->response->redirect($this->sl_redirect);
            }

            $customer_id = $this->model_module_d_social_login->getCustomerByIdentifierOld($this->setting['provider'], $this->setting['profile']['identifier']);

            //check by email
            if ($this->setting['profile']['email']) {

                $customer_id = $this->model_module_d_social_login->getCustomerByEmail($this->setting['profile']['email']);
                if ($customer_id) {
                    Hybrid_Auth::$logger->info('d_social_login: getCustomerByEmail success.');
                }
            }


            if (!$customer_id) {
                Hybrid_Auth::$logger->info('d_social_login: no customer_id. creating customer_data');
                //prepare customer data
                $address = array();

                if (!empty($this->setting['profile']['address'])) {
                    $address[] = $this->setting['profile']['address'];
                }

                if (!empty($this->setting['profile']['region'])) {
                    $address[] = $this->setting['profile']['region'];
                }

                if (!empty($this->setting['profile']['country'])) {
                    $address[] = $this->setting['profile']['country'];
                }

                $customer_data = array(
                    'email' => $this->setting['profile']['email'],
                    'firstname' => $this->setting['profile']['firstName'],
                    'lastname' => $this->setting['profile']['lastName'],
                    'phone' => $this->setting['profile']['phone'],
                    'fax' => false,
                    'newsletter' => $this->setting['newsletter'],
                    'customer_group_id' => (isset($this->setting['customer_group'])) ? $this->setting['customer_group'] : '1',
                    'company' => false,
                    'address_1' => ($address ? implode(', ', $address) : false),
                    'address_2' => false,
                    'city' => $this->setting['profile']['city'],
                    'postcode' => $this->setting['profile']['zip'],
                    'country_id' => $this->model_module_d_social_login->getCountryIdByName($this->setting['profile']['country']),
                    'zone_id' => $this->model_module_d_social_login->getZoneIdByName($this->setting['profile']['region']),
                    'password' => ''
                );

                Hybrid_Auth::$logger->info('d_social_login: set customer_data ' . serialize($customer_data));

                //check if form required
                $form = false;
                foreach ($this->setting['fields'] as $field) {
                    if ($field['enabled']) {
                        //checking if fields required for input
                        $form = true;
                        break;
                    }
                }

                if (!$form) {
                    Hybrid_Auth::$logger->info('d_social_login: adding customer with customer_data');
                    $customer_data['password'] = $this->password();
                    $customer_id = $this->model_module_d_social_login->addCustomer($customer_data);
                } else {
                    Hybrid_Auth::$logger->info('d_social_login: need to use form');
                    $this->form($customer_data, $authentication_data);
                }
            }

            if ($customer_id) {
                Hybrid_Auth::$logger->info('d_social_login: customer_id found');
                $authentication_data['customer_id'] = (int) $customer_id;

                $this->model_module_d_social_login->addAuthentication($authentication_data);
                Hybrid_Auth::$logger->info('d_social_login: addAuthentication');
                //login
                $this->model_module_d_social_login->login($customer_id);

                //redirect
                $this->response->redirect($this->sl_redirect);
            }
        } catch (Exception $e) {

            switch ($e->getCode()) {
                case 0 : $error = "Unspecified error.";
                    break;
                case 1 : $error = "Hybriauth configuration error.";
                    break;
                case 2 : $error = "Provider not properly configured.";
                    break;
                case 3 : $error = "Unknown or disabled provider.";
                    break;
                case 4 : $error = "Missing provider application credentials.";
                    break;
                case 5 : $error = "Authentication failed. The user has canceled the authentication or the provider refused the connection.";
                    break;
                case 6 : $error = "User profile request failed. Most likely the user is not connected to the provider and he should to authenticate again.";
                    if (isset($adapter)) {
                        $adapter->logout();
                    }
                    break;
                case 7 : $error = "User not connected to the provider.";
                    break;
                case 8 : $error = "Provider does not support this feature.";
                    break;
            }

            if (isset($adapter)) {
                $adapter->logout();
            }

            $this->session->data['d_social_login_error'] = $error;
			$this->session->data['provider'] = '';

            $error .= "\n\nHybridAuth Error: " . $e->getMessage();
            $error .= "\n\nTrace:\n " . $e->getTraceAsString();

            $this->log->write($error);

            $this->response->redirect($this->sl_redirect);
        }
    }

    public function apple_login() {    
    
        $this->setup();
       
        $this->language->load($this->route);
        $this->load->model($this->route);
        
        $json = array();
        $appleResponse = $this->request->post; 
        
        $this->setting = $this->config->get('d_social_login_setting');	
        	
        $apple_client_id = $this->setting['providers']['Apple']['keys']['id'];	
        
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {	
			$base_url = $this->config->get('config_ssl');	
		} else {	
			$base_url = $this->data['base'] = $this->config->get('config_url');	
		}
        	
        $redirecUri = $base_url.'index.php?route=module/d_social_login/apple_login';
        
        if (isset($appleResponse['id_token'])) {
           
            if ($_SESSION['appleSignIn']['state'] != $appleResponse['state']) {
                $message = 'Authorization server returned an invalid state parameter';
                $this->session->data['error'] = $message;
                $this->response->redirect('account/register');
            }
            if (isset($_REQUEST['error'])) {
                $message = 'Authorization server returned an error: ' . htmlspecialchars($_REQUEST['error']);
                $this->session->data['error'] = $message;
                
                $this->response->redirect('account/register');
            }
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
                    $this->session->data['error'] = $message;
                    $this->response->redirect('account/register');
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
                
            } else {
               
                $exp = explode("@", $appleEmailId);
                $appleUserName = substr($exp[0], 0, 80) . rand();
                $Name = substr($exp[0], 0, 80);
                
                $customer_data = array(
                    'email' => $appleEmailId,
                    'firstname' => $Name,
                    'lastname' => $Name,
                    'phone' => '',
                    'fax' => false,
                    'newsletter' => 1,
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
                    
                    $authentication_data['customer_id'] = (int) $customer_id;
                    $this->model_module_d_social_login->addAuthentication($authentication_data);                    
                    $this->model_module_d_social_login->login($customer_id);                     
                    $this->response->redirect($this->sl_redirect);
                }               
               
            }
            

            if (!empty($userAppleId) && $userInfo['user_apple_id'] != $userAppleId) {
                $message = "MSG_USER_SOCIAL_CREDENTIALS_NOT_MATCHED";
                $this->session->data['error'] = $message;               
                $this->response->redirect('account/register');
            } 
           
            $this->model_module_d_social_login->login($customer_id);            
            $this->response->redirect($this->sl_redirect);
        }
       
        /*for first time to redirect to apple login page*/
        
        $_SESSION['appleSignIn']['state'] = bin2hex(random_bytes(5));
        $url = 'https://appleid.apple.com/auth/authorize?' . http_build_query([
            'response_type' => 'code id_token',
            'response_mode' => 'form_post',
            'client_id' => $apple_client_id,	
            'redirect_uri' => $redirecUri,
            'state' => $_SESSION['appleSignIn']['state'],
            'scope' => 'name email',
        ]);        
        
        $this->response->redirect($url);
        
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