<?php
class ControllerCommonDashboard extends Controller {
	public function index() {
		$this->load->language('common/dashboard');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_sale'] = $this->language->get('text_sale');
		$data['text_map'] = $this->language->get('text_map');
		$data['text_activity'] = $this->language->get('text_activity');
		$data['text_recent'] = $this->language->get('text_recent');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		// Check install directory exists
		if (is_dir(dirname(DIR_APPLICATION) . '/install')) {
			$data['error_install'] = $this->language->get('error_install');
		} else {
			$data['error_install'] = '';
		}

		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['order'] = $this->load->controller('dashboard/order');
		$data['sale'] = $this->load->controller('dashboard/sale');
		$data['customer'] = $this->load->controller('dashboard/customer');
		$data['online'] = $this->load->controller('dashboard/online');
		$data['map'] = $this->load->controller('dashboard/map');
		$data['chart'] = $this->load->controller('dashboard/chart');
		$data['activity'] = $this->load->controller('dashboard/activity');
		$data['recent'] = $this->load->controller('dashboard/recent');
		$data['footer'] = $this->load->controller('common/footer');
        
        if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		// Run currency update
		if ($this->config->get('config_currency_auto')) {
			$this->load->model('localisation/currency');

			$this->model_localisation_currency->refresh();
		}

		$this->response->setOutput($this->load->view('common/dashboard.tpl', $data));
	}
    
    public function cacheClean() {
		
		$this->load->language('common/dashboard');
		$json = array();	
        
        
        $referer = $_SERVER['HTTP_REFERER'];
        
        $directories = glob(DIR_CACHE);       
        if ($directories) {
            foreach ($directories as $directory) {                
                
                $files = glob($directory . '/*');
                
                foreach ($files as $file) { 
                     if (is_dir($file)) {                       
                        $subFolderFiles = glob($file . '/*');                       
                        foreach ($subFolderFiles as $sfile) {
                            if(is_file($sfile)) {                                
                                  unlink($sfile);
                            }
                        }
                    } 
                    else if(is_file($file)) {                        
                          unlink($file);
                    }                   
                    
                }                
                
            }
        }
        
        
        $directories = glob(DIR_CATALOG);
        $catalogPath =  $directories[0];
        $p = array_filter(explode('/', $catalogPath));
        array_pop($p);
        $vqmodPath = implode('/',$p).'/vqmod';
        $directories = glob($vqmodPath);
       
        
        if ($directories) {
            foreach ($directories as $directory) {                
                $filesToBeClean = array('checked.cache','mods.cache','vqcache');
                $files = glob($directory . '/*');
                
                foreach ($files as $file) { 
                     if (strpos($file, 'checked.cache') !== false || strpos($file, 'mods.cache') !== false || strpos($file, 'vqcache') !== false) {
                        if (is_dir($file)) {                       
                            $subFolderFiles = glob($file . '/*');                       
                            foreach ($subFolderFiles as $sfile) {
                                if(is_file($sfile)) {                                    
                                      unlink($sfile);
                                }
                            }
                        } 
                        else if(is_file($file)) {                            
                              unlink($file);
                        } 
                     }                               
                    
                }               
                
            }
        }
        
        $this->session->data['success'] = $this->language->get('text_cache_clean_success');
        $this->response->redirect($referer);
       		
	}
}