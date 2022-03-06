<?php
class ControllerSettingpushnotification extends Controller {
    private $error = array();
    
    public function sendNotification(){
        
        $this->load->language('setting/pushnotification');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/pushnotification');
        $this->load->model('customer/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            
            if (!$this->user->hasPermission('modify', 'setting/pushnotification')) {
				$json['error']['warning'] = $this->language->get('error_permission');
			}
            
            if (isset($this->request->get['page'])) {
                $page = $this->request->get['page'];
            } else {
                $page = 1;
            }
            
            $device_tokens = array();            
            if (!$json) {
                $customer_list = array();
                switch ($this->request->post['to']) {
                
                        case 'customer_all':                            
                            $results = $this->model_customer_customer->getAppCustomers();

                            foreach ($results as $result) {
                                $customer_list[] = $result['customer_id'];
                                $device_tokens[] = $result['device_push_id'];
                            }
                            break;
                        case 'customer':                        
                            if (!empty($this->request->post['customer'])) {
                                foreach ($this->request->post['customer'] as $customer_id) {
                                    $customer_info = $this->model_customer_customer->getAppCustomer($customer_id);                                    
                                    if ($customer_info) {
                                        $customer_list[] = $customer_id;
                                        $device_tokens[] = $customer_info['device_push_id'];
                                    }
                                }
                            }
                            break;
                }                
              
                if ($device_tokens) {          
                   
                    $this->load->model('user/api');        
                    $api_id  = $this->config->get('config_api_id');
                    $apiData = $this->model_user_api->getApi($api_id);
                    $api_access_key =  $apiData['api_access_key'];
        
                    $data = array();
                    $notificationData = $this->request->post['notification_description'];
                    foreach($notificationData as $notData){
                        $data['title']       = $notData['title'];
                        $data['message']     = $notData['content'];
                        $data['launch_url']  = $notData['launch_url'];
                    }
                    $data['icon'] = $this->request->post['notification_icon_image'];
                    $data['type'] = $this->request->post['type'];
                    $notificationResponse = $this->sendNotificationToUsers($device_tokens,$data,$api_access_key);
                    $notification_id = $this->model_setting_pushnotification->saveNotification($data);
                   
                    foreach($customer_list as $customer){                        
                        $notified_user_data = array('notification_id' => $notification_id, 'customer_id' =>  $customer, 'read_status' => 0);
                        $this->model_setting_pushnotification->add_notify_customer($notified_user_data);
                    }
                }                
                   
                $this->session->data['success'] = $this->language->get('text_success');
            
            }
            
			$this->response->redirect($this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] , 'SSL'));
		}
		$this->getForm();        
    }
    
    public function sendNotificationToUsers($registrationIds,$data,$api_access_key){            
           
            // prep the bundle
            $msg = array
            (
                'message' 	 => $data['message'],
                'title'		 => $data['title'],                             
                'type'       => $data['type'],                
                'vibrate'	 => 1,
                'sound'		 => 1,                
                /*'smallIcon'	=> 'small_icon'*/
            );
            $fields = array
            (
                'registration_ids' 	=> $registrationIds,
                'data'			    => $msg
            );
             
            $headers = array
            (
                'Authorization: key=' . $api_access_key,
                'Content-Type: application/json'
            );
           
            $ch = curl_init();
            curl_setopt( $ch,CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send' );
            curl_setopt( $ch,CURLOPT_POST, true );
            curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );
            curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );
            curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );
            curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );
            $result = curl_exec($ch ); 
            curl_close( $ch ); 
            
    }
    
    protected function getForm() {
    
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_default']  = $this->language->get('text_default');
		
    	$data['text_form']   = !isset($this->request->get['footersection_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		
		$data['entry_title']   = $this->language->get('entry_title');
		$data['entry_heading'] = $this->language->get('entry_heading');
		$data['entry_content'] = $this->language->get('entry_content');
		$data['entry_url']     = $this->language->get('entry_url');
        
		$data['notification_icon'] = $this->language->get('notification_icon');		
		$data['entry_sort_order']  = $this->language->get('entry_sort_order');		
		$data['text_select']       = $this->language->get('text_select');
		$data['entry_link']        = $this->language->get('entry_link');
		$data['entry_select_heading'] = $this->language->get('entry_select_heading');
		
        $data['entry_to']          = $this->language->get('entry_to');
        $data['text_customer_all'] = $this->language->get('text_customer_all');
		$data['text_customer']     = $this->language->get('text_customer');        
		$data['entry_customer']    = $this->language->get('entry_customer');
		
		$data['button_save']   = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
    	
		$data['tab_general']   = $this->language->get('tab_general');    	

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

 		if (isset($this->error['title'])) {            
			$data['error_title'] = $this->error['title'];
		} else {            
			$data['error_title'] = array();
		}
		
	 	if (isset($this->error['content'])) {
			$data['error_content'] = $this->error['content'];
		} else {
			$data['error_content'] = array();
		}
	 	
        if (isset($this->error['launch_url'])) {
			$data['error_launch_url'] = $this->error['launch_url'];
		} else {
			$data['error_launch_url'] = array();
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
        
        $data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/pushnotification/sendnotification', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		
		$data['action'] = $this->url->link('setting/pushnotification/sendnotification', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
		$data['cancel'] = $this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['token'] = $this->session->data['token'];


		$data['notification_description'] = array();		
	
        if (isset($this->request->post['notification_icon_image'])) {
			$data['notification_icon_image'] = $this->request->post['notification_icon_image'];
		} else {
			$data['notification_icon_image'] = $this->config->get('config_image');
		}
        
        $this->load->model('tool/image');

		if (isset($this->request->post['notification_icon_image']) && is_file(DIR_IMAGE . $this->request->post['notification_icon_image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['notification_icon_image'], 100, 100);
		} elseif ($this->config->get('config_image') && is_file(DIR_IMAGE . $this->config->get('config_image'))) {
			$data['thumb'] = $this->model_tool_image->resize($this->config->get('config_image'), 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}
        
        $data['notification_type'] = 'offer'; /* For offer notification*/

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


		$data['header']      = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer']      = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('setting/send_notification_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'setting/pushnotification')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        		
		foreach ($this->request->post['notification_description'] as $language_id => $value) {
            
			if ((utf8_strlen($value['title']) < 3) || (utf8_strlen($value['title']) > 64)) {                
				$this->error['title'][$language_id] = $this->language->get('error_title');				
			}
			if ((utf8_strlen(htmlspecialchars($value['content'])) < 3) || (utf8_strlen(htmlspecialchars($value['content'])) > 64)) {
				$this->error['content'][$language_id] = $this->language->get('error_content');
			}
            /* if ((utf8_strlen($value['launch_url']) < 3) || (utf8_strlen($value['launch_url']) > 64)) {
                 
				$this->error['launch_url'][$language_id] = $this->language->get('error_launch_url');
			} */
		}
       
		if ($this->error && !isset($this->error['warning'])) {            
			$this->error['warning'] = $this->language->get('error_warning');
		}
       
		if (!$this->error) {
            return !$this->error;			
		} else {
			return false;
		}
	}
    
    public function notificationList(){
        
        $this->load->language('setting/pushnotification');
        $this->load->model('setting/pushnotification');
        $this->load->model('customer/customer');
        $this->document->setTitle($this->language->get('heading_title'));
       
       if (isset($this->request->get['filter_title'])) {
			$filter_title = $this->request->get['filter_title'];
		} else {
			$filter_title = null;
		}
       
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'date_added';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
        else{
            $url .= '&sort=' . $sort;
        }
       
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
        else{
            $url .= '&order=' . $order;
        }

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
        
        $data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
        
        $data['send']   = $this->url->link('setting/pushnotification/sendnotification', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('setting/pushnotification/deleteNotification', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        $data['heading_title'] = $this->language->get('heading_title');

		$data['text_list']       = $this->language->get('text_list');
		$data['text_default']    = $this->language->get('text_default');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm']    = $this->language->get('text_confirm');

		$data['column_notification_title'] = $this->language->get('column_notification_title');
		$data['column_content']            = $this->language->get('column_content');
		$data['column_launch_url']         = $this->language->get('column_launch_url');
		$data['column_icon']               = $this->language->get('column_icon');		
		$data['column_date_added']         = $this->language->get('column_date_added');
		$data['column_action']             = $this->language->get('column_action');

		$data['entry_title']      = $this->language->get('entry_title');
		$data['entry_date_added'] = $this->language->get('entry_date_added');

		
		$data['button_send']   = $this->language->get('button_send');
		$data['button_edit']   = $this->language->get('button_edit');
		$data['button_view']   = $this->language->get('button_view');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');


		$data['token'] = $this->session->data['token'];
        
        $filter_data = array(
			'filter_title'             => $filter_title,
			'filter_content'           => $filter_content,
			'filter_date_added'        => $filter_date_added,
			'sort'                     => $sort,
			'order'                    => $order,
			'start'                    => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'                    => $this->config->get('config_limit_admin')
		);

		$notification_total = $this->model_setting_pushnotification->getTotalNotifications($filter_data);      
        
		$results = $this->model_setting_pushnotification->getNotifications($filter_data);
		foreach ($results as $result) {		

			$data['notifications'][] = array(
				'id'          => $result['id'],
				'title'       => $result['title'],
				'content'     => $result['content'],
				'launch_url'  => $result['launch_url'],
				'icon'        => $result['icon'],				
				'type'        => $result['type'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),				
				'view'        => $this->url->link('setting/pushnotification/view/', 'token=' . $this->session->data['token'] . '&notification_id=' . $result['id'] , 'SSL')
			);
		} 
        
        $url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
        
        $sort_url = '&sort=title';
        $date_url = '&sort=date_added';
            
       
        if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

        $data['sort_title']      = $this->url->link('setting/pushnotification/notificationlist', 'token=' . $this->session->data['token'] . $sort_url. $url, 'SSL');
		$data['sort_date_added'] = $this->url->link('setting/pushnotification/notificationlist', 'token=' . $this->session->data['token'] .$date_url. $url, 'SSL');
        
       
        $pagination = new Pagination();
		$pagination->total = $notification_total;
		$pagination->page  = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url   = $this->url->link('setting/pushnotification/notificationlist', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($notification_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($notification_total - $this->config->get('config_limit_admin'))) ? $notification_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $notification_total, ceil($notification_total / $this->config->get('config_limit_admin')));

		$data['filter_title']      = $filter_title;
		$data['filter_date_added'] = $filter_date_added;        

		$data['sort']  = $sort;
		$data['order'] = $order;
        
        if($this->session->data['success']){
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('setting/notification_list.tpl', $data));
    }
    
    public function deleteNotification(){

        $this->load->language('setting/pushnotification');
        $this->load->model('setting/pushnotification');

		$this->document->setTitle($this->language->get('heading_title'));		

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $notification_id) {
				$this->model_setting_pushnotification->deleteNotification($notification_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('setting/pushnotification/notificationlist', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
    }
    
    public function deleteNotificationUser(){
    
        $this->load->language('setting/pushnotification');
        $this->load->model('setting/pushnotification');

		$this->document->setTitle($this->language->get('heading_title'));
		

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $id) {
				$this->model_setting_pushnotification->deleteNotificationUser($id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('setting/pushnotification/view', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    }
    
    protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'setting/pushnotification')) {
			$this->error['warning'] = $this->language->get('error_permission');
        }

		return !$this->error;
	}
    
    public function view(){
    
        if (!isset($this->request->get['notification_id'])) {
            $this->response->redirect($this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] , 'SSL'));
        }
       
        $this->load->language('setting/pushnotification');
        $this->load->model('setting/pushnotification');
        $this->load->model('customer/customer');
        $this->document->setTitle($this->language->get('heading_title'));
        
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
        
        $data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
        $data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_view_title'),
			'href' => $this->url->link('setting/pushnotification/view', 'token=' . $this->session->data['token'] . '&notification_id='.$this->request->get['notification_id'].$url, 'SSL')
		);
        
        $data['cancel'] = $this->url->link('setting/pushnotification/notificationList', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('setting/pushnotification/deleteNotificationUser', 'token=' . $this->session->data['token'] . $url, 'SSL');
        
        $data['heading_title']      = $this->language->get('heading_title');
        $data['heading_view_title'] = $this->language->get('heading_view_title');

		$data['text_list']      = $this->language->get('text_list');
		$data['text_user_list'] = $this->language->get('text_user_list');

		$data['text_default']    = $this->language->get('text_default');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm']    = $this->language->get('text_confirm');

		$data['column_notification_title'] = $this->language->get('column_notification_title');
		$data['column_date_added']         = $this->language->get('column_date_added');		
		$data['column_customer_name']      = $this->language->get('column_customer_name');
		$data['column_read_status']        = $this->language->get('column_read_status');

		$data['entry_title']      = $this->language->get('entry_title');
		$data['entry_date_added'] = $this->language->get('entry_date_added');	
		$data['button_view']      = $this->language->get('button_view');
		$data['button_delete']    = $this->language->get('button_delete');
		

		$data['token'] = $this->session->data['token'];
        
        $sort = 'date_added';
		$order = 'DESC';
        
        $filter_data = array(			
			'notification_id'     => $this->request->get['notification_id'],
			'sort'                => $sort,
			'order'               => $order,
			'start'               => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'               => $this->config->get('config_limit_admin')
		);

		$notification_total_users = $this->model_setting_pushnotification->getTotalNotificationUsers($filter_data);      
        
		$results = $this->model_setting_pushnotification->getNotificationUsers($filter_data);
    
		foreach ($results as $result) {		

			$data['notifications_users'][] = array(
				'id'                => $result['id'],
				'title'             => $result['title'],
				'read_status'       => $result['read_status'],
				'customer_id'       => $result['customer_id'],
				'customer_name'     => $result['customer_name'],				
				'date_added'        => date($this->language->get('date_format_short'), strtotime($result['date_added'])),				
				'customer_detail'   => $this->url->link('customer/customer/edit', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'] , 'SSL')
			);
		} 

        $url = '';     
       
        $pagination = new Pagination();
		$pagination->total = $notification_total_users;
		$pagination->page  = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url   = $this->url->link('setting/pushnotification/view', 'token=' . $this->session->data['token'] . '&notification_id='.$this->request->get['notification_id'].$url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results']    = sprintf($this->language->get('text_pagination'), ($notification_total_users) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($notification_total_users - $this->config->get('config_limit_admin'))) ? $notification_total_users : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $notification_total_users, ceil($notification_total_users / $this->config->get('config_limit_admin')));   
        
        if($this->session->data['success']){
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('setting/notification_users.tpl', $data));
    }
}