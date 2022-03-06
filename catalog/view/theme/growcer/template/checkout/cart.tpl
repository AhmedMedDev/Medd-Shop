<?php echo $header; ?>
 
<div id="body" >
	
	<?php if (isset($api_checkout_process) && ($api_checkout_process !== true)) { ?>
	<div class="breadcrumb">
		<div class="fix-container">
			<ul>
				<?php 
					$iteration 	 = 1;
					$bread_count = count($breadcrumbs); 
					foreach ($breadcrumbs as $breadcrumb) { 
						if($iteration<$bread_count){ ?>
						<li>
							<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
						</li>
						<?php }else{ ?>
						<li>
							<?php echo $breadcrumb['text']; ?>
						</li>
						<?php }
						$iteration++;
					} 
				?>
			</ul>
		</div>
	</div>
	<?php } ?>
	
	<?php if ($attention) { ?>
		<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
			<button type="button" class="close" data-dismiss="alert"></button>
		</div>
		<div class="alert-after"></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert"></button>
		</div>
		<div class="alert-after"></div>
	<?php } ?>
	<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert"></button>
		</div>
		<div class="alert-after"></div>
	<?php } ?>
	
	<div class="main-area">
		<div class="fix-container">
			<div class="row">
				<div class="col-md-9 column">
					<div class="gap"></div>
					<div class="gap"></div>
					<div id="cart_items_container">
						<div class="heading">
							<?php echo $heading_title; ?>
							<?php if ($weight) { ?>
								&nbsp;(<?php echo $weight; ?>)
							<?php } ?>	
						</div>
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
							<div class="cart-listing">
								<ul>
                                    <?php 
										$product_cnt = 0; 
										foreach ($products as $product) { 
											$product_cnt++;
										?>
										<li>
											<div class="productBox">
												<div class="imgBlock">
													<div class="productImg">						
														<a href="<?php echo $product['href']; ?>">
                                                            <?php if(isset($product['thumb']) && $product['thumb']!=''){ ?>
																<img src="<?php echo $product['thumb']; ?>" class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
																<?php }else{ ?>
																<img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"/>
															<?php } ?>
														</a>
														
													</div>
												</div>
												<div class="desc-wrap">
													<h2 class="title-name">
														<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
													</h2>
                                                    <div class="weight">
														<?php if (!$product['stock']) { ?>
															<span class="text-danger red-alert">***</span>
														<?php } ?>
														
														<?php if ($product['option']) { ?>
															<?php foreach ($product['option'] as $option) { ?>
																<br />
																<small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
															<?php } ?>
														<?php } ?>
														
														<?php if ($product['reward']) { ?>
															<br />
															<small><?php echo $product['reward']; ?></small>
														<?php } ?>
														
														<?php if ($product['recurring']) { ?>
															<br />
															<span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
														<?php } ?>
													</div>
                                                    <?php if(isset($product['model']) && $product['model']!=''){ ?>
														<div class="weight">
															<?php echo $column_model; ?>: <?php echo $product['model']; ?>
														</div>
													<?php } ?>
                                                    <div class="weight">
														<?php echo $column_price; ?>: <?php echo $product['price']; ?>
													</div>
													
													<div class="quantity"><?php echo $column_quantity; ?>:
														<ul>
                                                            <li id="lessqty_<?php echo $product_cnt; ?>" class="lessqty minus qty-but" onclick="decrement_quantity(<?php echo $product_cnt; ?>)">-</li>
                                                            <li class="value qty-field-value">
																<input id="qty-field_<?php echo $product_cnt; ?>" type="text" name="quantity[<?php echo $product['product_id'];?>][<?php echo $product['mcp_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="2" id="input-quantity" class="form-control" />
															</li>
                                                            <li id="moreqty_<?php echo $product_cnt; ?>" class="moreqty qty-but plus" onclick="increment_quantity(<?php echo $product_cnt; ?>)">+</li>
														</ul>
														<button type="submit" title="<?php echo $button_update; ?>" class="themeBtn medium"><?php echo $button_update; ?></button>						
													</div>
													
												</div>
												<div class="price-btn-wrap">
													<div class="priceblock"> 
														<span class="current-price"><?php echo $product['total']; ?></span> 
													</div>
													<div class="btn-action"> 
														<a href="javascript:void(0)" class="actionButton action" title="<?php echo $button_remove; ?>" onclick="cart.remove('<?php echo $product['mcp_id']; ?>');"><i class="icon">
															<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
															width="482.428px" height="482.429px" viewBox="0 0 482.428 482.429" style="enable-background:new 0 0 482.428 482.429;"
															xml:space="preserve">
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
														</i> 
														</a> 
														<a href="javascript:void(0)" onclick="wishlist.add('<?php echo $product['product_id']; ?>');" class="action"  title="<?php echo $button_wishlist; ?>">
															<i class="icon">
																<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
																width="369.486px" height="369.486px" viewBox="0 0 369.486 369.486" style="enable-background:new 0 0 369.486 369.486;"
																xml:space="preserve">
																	<g>
																		<g>
																			<path d="M184.743,357.351c-3.478,0-6.798-1.449-9.164-3.998l-147.67-159.16c-0.038-0.041-0.076-0.082-0.113-0.123
																			C9.871,174.223,0,147.921,0,120.008c0-27.914,9.871-54.215,27.796-74.061l2.244-2.484c18.246-20.201,42.608-31.327,68.599-31.327
																			s50.354,11.126,68.601,31.328l17.503,19.38l17.503-19.379c18.246-20.202,42.608-31.328,68.6-31.328s50.354,11.126,68.601,31.329
																			l2.241,2.478c17.928,19.851,27.799,46.152,27.799,74.065s-9.872,54.215-27.796,74.061c-0.037,0.043-0.075,0.084-0.113,0.125
																			l-147.671,159.16C191.541,355.901,188.221,357.351,184.743,357.351z M46.295,177.252l138.448,149.219l138.448-149.22
																			c28.485-31.603,28.467-82.97-0.055-114.549l-2.239-2.478c-13.449-14.891-31.224-23.09-50.051-23.09
																			c-18.828,0-36.603,8.199-50.048,23.085L194.02,89.869c-2.369,2.624-5.74,4.121-9.275,4.121s-6.906-1.497-9.276-4.121
																			l-26.779-29.648c-13.446-14.887-31.22-23.086-50.048-23.086S62.039,45.333,48.594,60.22l-2.244,2.484
																			C17.828,94.283,17.809,145.65,46.295,177.252z"/>
																		</g>
																	</g>
																</svg>
															</i> </a> </div>
												</div>
											</div>
										</li>
									<?php } ?>
								</ul>
							</div>
						</form>
					</div>
					
					<div>
						<?php /*work in progress*/
							if(is_array($vouchers) && count($vouchers)>0){
							?>
							<ul>
								<?php foreach ($vouchers as $vouchers) { ?>
									<li>
										<div class="row">
											<div class="col-md-12 column">
												<div class="row">
													<div class="col-md-9 column">
														<h2 class="title-name">
															<?php echo $vouchers['description']; ?>
														</h2>			
													</div>
													<div class="col-md-3 column">
														<div class="priceblock"> 
															<span class="current-price"><?php echo $vouchers['amount']; ?></span> 
														</div>
														<div class="btn-action"> 
															<a onclick="voucher.remove('<?php echo $vouchers['key']; ?>');" title="<?php echo $button_remove; ?>" class="actionButton action" href="javascript:void(0)"><i class="icon">
																<svg xml:space="preserve" style="enable-background:new 0 0 482.428 482.429;" viewBox="0 0 482.428 482.429" height="482.429px" width="482.428px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
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
															</i> 
															</a> 
														</div>
													</div>
												</div>
											</div>
										</div>
									</li>
								<?php } ?>
							</ul>
						<?php } ?>
					</div>
					
					<?php if ($coupon || $voucher || $reward || $shipping) { ?>
						<div class="heading">
							<?php echo $text_next; ?>
							<span><?php echo $text_next_choice; ?></span> 
						</div>
						<div class="cart-tabs">
							<ul class="tabs">			  
								<?php if($coupon){ ?>
									<li><a href="<?php echo $current_page_url ?>#tab1" class="ripple"><?php echo $entry_coupon; ?></a></li>
								<?php } ?>
								<?php if($voucher){ ?>
									<li><a href="<?php echo $current_page_url ?>#tab2" class="ripple"><?php echo $entry_voucher; ?></a></li>
								<?php } ?>
								<?php if($reward){ ?>
									<li><a href="<?php echo $current_page_url ?>#tab3" class="ripple"><?php echo $entry_reward; ?></a></li>
								<?php } ?>
								<?php if($shipping){ ?>
									<li><a href="<?php echo $current_page_url ?>#tab4" class="ripple"><?php echo $entry_shipping; ?></a></li>
								<?php } ?>
							</ul>
							<?php if($coupon){ ?>
								<div class="tab_content" id="tab1">
									<?php echo $coupon; ?>
								</div>
							<?php } ?>
							<?php if($voucher){ ?>
								<div class="tab_content" id="tab2">
									<?php echo $voucher; ?>
								</div>
							<?php } ?>
							<?php if($reward){ ?>
								<div class="tab_content" id="tab3">
									<?php echo $reward; ?>
								</div>
							<?php } ?>
							<?php if($shipping){ ?>
								<div class="tab_content" id="tab4">
									<?php echo $shipping; ?>
								</div>
							<?php } ?>
						</div>
					<?php } ?>
					<div class="gap"></div>
				</div>
				<div class="col-md-3">
					<div class="right-wrap">
						<div class="backto clearfix"> 
							<a tabindex="0" class="addtocart-btn green small" href="<?php echo $continue; ?>"><?php echo $button_shopping; ?><span class="cartIcon">
								<svg xml:space="preserve" style="enable-background:new 0 0 459.529 459.529;" viewBox="0 0 459.529 459.529" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
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
							</span> </a> </div>
							<div class="place-order-wraper clearfix" id="checkout_summary">
								<div class="heading"><?php echo $text_cart_order_heading; ?></div>
								<div class="order-summary ">
									<h3><?php echo $text_cart_order_summary; ?></h3>				  
									<ul>
										<?php 
											$total_count = count($totals);
											$iteration	 = 0;
											$li_class	 = '';
											foreach ($totals as $total) { 
												$iteration++;
												if($total_count-$iteration==0){
													$li_class = ' class="netpay"';
												}
											?>
											<li <?php echo $li_class; ?>>
												<span class="pull_left"><?php echo $total['title']; ?>:</span>
												<span class="pull_right"><?php echo $total['text']; ?></span>
											</li>
											<?php 
											} 
										?>
									</ul>
									
									<div class="padd15 checkout-btn">
										<p><?php echo $text_cart_order_note; ?></p>
										<a href="<?php echo $checkout; ?>" class="addtocart-btn green"><?php echo $button_checkout; ?></a>
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12"> </div>
			</div>
		</div>
		<!--slider-->
		
		<section class="comn-padd">
			<div class="fix-container">
				<?php echo $content_bottom; ?>
			</div>
		</section>
		
		<!--slider/--> 
	</div> <!--end of main area-->
