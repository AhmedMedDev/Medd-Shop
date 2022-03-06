<?php

class ControllerModulePriceFilter extends Controller {

	public function index() {

		if (isset($this->request->get['path'])) {

			$parts = explode('_', (string)$this->request->get['path']);

		} else {

			$parts = array();

		}

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		$category_id = end($parts);



		$this->load->model('catalog/category');



		$this->load->model('localisation/currency');



		$category_info = $this->model_catalog_category->getCategory($category_id);



		if ($category_info) {

			$this->load->language('module/price_filter');



			$data['heading_title'] = $this->language->get('heading_title');



			$data['button_filter'] = $this->language->get('button_filter');
			$data['apply_btn'] = $this->language->get('apply_btn');



			$url = '';

			$this->document->addScript('//code.jquery.com/ui/1.11.1/jquery-ui.js');

			$this->document->addScript('catalog/view/javascript/slider/slider.js');

			$this->document->addStyle('catalog/view/javascript/slider/slider.css');

			$this->document->addStyle('//code.jquery.com/ui/1.10.4/themes/flick/jquery-ui.css');



			//[custom code]

			if (isset($this->request->get['price_range'])) {

				$url .= '&price_range=' . $this->request->get['price_range'];

			}

			if (isset($this->request->get['mid'])) {

				$mid = $this->request->get['mid'];

				$temp = explode(",", $mid);

				foreach($temp AS $tik=>$tid){

					if ((is_int($tid) || ctype_digit($tid)) && (int)$tid > 0 )  continue;

					unset($temp[trim($tik)]);

				}

				$mid = implode(",", $temp);

				$url .= '&mid=' .$mid;

			}



			if (isset($this->request->get['sort'])) {

				$url .= '&sort=' . $this->request->get['sort'];

			}



			if (isset($this->request->get['order'])) {

				$url .= '&order=' . $this->request->get['order'];

			}



			if (isset($this->request->get['limit'])) {

				$url .= '&limit=' . $this->request->get['limit'];

			}



			$data['action'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url));



			if (isset($this->request->get['price_range'])) {

				$data['price_range'] = explode('-', $this->request->get['price_range']);

			} else {

				$data['price_range'] = array();

			}



			if (version_compare(VERSION, '2.2.0.0', '<') == true) {

				$pcode = $this->currency->getCode();

			} else {

				$pcode = $this->session->data['currency'];

			}



			if ($this->currency->getSymbolLeft($pcode)) {

				$code = $this->currency->getSymbolLeft($pcode);

				$data['right_code'] = false;

			} else {

				$code = $this->currency->getSymbolRight($pcode);

				$data['right_code'] = true;

			}



			$data['price_code'] = $code;

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
			);

			$prodPrices = $this->model_catalog_product->getProducts($filter_data, false);

			foreach ($prodPrices as $key => $value) {

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    //$price = $this->tax->calculate($value['price'], $value['tax_class_id'], $this->config->get('config_tax'));
                    $price = $value['price'];
                } else {
                    $price = false;
                }

                if ((float)$value['special']) {
                    //$special = $this->tax->calculate($value['special'], $value['tax_class_id'], $this->config->get('config_tax'));
                    $special = $value['special'];
                } else {
                    $special = false;
                }

				$productPrices[] = array(
					'price'       => $price,
					'special'     => $special,
				);
			}


			$maxPrice = 0;

			if(!empty($productPrices)) {

				$minPrice = ($productPrices[0]['special'] != '') ? ($productPrices[0]['special']) : ($productPrices[0]['price']);

				foreach ($productPrices as $key => $value) {

					if($value['price'] != '') {
						$prodPrice = $value['price'];

						if ($value['special'] != '') {

							$prodPrice = $value['special'];
						}
					}

					if( $minPrice > $prodPrice) {
						$minPrice = $prodPrice;

					}

					if( $prodPrice > $maxPrice) {
						$maxPrice = $prodPrice;
					}
				}
			}


			/*$range = explode('-', $this->config->get('price_filter_range'));
			$data['price_range_min'] = $this->currency->convert($range[0], 'XYZ', $pcode);
			$data['price_range_max'] = $this->currency->convert($range[1], 'XYZ' , $pcode);*/

			$range = explode('-', $this->config->get('price_filter_range'));
			$data['price_range_min'] = $this->currency->convert($minPrice, 'XYZ', $pcode);
			$data['price_range_max'] = $this->currency->convert($maxPrice, 'XYZ' , $pcode);

			$data['product_class'] = $this->config->get('price_filter_class');



			if($range[1]<=1000){

				$data['custom_css'] = 'left:0px!important;';

			}

			else if($range[1]>1000 && $range[1]<=10000){

				$data['custom_css'] = 'left:-17px!important;';

			}

			else if($range[1]>10000 && $range[1]<10000000){

				$data['custom_css'] = 'left:-24px!important;';

			}



			if (version_compare(VERSION, '2.2.0.0', '<') == true) {

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/price_filter.tpl')) {

					return $this->load->view($this->config->get('config_template') . '/template/module/price_filter.tpl', $data);

				} else {

					return $this->load->view('default/template/module/price_filter.tpl', $data);

				}

			} else {

				return $this->load->view('module/price_filter', $data);

			}

		}

	}

}
