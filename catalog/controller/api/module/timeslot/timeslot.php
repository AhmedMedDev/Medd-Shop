<?php
class ControllerAPIModuleTimeslotTimeslot extends Controller {
    
        
    
	public function index() {
		$this->load->model('slot/timing');
		$data['Intervals'] = $this->model_slot_timing->getTime();  
		
		$this->load->language('module/timeslot');
		$data['text_select_date'] 				= $this->language->get('text_select_date');
		$data['text_select_date_option'] 		= $this->language->get('text_select_date_option');
		$data['text_select_date_time_full'] 	= $this->language->get('text_select_date_time_full');
		$data['text_loading_text'] 				= $this->language->get('text_loading_text');
		$data['text_continue_text'] 			= $this->language->get('text_continue_text');
		$template = "timeslot_collapse";
		//$this->template = 'default/template/module/timeslot/'.$template.'.tpl';
		$data['status'] = 0;
		
		$data['api_checkout_process'] = false;
		if(isset($this->session->data['api_checkout_process']) && $this->session->data['api_checkout_process'] === true){
			$data['api_checkout_process'] = true;
		}
		
		$this->response->setOutput(json_encode($data));
		//$this->response->setOutput($this->load->view($this->template, $data));
	}

	public function save() {
		$time_slot_date =  $_POST['delivery_slot_time'];
		$time_slot_time =  $_POST['get_slot']; 
		$expl = explode("-",$time_slot_time);
		$time = $time_slot_date." ".$expl[0]." - ".$time_slot_date." ".$expl[1];
		/* print_r($expl);
		die(); */
		if($time_slot_date && $time_slot_time){
			if(isset($time) && $time!==""){
				// check slots order count
				$this->load->model('slot/timing');
				$result = $this->model_slot_timing->countSlot($time);
				$json['success'] = 'Slot time has been saved';
				$json['status'] = 1;
			}
		}else{
			$json['error'] = 'Please select your time.';
			$json['status'] = 0;
		}
		$this->response->setOutput(json_encode($json));
	}
        
	public function getDates(){
        
        $sql = "select show_slots,delivery_starts,time_format,date_format FROM " . DB_PREFIX . "slot_setting";
		$query = $this->db->query($sql); 
		if( $query->num_rows>0){
		  
			$time_format = $query->row['time_format'];
			$date_format = $query->row['date_format'];
			$lead = $query->row['delivery_starts'];
		}    
        date_default_timezone_set("Asia/Karachi");   
        $SearchTime = "";
        $SearchTime = $_POST['SearchTime'];
        
        if($SearchTime){
			if($date_format=='dd-mm-yy'){
				$d = explode("-",$SearchTime);
				$year = $d[2];
				$month= $d[1];
				$dat = $d[0];
				$SearchTime = $year."-".$month."-".$dat;
			}
        }
        $start = $_POST['start_id'];
        $last_id = $_POST['last_id'];
        $added_lead_time = date('H:i:s', strtotime("+$lead hour"));
        $lead_time = $SearchTime." ".$added_lead_time;

        $q = $this->db->query("SELECT * from (SELECT slot_timing,to_date_time,from_date_time, one_slot_id,max_no, (SELECT COUNT(*) FROM " . DB_PREFIX . "delivery_time v WHERE times LIKE p.slot_timing ) countSlot FROM " . DB_PREFIX . "one_year_slot p where to_date_time like '%".$SearchTime."%' and one_slot_id >= '".$start."' and Status='ENABLE') a where a.countSlot!=a.max_no");
       
        if($q->num_rows>0){
			if(isset($_SESSION['time_zone'])){
                $zone = "( ".$_SESSION['time_zone']." ) ";
            }else{
                $zone = "";
            }
			$this->load->language('module/timeslot');
			//echo "<br><p class='description'>" . $this->language->get('text_select_time') . " $zone.</p><div class=\"gap\"></div>";
			$data['description'] = $this->language->get('text_select_time');
			//echo "<select class='form-control' name='get_slot' id='get_slots'>";
        
			foreach($q->rows as $val):
				if($last_id>=$val['one_slot_id']){
					$to = explode(" ",$val['to_date_time']);
					$from = explode(" ",$val['from_date_time']);
					$slot_timing = $val['slot_timing'];
				
					if($from[1]>date('H:i:s')){
						if($time_format=='24 ( Military/Continental Time )'){
                             $time_in_12_hour_format_from  = date("H:i:s", strtotime($from[1]));
                             $time_in_12_hour_format_to  = date("H:i:s", strtotime($to[1]));
						}else if($time_format=="12 ( AM/PM and O clock )"){
                            $time_in_12_hour_format_from  = date("g:i:s A", strtotime($from[1]));
                            $time_in_12_hour_format_to  = date("g:i:s A", strtotime($to[1]));
						}
						$times =  $time_in_12_hour_format_from." - ".$time_in_12_hour_format_to;
						$data['times'][] = $times;
                    }else{
						if($time_format=='24 ( Military/Continental Time )'){
                             
                             $time_in_12_hour_format_from  = date("H:i:s", strtotime($from[1]));
                             $time_in_12_hour_format_to  = date("H:i:s", strtotime($to[1]));
                        }else if($time_format=="12 ( AM/PM and O clock )"){
                            $time_in_12_hour_format_from  = date("g:i:s A", strtotime($from[1]));
                            $time_in_12_hour_format_to  = date("g:i:s A", strtotime($to[1]));
                        }   
                        $times =  $time_in_12_hour_format_from." - ".$time_in_12_hour_format_to;
						$data['times'][] = $times;
					}
				}
			endforeach;
		}else{
			echo "false";
		}
		
		$this->response->setOutput(json_encode($data));
	}
}