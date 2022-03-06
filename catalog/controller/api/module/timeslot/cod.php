<?php
class ControllerModuleTimeslotCod extends Controller {
	public function index() {
            
                $data['text_loading'] = $this->language->get('text_loading');

		$data['button_confirm'] = $this->language->get('button_confirm');

		$data['text_loading'] = $this->language->get('text_loading');

		$data['continue'] = $this->url->link('checkout/success');
                
                
                /// redirected from vqmod xml

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/cod.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/cod.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/cod.tpl', $data);
		}
	}

	public function confirm() {
            
                
                if ($this->session->data['payment_method']['code'] == 'cod') {
			
                        $this->load->model('module/deliveryTime/order');
                        $this->model_module_deliveryTime_order->addDeliveryTime($this->session->data['order_id'],$this->session->data['delivery_time']);
                        $this->model_module_deliveryTime_order->addOrderHistory($this->session->data['order_id'], $this->config->get('cod_order_status_id'));
                       
		}
	}
}