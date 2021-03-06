<?php 
$_['d_social_login'] = array(
    "base_url" => "", 
    
    "providers" => array( 
	    "Facebook" => array( 
        "enabled" => true,
        "keys"    => array ( "id" => "", "secret" => "" ),
        "scope" => 'public_profile, email', 
        "id"  => 'facebook',
        "trustForwarded" => false,
        "sort_order" => 1,
        "icon" => 'dsl-facebook',
        "background_color" => '#4864b4',
        "background_color_active" => '#3a5192',
      ),

      "Google" => array( 
        "enabled" => true,
        "keys"    => array( "id" => "", "secret" => "" ), 
        "scope" => 'https://www.googleapis.com/auth/userinfo.email',
        "id"  => 'google',
        "sort_order" => 2,
        "icon" => 'dsl-google-plus',
        "background_color" => '#dd4b39',
        "background_color_active" => '#be3e2e',
      ),

    
      "Twitter" => array ( 
        "enabled" => true,
        "keys"    => array( "key" => "", "secret" => "" ),
        "id"  => 'twitter',
        "includeEmail" => true,
        "sort_order" => 3,
        "icon" => 'dsl-twitter',
        "background_color" => '#00ceff',
        "background_color_active" => '#03b3dd',
      ),

      // windows live
      "Live" => array ( 
        "enabled" => true,
        "keys"    => array( "id" => "", "secret" => "" ),
        "scope" => 'wl.emails',
        "id"  => 'live',
        "sort_order" => 4,
        "icon" => 'dsl-windows',
        "background_color" => '#2672ec',
        "background_color_active" => '#205dbf',
      ),      
    ),
    "debug_mode" => false,
    //system/logs/d_social_login.txt
    "debug_file" => "d_social_login.txt", 

    'fields' => array('firstname' => array('id' => 'firstname', 'enabled' => true, 'sort_order' => 1, 'type' => 'text'),
                      'lastname' => array('id' => 'lastname', 'enabled' => true, 'sort_order' => 2, 'type' => 'text'),
                      'phone' => array('id' => 'phone', 'enabled' => true, 'sort_order' => 3, 'type' => 'text', 'mask' => '9(999) 9999-9999?9'),
                      'address_1' => array('id' => 'address_1', 'enabled' => true, 'sort_order' => 4, 'type' => 'text'),
                      'address_2' => array('id' => 'address_2', 'enabled' => true, 'sort_order' => 5, 'type' => 'text'),
                      'city' => array('id' => 'city', 'enabled' => true, 'sort_order' => 6, 'type' => 'text'),
                      'postcode' => array('id' => 'postcode', 'enabled' => true, 'sort_order' => 7, 'type' => 'text'),
                      'country_id' => array('id' => 'country_id', 'enabled' => true, 'sort_order' => 8, 'type' => 'select'),
                      'zone_id' => array('id' => 'zone_id', 'enabled' => true, 'sort_order' => 9, 'type' => 'select'),
                      'company' => array('id' => 'company', 'enabled' => true, 'sort_order' => 10, 'type' => 'text'),
                     // 'company_id' => array('id' => 'company_id', 'enabled' => true, 'sort_order' => 11, 'type' => 'text'),
                     // 'tax_id' => array('id' => 'tax_id', 'enabled' => true, 'sort_order' => 12, 'type' => 'text'),
                      'password' => array('id' => 'password', 'enabled' => true, 'sort_order' => 13, 'type' => 'password'),
                      'confirm' => array('id' => 'confirm', 'enabled' => true, 'sort_order' => 14, 'type' => 'password')
    ),
    

    "size" => "icon",
    "return_page_url" => "",
    "config" => "d_social_login",
    "customer_group" => 1,
    "newsletter" => 1,
    "iframe" => 1,

    //image/catalog/d_social_login/bg.png
    "background_img" => "catalog/d_social_login/bg.png",
  );

?>