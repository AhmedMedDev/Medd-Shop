<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['text_footer'] = $this->language->get('text_footer');

		if ($this->user->isLogged() && isset($this->request->get['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
			$data['text_version'] = sprintf($this->language->get('text_version'), VERSION);
			$data['text_product_version'] = sprintf($this->language->get('text_product_version'), CONF_PRODUCT_VERSION);
		} else {
			$data['text_version'] = '';
			$data['text_product_version'] = '';
		}

		return $this->load->view('common/footer.tpl', $data);
	}
}
