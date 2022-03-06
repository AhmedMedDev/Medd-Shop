<?php
class ControllerAPICommonPopular extends Controller
{
    public function index($setting = [])
    {

        $this->load->model('extension/module');
        if (isset($this->request->post['currency'])) {
            $currentCurrency = $this->currency->getCurrentCurrency($this->request->post['currency']);
        } else {
            $currentCurrency = $this->currency->getCurrentCurrency($this->currency->getCurrency());
        }
        /*	Needs to update this id later on as per new products module	*/
        $anylist_new_products_module_id = ((int)$this->config->get('anylist_new_products_module_id')!=0) ? (int)$this->config->get('anylist_new_products_module_id') : 36;

        $anylist_modules = $this->model_extension_module->getModule($anylist_new_products_module_id);//anylist module for new product

        if (is_array($anylist_modules) && !empty($anylist_modules)) {
            $data['new_products'] = $this->load->controller('api/common/anylist', $anylist_modules);
        }

        $this->load->language('module/popular');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');

        $data['products'] = array();

        $product_data = array();

        if (isset($setting['limit']) && $setting['limit']!='') {
            $setting['limit'] = $setting['limit'];
        } else {
            $setting['limit'] = 4;
        }


        $query = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY p.viewed DESC LIMIT " . (int)$setting['limit']);



        foreach ($query->rows as $result) {
            $product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
        }

        $results = $product_data;
        $new_counter = 0;

        if ($results) {
            foreach ($results as $result) {
                if ($result['image']) {
                    $new_counter++;
                    if ($new_counter == 1) {
                        $image = $this->model_tool_image->resize($result['image'], 600, 600);
                    } else {
                        $image = $this->model_tool_image->resize($result['image'], 600, 600);
                    }
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', 600, 600);
                    //$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                }


                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'));
                } else {
                    $price = false;
                }

                if ((float)$result['special']) {
                    $special = $this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = (float)$result['special'] ? $result['special'] : $result['price'];
                } else {
                    $tax = false;
                }


                if ($this->config->get('config_review_status')) {
                    $rating = $result['rating'];
                } else {
                    $rating = false;
                }

                $data['products'][] = array(
                    'product_id'   => $result['product_id'],
                    'thumb'   	   => $image,
                    'name'         => $result['name'],
                    'description'  => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                    'currency'    => $currentCurrency,
                    'price'   	   => $price,
                    'special' 	   => $special,
                    'tax'          => $tax,
                    'rating'       => $rating,
                    'href'         => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                );
            }

            $data['status'] = 1;

			return $data;
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($data));
        }
    }
}
