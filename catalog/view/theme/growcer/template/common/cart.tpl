<div id="cart" class="btn-group btn-block">
	<button type="button" data-toggle="dropdown" class="cart-button">
		<i class="cart-icon">
			<img src="catalog/view/theme/growcer/images/cart-icon.png">
		</i>
		<div class="cart_itm_prc" id="cart">
			<div class="cart_lbl"><?php echo $your_cart_text; ?></div>
			<div class="item-price" id="cart-total"><?php echo $text_items; ?></div>
		</div>
	</button>
	<div style="display:none;" class="dropdown-box" id="dropdown-box">	
            <div id="load_dropdown_data">                        
		<?php if( intval($logged) ){
			?>
			<div class="shop-with-friends-banner overlay-visible clearfix">
				<div class="pull-left frinds"><i class="icn frnd"> 
					<svg height="256px" width="256px" xml:space="preserve" style="enable-background:new 0 0 345.628 345.628;" viewBox="0 0 345.628 345.628" y="0px" x="0px" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
					<path fill="#FFFFFF" d="M319.001,345.628c-3.161,0-6.154-1.885-7.416-4.994l-3.925-9.674c-13.417-33.055-29.202-47.158-52.782-47.158h-30  c-9.103,0-16.931,2.116-23.933,6.469c-3.752,2.334-8.685,1.182-11.018-2.57s-1.182-8.686,2.57-11.018  c9.479-5.893,20.373-8.881,32.379-8.881h30c39.811,0,57.652,32.611,67.609,57.142l3.925,9.675c1.661,4.095-0.312,8.76-4.405,10.421  C321.021,345.438,320.002,345.628,319.001,345.628z M184.875,345.628c-3.161,0-6.154-1.885-7.416-4.994l-3.925-9.674  c-13.415-33.055-29.2-47.158-52.782-47.158H90.751c-23.582,0-39.368,14.104-52.783,47.159l-3.925,9.673  c-1.662,4.095-6.328,6.063-10.421,4.405c-4.094-1.661-6.066-6.327-4.405-10.421l3.925-9.674  c9.956-24.531,27.796-57.143,67.609-57.143h30c39.815,0,57.655,32.611,67.61,57.142l3.925,9.675  c1.661,4.095-0.312,8.76-4.405,10.421C186.895,345.438,185.876,345.628,184.875,345.628z M239.874,252.384  c-24.764,0-44.91-20.147-44.91-44.912c0-20.389,13.656-37.648,32.302-43.11c0.1-0.033,0.2-0.063,0.302-0.093  c3.992-1.135,8.133-1.71,12.307-1.71c22.9,0,41.916,16.941,44.596,39.558c0.21,1.757,0.317,3.543,0.317,5.355  C284.787,232.236,264.64,252.384,239.874,252.384z M224.105,183.249c-7.905,5.165-13.141,14.095-13.141,24.223  c0,15.942,12.969,28.912,28.91,28.912c13.994,0,25.697-9.992,28.35-23.216c-0.579,0.022-1.158,0.033-1.739,0.033  C246.966,213.201,230.269,200.89,224.105,183.249z M239.433,178.562c4.14,11.011,14.721,18.639,27.052,18.639  c0.14,0,0.278-0.001,0.417-0.003C262.699,186.183,251.924,178.403,239.433,178.562z M105.75,252.384  c-24.764,0-44.912-20.147-44.912-44.912c0-24.712,20.062-44.826,44.754-44.912c0.113-0.001,0.227-0.001,0.34-0.001  c23.2,0,42.413,17.39,44.691,40.451c0.062,0.636,0.049,1.265-0.035,1.876c0.049,0.855,0.074,1.719,0.074,2.586  C150.662,232.236,130.514,252.384,105.75,252.384z M90.128,183.153c-7.989,5.149-13.29,14.127-13.29,24.318  c0,15.942,12.97,28.912,28.912,28.912c13.99,0,25.692-9.989,28.347-23.209c-0.518,0.018-1.037,0.026-1.556,0.026  C112.987,213.201,96.265,200.845,90.128,183.153z M105.489,178.562c4.14,11.011,14.721,18.64,27.052,18.64  c0.079,0,0.158,0,0.236-0.001c-4.151-10.886-14.701-18.641-27.027-18.641C105.663,178.561,105.576,178.56,105.489,178.562z   M235.345,148.53c-2.589,0-5.128-1.254-6.669-3.57c-10.763-16.182-23.746-23.718-40.859-23.718h-30.003  c-17.114,0-30.098,7.536-40.861,23.718c-2.448,3.679-7.415,4.677-11.092,2.23c-3.679-2.447-4.677-7.413-2.23-11.092  c13.619-20.475,31.849-30.856,54.183-30.856h29.999c22.337,0,40.566,10.382,54.186,30.856c2.447,3.679,1.448,8.645-2.23,11.092  C238.406,148.097,236.866,148.53,235.345,148.53z M172.813,89.825c-24.763,0-44.91-20.147-44.91-44.912  C127.903,20.147,148.05,0,172.813,0c0.061,0,0.122,0,0.182,0c23.199,0,42.413,17.39,44.692,40.45  c0.063,0.637,0.049,1.266-0.034,1.877c0.049,0.855,0.073,1.719,0.073,2.586C217.726,69.678,197.578,89.825,172.813,89.825z   M157.192,20.594c-7.988,5.15-13.289,14.128-13.289,24.319c0,15.942,12.969,28.912,28.91,28.912c13.992,0,25.694-9.989,28.349-23.21  c-0.519,0.018-1.038,0.026-1.559,0.026C180.05,50.642,163.328,38.285,157.192,20.594z M172.553,16.003  c4.139,11.011,14.719,18.639,27.049,18.639c0.079,0,0.159,0,0.238-0.001C195.699,23.78,185.192,16.038,172.904,16  C172.787,16.001,172.67,16.002,172.553,16.003z"/>
					 
					</svg>
					</i> 
					<?php echo $shop_with_friends; ?>
				</div>
				<div class="pull-right">
					<?php if(isset($share_cart_show_friend_status) && $share_cart_show_friend_status==1){ ?>
						<button class="theme-Btn white hide_friends" onclick="shareCartShowFriendStatus(0)"><?php echo $hide_friends; ?></button>
					<?php }else{ ?>
						<button class="theme-Btn white show_friends" onclick="shareCartShowFriendStatus(1)"><?php echo $show_friends; ?></button>
					<?php } ?>
				</div>
			</div>
			<?php
		}	
		?>
		<div class="clearfix main-warehouse-header">
			<span class="price-well pull-left total_products_count"><?php echo $products_count; ?></span>
			<span class="pull-left u-textTruncate warehouse-name total_products_items_txt"><?php echo $products_text_items; ?></span>
			<span class="pull-right"><span class="delivery-fee"></span>
			<span class="price-well total_products_price"><?php echo $products_total_price; ?></span>
			</span>
		</div>

		<?php if( intval($logged) ){
			?>		
			<div class="cart-overlay clearfix" style="<?=((isset($share_cart_show_friend_status) && $share_cart_show_friend_status==1) ? 'display:block;' : 'display:none;')?>">
				<div class="centered share-cart-link-banner">
                    <a class="themeBtn white" id="cart_link_cpy" onclick="javascript:copyShareCartLink('share_cart_url','cart_link_cpy')"><?php echo $copy_link;?></a>
					<h2 class="heading"><?php echo $text_share_link_to_invite; ?></h2>
                                        <input type="text" class="custom-filed" id="share_cart_url" readonly="readonly" value="<?php echo $data['share_url']; ?>">
				</div>
				<div class="cart-users">

					<ul>
                                            <?php 
                                            foreach( $cart_users as $key=>$val){
                                                ?>
                                                <li class="clearfix">
                                                    <span class="user"><?php echo $val['firstname']; ?></span> 
                                                    <?php
                                                    
                                                        $logged_time = $val['mcult_tracked_time'];
                                                        
                                                        $time1 = strtotime($logged_time);
                                                        $time2 = strtotime($current_user_logged_time);
                                                        
                                                        $diff = ($time2-$time1)/60;         

                                                    if( ($val['customer_id'] == $logged_customer_id || $diff <  1 )){
                                                        ?>  
                                                        <span class="pull-right status online"><?php echo $text_user_online; ?></span>
                                                        <?php
                                                    }else{ ?>
                                                        <span class="pull-right status offline"><?php echo $text_user_offline; ?></span>                                                        
                                                        <?php  
                                                    }
                                                    
                                                    /*$show_delete = false;
                                                    if( $data['cart_owner']==$logged_customer_id  !($val['mcu_is_owner']) && ($val['customer_id'] != $logged_customer_id ) ){
                                                    
                                                    }
*/
                                                    if ( ($val['customer_id'] == $logged_customer_id && !($val['mcu_is_owner']))  ||  ($data['cart_owner']==$logged_customer_id && !($val['mcu_is_owner']))){
                                                        ?>
                                                        <span class="delete"><a class="close" href="<?php echo $data['delet_url'].'&cart_id='.$val['mc_cart_id'].'&user_id='.$val['customer_id'];?>">
                                                        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="612px" height="612px" viewBox="0 0 612 612" style="enable-background:new 0 0 612 612;" xml:space="preserve">
                                                        <g>
                                                        <g id="cross">
                                                        <g>
                                                        <polygon points="612,36.004 576.521,0.603 306,270.608 35.478,0.603 0,36.004 270.522,306.011 0,575.997 35.478,611.397 
                                                        306,341.411 576.521,611.397 612,575.997 341.459,306.011 			"/>
                                                        </g>
                                                        </g>
                                                        </g>
                                                        </svg>
                                                        </a></span>
                                                        <?php
                                                    } ?>
                                                </li>
                                                <?php
                                            }
                                            ?>
					</ul>
				</div>
			</div>		
			<?php
		}	
		?>
		
		<ul>
		<?php if ($products || $vouchers) { ?>
		<li>
		  <table class="tbl-normal table-striped">
			<?php foreach ($products as $product) { ?>
			<tr>
			  <td class="text-center">
				<div class="image-thumb-47">
				 <a href="<?php echo $product['href']; ?>">
					<?php if(isset($product['thumb']) && $product['thumb']!=''){ ?>
						<img src="<?php echo $product['thumb']; ?>" class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
					<?php }else{ ?>
						<img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"/>
					<?php } ?>
				  </a>
				</div>
			  </td>
			  <td class="pro-mame"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
				<?php if ($product['option']) { ?>
				<?php foreach ($product['option'] as $option) { ?>
				<br />
				- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
				<?php } ?>
				<?php } ?>
				<?php if ($product['recurring']) { ?>
				<br />
				- <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
				<?php } ?>
				<span class="added_by"><?php echo $product['firstname']; ?></span>
			  </td>
			  <td class="text-right">x <?php echo $product['quantity']; ?></td>
			  <td class="text-right"><?php echo $product['total']; ?></td>
			  <td class="text-center">
					<div class="btn-action">
						<button type="button" onclick="cart.remove('<?php echo $product['mcp_id']; ?>');" title="<?php echo $button_remove; ?>" class="action"><i class="icon">
                        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="482.428px" height="482.429px" viewBox="0 0 482.428 482.429" style="enable-background:new 0 0 482.428 482.429;" xml:space="preserve">
                          <g>
                            <g>
                              <path d="M381.163,57.799h-75.094C302.323,25.316,274.686,0,241.214,0c-33.471,0-61.104,25.315-64.85,57.799h-75.098
			c-30.39,0-55.111,24.728-55.111,55.117v2.828c0,23.223,14.46,43.1,34.83,51.199v260.369c0,30.39,24.724,55.117,55.112,55.117
			h210.236c30.389,0,55.111-24.729,55.111-55.117V166.944c20.369-8.1,34.83-27.977,34.83-51.199v-2.828
			C436.274,82.527,411.551,57.799,381.163,57.799z M241.214,26.139c19.037,0,34.927,13.645,38.443,31.66h-76.879
			C206.293,39.783,222.184,26.139,241.214,26.139z M375.305,427.312c0,15.978-13,28.979-28.973,28.979H136.096
			c-15.973,0-28.973-13.002-28.973-28.979V170.861h268.182V427.312z M410.135,115.744c0,15.978-13,28.979-28.973,28.979H101.266
			c-15.973,0-28.973-13.001-28.973-28.979v-2.828c0-15.978,13-28.979,28.973-28.979h279.897c15.973,0,28.973,13.001,28.973,28.979
			V115.744z"/>
                              <path d="M171.144,422.863c7.218,0,13.069-5.853,13.069-13.068V262.641c0-7.216-5.852-13.07-13.069-13.07
			c-7.217,0-13.069,5.854-13.069,13.07v147.154C158.074,417.012,163.926,422.863,171.144,422.863z"/>
                              <path d="M241.214,422.863c7.218,0,13.07-5.853,13.07-13.068V262.641c0-7.216-5.854-13.07-13.07-13.07
			c-7.217,0-13.069,5.854-13.069,13.07v147.154C228.145,417.012,233.996,422.863,241.214,422.863z"/>
                              <path d="M311.284,422.863c7.217,0,13.068-5.853,13.068-13.068V262.641c0-7.216-5.852-13.07-13.068-13.07
			c-7.219,0-13.07,5.854-13.07,13.07v147.154C298.213,417.012,304.067,422.863,311.284,422.863z"/>
                            </g>
                          </g>
                        </svg>
                        </i></button>
					</div>
			  </td>
			</tr>
			<?php } ?>
			<?php foreach ($vouchers as $voucher) { ?>
			<tr>
			  <td class="text-center"></td>
			  <td class="text-left"><?php echo $voucher['description']; ?></td>
			  <td class="text-right">x&nbsp;1</td>
			  <td class="text-right"><?php echo $voucher['amount']; ?></td>
			  <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
			</tr>
			<?php } ?>
		  </table>
		</li>
		<li>
		  <div>
			<table class="tbl-normal table-bordered">
			  <?php foreach ($totals as $total) { ?>
			  <tr>
				<td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
				<td class="text-right"><?php echo $total['text']; ?></td>
			  </tr>
			  <?php } ?>
			</table>
			<div class="gap"> </div>
			<div class="pull-right">
				<button type="button" class="themeBtn medium" onclick="window.location.href='<?php echo $cart;?>'"><span class="txt"><?php echo $text_cart; ?></span> <i class="cartIcon">
					  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 459.529 459.529" style="enable-background:new 0 0 459.529 459.529;" xml:space="preserve">
						<g>
						  <path d="M17,55.231h48.733l69.417,251.033c1.983,7.367,8.783,12.467,16.433,12.467h213.35c6.8,0,12.75-3.967,15.583-10.2
																			l77.633-178.5c2.267-5.383,1.7-11.333-1.417-16.15c-3.117-4.817-8.5-7.65-14.167-7.65H206.833c-9.35,0-17,7.65-17,17
																			s7.65,17,17,17H416.5l-62.9,144.5H164.333L94.917,33.698c-1.983-7.367-8.783-12.467-16.433-12.467H17c-9.35,0-17,7.65-17,17
																			S7.65,55.231,17,55.231z"/>
						  <path d="M135.433,438.298c21.25,0,38.533-17.283,38.533-38.533s-17.283-38.533-38.533-38.533S96.9,378.514,96.9,399.764
																			S114.183,438.298,135.433,438.298z"/>
						  <path d="M376.267,438.298c0.85,0,1.983,0,2.833,0c10.2-0.85,19.55-5.383,26.35-13.317c6.8-7.65,9.917-17.567,9.35-28.05
																			c-1.417-20.967-19.833-37.117-41.083-35.7c-21.25,1.417-37.117,20.117-35.7,41.083
																			C339.433,422.431,356.15,438.298,376.267,438.298z"/>
						</g>
					  </svg>
					  </i> 
				</button>
				<button type="button" class="themeBtn medium" onclick="window.location.href='<?php echo $checkout; ?>';"><span class="txt"><?php echo $text_checkout; ?></span> <i class="cartIcon">
					  <svg xml:space="preserve" style="enable-background:new 0 0 508 508;" viewBox="0 0 508 508" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
						<g>
						  <g>
							<g>
							  <path d="M381,390.368c-11,0-19,8-19,19v19H38v-232h51c11,0,19-8,19-19s-8-19-19-19H19c-11,0-19,8-19,19
			v270c0,11,8,19,19,19h362c11,0,19-8,19-19v-38C400,398.368,392,390.368,381,390.368z"/>
							  <path d="M503,187.368l-140-140c-13-13-32-2-32,14v62c-73,3-131,27-172,68c-63,63-63,146-63,149
			c0,10,8,19,19,19c7,0,13-3,16-9c36-64,131-74,184-74h16v64c0,16,20,26,32,14l140-140c4-4,5-9,5-14S507,191.368,503,187.368z
			 M369,294.368v-35c0-10-7-18-17-19c-1,0-15-2-37-2c-45,0-116,7-169,42c8-20,20-42,40-62c37-37,93-57,164-57c11,0,19-8,19-19v-35
			l93,93L369,294.368z"/>
							</g>
						  </g>
						</g>
					  </svg>
					  </i> 
				</button>
			</div>			
		  </div>
		</li>
		<?php 
		}else{	?>
		<li>
			<p><?php echo $text_empty; ?></p>
		</li>
		<?php }	?>
		</ul>
            </div>                
	</div>
</div>
<script type="text/javascript">
		<?php if( intval($logged) ){    ?>		    
                    var current_user_logged = true;
                <?php }else{ ?>
                    var current_user_logged = false;
                <?php } ?>
</script>