</div>
<style>
	.right-wrap-abs{position: absolute;}
</style>
<script type="text/javascript">
	// initializing jQueryTab plugin 
	$(document).ready(function () {
		
		jQuery.jQueryTab({
			responsive:true,							// enable accordian on smaller screens
			collapsible:false,							// allow all accordions to collapse 
			useCookie: false,							// remember last active tab using cookie
			openOnhover: false,						// open tab on hover
			initialTab: 1,								// tab to open initially; start count at 1 not 0
		});
		
        function runCartAjax() {
            $.ajax({
                url: 'index.php?route=checkout/checkout/getUpdatedOrderSummary',
                dataType: 'html',
                success: function(html) {                        
					$('#checkout_summary > .order-summary').html(html);
				},
                error: function(xhr, ajaxOptions, thrownError) {
					/*    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);  */
				}
			});
		}
		
		function updateCartListingAjax(){
			$.ajax({
                url: 'index.php?route=checkout/cart/cart_listing_update',
                dataType: 'html',
                success: function(html) {
					$('#cart_items_container').html(html);
				},
                error: function(xhr, ajaxOptions, thrownError) {
                    /*  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/ 
				}
			});  
		} 
		
        if(current_user_logged){
            setInterval(runCartAjax, 10000);
            setInterval(updateCartListingAjax, 30000);
		}        
		
	});
	function increment_quantity(val){ 
		var current_quantity = jQuery('#qty-field_'+val).val();
		if(isNaN(current_quantity) || current_quantity<=0){ 
			jQuery('#qty-field_'+val).val(1);
			}else{
			jQuery('#qty-field_'+val).val(parseInt(current_quantity) + parseInt(1));
		}
	}
	
	function decrement_quantity(val){
		var current_quantity = jQuery('#qty-field_'+val).val();
		if(isNaN(current_quantity)  || current_quantity<=0){ 
			jQuery('#qty-field_'+val).val(1);
			}else{
			if (current_quantity > 1){
				jQuery('#qty-field_'+val).val(parseInt(current_quantity)-parseInt(1));
			}
		}
	}
	var screenWidth = $( window ).width();
	$(window).resize(function(){
		screenWidth =  $( window ).width();
	});
	$(window).scroll(function(){
		if(screenWidth>768){
			var sticky = $('.right-wrap'),
			scroll = $(window).scrollTop();
			stickyHeight = sticky.height();
			var eTop = $('footer').offset().top; //get the offset top of the element
			eTop = eTop - scroll-10;
			if(eTop<=stickyHeight){
				if(sticky.hasClass('sticky')){
					sticky.addClass('right-wrap-abs').removeClass('sticky');
					sticky.css({'top':($('#body').height()-stickyHeight-55)+"px"});
				}
				}else{
				if(sticky.hasClass('right-wrap-abs')){
					sticky.removeClass('right-wrap-abs');
					sticky.css({'top':'0px'});
				}
				if (scroll >= 253){
					sticky.addClass('sticky');
					}else{
					sticky.removeClass('sticky');
				}
			}
		}
	});
</script>
<div id="pop_up_main_container"></div>
 
<?php echo $footer; ?>
 