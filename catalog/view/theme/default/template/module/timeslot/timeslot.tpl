<?php echo $header; ?>

<div id="body">
	<?php if ($api_checkout_process !== true) { ?>
	<div class="breadcrumb <?php echo $hide_Data; ?>">
		<div class="fix-container">
			<ul>
				<?php 
					$iteration 	 = 1;
					$bread_count = count($breadcrumbs);
					foreach ($breadcrumbs as $breadcrumb) { 
						if( $iteration < $bread_count){ ?>
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
	<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert"></button>
		</div>
		<div class="alert-after"></div>
	<?php } ?>
	<div class="main-area">
		<div class="fix-container">
			<div class="row">
				<?php echo $content_top; ?>
			</div>
			<div class="row">
				<div class="col-md-9">
					<div class="gap"></div>
					<div class="gap"></div>
					<div class="heading"><?php echo $heading_title; ?></div>
					<div class="verticle-tabs">
						<ul class="tabs">
							<li><a href="javascript:void(0);" for="collapse-checkout-option" class="checkoutTab ripple"><?php echo $text_checkout_option; ?></a></li>
							<?php if (!$logged && $account != 'guest') { ?>
								<li><a href="javascript:void(0);" for="collapse-payment-address" class="checkoutTab ripple"><?php echo $text_checkout_account; ?></a></li>
								<?php }else{  ?>
								<li><a href="javascript:void(0);" for="collapse-payment-address" class="checkoutTab ripple"><?php echo $text_checkout_payment_address; ?></a></li>
							<?php } ?>
							<li><a href="javascript:void(0);" for="collapse-shipping-address" class="checkoutTab ripple"><?php echo $text_checkout_shipping_address; ?></a></li>
							<li><a href="javascript:void(0);" for="collapse-shipping-method" class="checkoutTab ripple"><?php echo $text_checkout_shipping_method; ?></a></li>
							
							<?php if ($shipping_required) { ?>
								<li><a href="javascript:void(0);" for="collapse-timeslot" class="checkoutTab ripple"><?php echo $text_checkout_delivery_time; ?></a></li>
							<?php } ?>
							
							<li><a href="javascript:void(0);" for="collapse-payment-method" class="checkoutTab ripple"><?php echo $text_checkout_payment_method; ?></a></li>
							<li><a href="javascript:void(0);" for="collapse-checkout-confirm" class="checkoutTab ripple"><?php echo $text_checkout_confirm; ?></a></li>
						</ul>
						<div class="tab_content" id="collapse-checkout-option">
							<div class="checkout-content-body">
							</div>
							<div class="gap"></div>
						</div>
						<div class="tab_content" id="collapse-payment-address">
							<div class="checkout-content-body">
							</div>
							<div class="gap"></div>
						</div>
						<div class="tab_content" id="collapse-shipping-address">
							<div class="checkout-content-body">
								
							</div>
							<div class="gap"></div>
						</div>
						
						<div class="tab_content" id="collapse-shipping-method">
							<div class="checkout-content-body">
								
							</div>
							<div class="gap"></div>
						</div>
						
						<?php if ($shipping_required) { ?>
							<div class="tab_content" id="collapse-timeslot">
								<div class="checkout-content-body">
									
								</div>
								<div class="gap"></div>
							</div>
						<?php } ?>
						
						<div class="tab_content" id="collapse-payment-method">
							<div class="checkout-content-body">
								
							</div>
							<div class="gap"></div>
						</div>
						<div class="tab_content" id="collapse-checkout-confirm">
							<div class="checkout-content-body">
								
							</div>
							<div class="gap"></div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="right-wrap">
						
						<?php if ($api_checkout_process !== true) { ?>
							<div class="backto clearfix"> 
								<a tabindex="0" class="addtocart-btn green small <?php echo $hide_Data; ?>" href="<?php echo $continue; ?>"><?php echo $button_shopping; ?>
									<span class="cartIcon">
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
									</span> 
								</a> 
							</div>
						<?php } ?>
						
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
									<p class="order_note"><?php echo $text_cart_order_note; ?></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<?php echo $content_bottom; ?>
			</div>
			<div id="checkout_cart_update"></div>
		</div>
	</div>
</div>
<style>
	.right-wrap-abs{position: absolute;}
</style>
<script type="text/javascript">
	$(document).on('change', 'input[name=\'account\']', function() {
		if ($('#collapse-payment-address').parent().find('.panel-heading .panel-title > *').is('a')) {
			if (this.value == 'register') {
				$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
				} else {
				$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
			}
			} else {
			if (this.value == 'register') {
				$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_account; ?>');
				} else {
				$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_address; ?>');
			}
		}
	});
	
	<?php if (!$logged) { ?>
		$(document).ready(function() {
			$.ajax({
				url: 'index.php?route=checkout/login',
				dataType: 'html',
				success: function(html) {
					checkout_step(0);
					$('#collapse-checkout-option .checkout-content-body').html(html);
					$('a[href=\'<?php echo $current_page_url; ?>#collapse-checkout-option\']').trigger('click');
				},
				beforeSend: function(html){
					$('#collapse-checkout-option .checkout-content-body').html('<p style="text-align: center;"><?php echo $text_loading; ?></p>');
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
		<?php } else { ?>
		$(document).ready(function() {
			$.ajax({
				url: 'index.php?route=checkout/payment_address',
				dataType: 'html',
				success: function(html) {
					checkout_step(1);
					$('#collapse-payment-address .checkout-content-body').html(html);
					$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-address\']').trigger('click');
				},
				beforeSend: function(html){
					$('#collapse-payment-address .checkout-content-body').html('<p style="text-align: center; margin: 10% 0;"><?php echo $text_loading; ?></p>');
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
	<?php } ?>
	
	// Checkout
	$(document).delegate('#button-account', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').val(),
			dataType: 'html',
			beforeSend: function() {
				checkout_step(1);
				$('#button-account').val('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#button-account').val('<?php echo $button_continue; ?>');
			},
			success: function(html) {
				$('.alert, .text-danger').remove();
				
				$('#collapse-payment-address .checkout-content-body').html(html);
				
				if ($('input[name=\'account\']:checked').val() == 'register') {
					$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
					} else {
					$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
				}
				
				$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-address\']').trigger('click');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Login
	$(document).delegate('#button-login', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/login/save',
			type: 'post',
			data: $('#collapse-checkout-option :input'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-login').val('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#button-login').val('<?php echo $button_continue; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				$('.form-group').removeClass('has-error');
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					$('#collapse-checkout-option .checkout-content-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>');
					
					// Highlight any found errors
					$('input[name=\'email\']').parent().addClass('has-error');
					$('input[name=\'password\']').parent().addClass('has-error');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Register
	$(document).delegate('#button-register', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/register/save',
			type: 'post',
			data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-register').val('<?php echo $text_loading; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				$('.form-group').removeClass('has-error');
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					$('#button-register').val('<?php echo $button_continue; ?>');
					
					if (json['error']['warning']) {
						$('#collapse-payment-address .checkout-content-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>');
					}
					
					for (i in json['error']) {
						var element = $('#input-payment-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
							} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}
					
					// Highlight any found errors
					$('.text-danger').parent().addClass('has-error');
					} else {
					<?php if ($shipping_required) { ?>
						var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').prop('value');
						
						
						if (shipping_address) {
							$.ajax({
								url: 'index.php?route=checkout/shipping_method',
								dataType: 'html',
								success: function(html) {
									// Add the shipping address
									$.ajax({
										url: 'index.php?route=checkout/shipping_address',
										dataType: 'html',
										success: function(html) {
											$('#collapse-shipping-address .checkout-content-body').html(html);
											
											$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
										},
										error: function(xhr, ajaxOptions, thrownError) {
											alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
										}
									});
									
									$('#collapse-shipping-method .checkout-content-body').html(html);
									
									$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');
									
									$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-method\']').trigger('click');
									
									$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
									$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
									$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
							} else {
							$.ajax({
								url: 'index.php?route=checkout/shipping_address',
								dataType: 'html',
								success: function(html) {
									$('#collapse-shipping-address .checkout-content-body').html(html);
									
									$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
									
									$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-address\']').trigger('click');
									
									$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
									$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
									$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
						}
						<?php } else { ?>
						$.ajax({
							url: 'index.php?route=checkout/payment_method',
							dataType: 'html',
							success: function(html) {
								$('#collapse-payment-method .checkout-content-body').html(html);
								
								$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
								
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-method\']').trigger('click');
								
								$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
					<?php } ?>
					
					$.ajax({
						url: 'index.php?route=checkout/payment_address',
						dataType: 'html',
						complete: function() {
							$('#button-register').val('<?php echo $button_continue; ?>');
						},
						success: function(html) {
							$('#collapse-payment-address .checkout-content-body').html(html);
							
							$('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Payment Address
	$(document).delegate('#button-payment-address', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/payment_address/save',
			type: 'post',
			data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select, #collapse-payment-address input[name=\'payment_address\']'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-payment-address').val('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#button-payment-address').val('<?php echo $button_continue; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					if (json['error']['warning']) {
						$('#collapse-payment-address .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					
					for (i in json['error']) {
						var element = $('#input-payment-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
							} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}
					
					// Highlight any found errors
					$('.text-danger').parent().parent().addClass('has-error');
					} else {
					<?php if ($shipping_required) { ?>
						checkout_step(2);
						<?php } else { ?> 
						checkout_step(4);
					<?php }  ?> 
					<?php if ($shipping_required) { ?>
						$.ajax({
							url: 'index.php?route=checkout/shipping_address',
							dataType: 'html',
							success: function(html) {
								$('#collapse-shipping-address .checkout-content-body').html(html);
								
								$('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
								
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-address\']').trigger('click');
								
								$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
								$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
								$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
						<?php } else { ?> 
						$.ajax({
							url: 'index.php?route=checkout/payment_method',
							dataType: 'html',
							success: function(html) {
								$('#collapse-payment-method .checkout-content-body').html(html);
								
								$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
								
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-method\']').trigger('click');
								
								$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
					<?php } ?>
					
					$.ajax({
						url: 'index.php?route=checkout/payment_address',
						dataType: 'html',
						success: function(html) {
							$('#collapse-payment-address .checkout-content-body').html(html);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Shipping Address
	$(document).delegate('#button-shipping-address', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/shipping_address/save',
			type: 'post',
			data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select, #collapse-shipping-address input[name=\'shipping_address\']'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-shipping-address').val('<?php echo $text_loading; ?>');
			},
			complete: function(){
				$('#button-shipping-address').val('<?php echo $button_continue; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					
					if (json['error']['warning']) {
						$('#collapse-shipping-address .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					
					for (i in json['error']) {
						var element = $('#input-shipping-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
							} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}
					
					// Highlight any found errors
					$('.text-danger').parent().parent().addClass('has-error');
					} else {
					checkout_step(3);
					$.ajax({
						url: 'index.php?route=checkout/shipping_method',
						dataType: 'html',
						complete: function() {
							$('#button-shipping-address').val('<?php echo $button_continue; ?>');
						},
						success: function(html) {
							$('#collapse-shipping-method .checkout-content-body').html(html);
							
							$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');
							
							$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-method\']').trigger('click');
							
							$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							
							$.ajax({
								url: 'index.php?route=checkout/shipping_address',
								dataType: 'html',
								success: function(html) {
									$('#collapse-shipping-address .checkout-content-body').html(html);
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
					
					$.ajax({
						url: 'index.php?route=checkout/payment_address',
						dataType: 'html',
						success: function(html) {
							$('#collapse-payment-address .checkout-content-body').html(html);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Guest
	$(document).delegate('#button-guest', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/guest/save',
			type: 'post',
			data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-guest').val('<?php echo $text_loading; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					$('#button-guest').val('<?php echo $button_continue; ?>');
					
					if (json['error']['warning']) {
						$('#collapse-payment-address .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					
					for (i in json['error']) {
						var element = $('#input-payment-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
							} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}
					
					// Highlight any found errors
					$('.text-danger').parent().addClass('has-error');
					} else { 
					<?php if ($shipping_required) { ?> 
						var shipping_address = $('#collapse-payment-address input[name=\'shipping_address\']:checked').prop('value');
						
						if (shipping_address) { 
							$.ajax({
								url: 'index.php?route=checkout/shipping_method',
								dataType: 'html',
								beforeSend: function(){
									$('#button-guest').val('<?php echo $text_loading; ?>');
								},
								complete: function() {
									$('#button-guest').val('<?php echo $button_continue; ?>');
								},
								success: function(html) {
									// Add the shipping address
									$.ajax({
										url: 'index.php?route=checkout/guest_shipping',
										dataType: 'html',
										success: function(html) {
											$('#collapse-shipping-address .checkout-content-body').html(html);
											
										},
										error: function(xhr, ajaxOptions, thrownError) {
											alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
										}
									});
									checkout_step(3);
									$('#collapse-shipping-method .checkout-content-body').html(html);
									
									$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-method\']').trigger('click');
									
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
							} else { 
							$.ajax({
								url: 'index.php?route=checkout/guest_shipping',
								dataType: 'html',
								complete: function() {
									$('#button-guest').val('<?php echo $button_continue; ?>');
								},
								success: function(html) {
									$('#collapse-shipping-address .checkout-content-body').html(html);
									
									$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-address\']').trigger('click');
									checkout_step(3);
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
						}
						<?php } else { ?>
						$.ajax({
							url: 'index.php?route=checkout/payment_method',
							dataType: 'html',
							complete: function() {
								$('#button-guest').val('<?php echo $text_loading; ?>');
							},
							success: function(html) {
								$('#collapse-payment-method .checkout-content-body').html(html);
								checkout_step(4);
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-method\']').trigger('click');
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
					<?php } ?>
				}
				$('#button-guest').val('<?php echo $button_continue; ?>');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	// Guest Shipping
	$(document).delegate('#button-guest-shipping', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/guest_shipping/save',
			type: 'post',
			data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-guest-shipping').val('<?php echo $text_loading; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					$('#button-guest-shipping').val('<?php echo $button_continue; ?>');
					
					if (json['error']['warning']) {
						$('#collapse-shipping-address .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					
					for (i in json['error']) {
						var element = $('#input-shipping-' + i.replace('_', '-'));
						
						if ($(element).parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
							} else {
							$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
						}
					}
					
					// Highlight any found errors
					$('.text-danger').parent().addClass('has-error');
					} else {
					$.ajax({
						url: 'index.php?route=checkout/shipping_method',
						dataType: 'html',
						complete: function() {
							$('#button-guest-shipping').val('<?php echo $button_continue; ?>');
						},
						success: function(html) {
							$('#collapse-shipping-method .checkout-content-body').html(html);
							
							$('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i>');
							checkout_step(4);
							$('a[href=\'<?php echo $current_page_url; ?>#collapse-shipping-method\']').trigger('click');
							
							$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	$(document).delegate('#button-shipping-method', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/shipping_method/save',
			type: 'post',
			data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-shipping-method').val('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#button-shipping-method').val('<?php echo $button_continue; ?>');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
				checkout_step(4);
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					if (json['error']['warning']) {
						$('#collapse-shipping-method .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					} else {
					<?php if ($shipping_required) { ?>
						$.ajax({
							url: 'index.php?route=module/timeslot/timeslot',
							dataType: 'html',
							success: function(html) {
								$('#collapse-timeslot > .checkout-content-body').html(html);
								$('#collapse-timeslot').parent().find('.panel-heading .panel-title').html('<a href="#collapse-timeslot" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_delivery_time; ?> <i class="fa fa-caret-down"></i></a>');
								
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-timeslot\']').trigger('click');
								
								$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
								$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
						<?php } else { ?>
						$.ajax({
							url: 'index.php?route=checkout/checkout/getUpdatedOrderSummary',
							dataType: 'html',
							success: function(html) {
								$('#checkout_summary > .order-summary').html(html);
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
						
						
						$.ajax({
							url: 'index.php?route=checkout/payment_method',
							dataType: 'html',
							complete: function() { 
								$('#button-shipping-method').val('<?php echo $button_continue; ?>');
							},
							success: function(html) { 
								$('#collapse-payment-method .checkout-content-body').html(html);
								
								$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
								
								$('a[href=\'<?php echo $current_page_url; ?>#collapse-payment-method\']').trigger('click');
								
								$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
							},
							error: function(xhr, ajaxOptions, thrownError) { 
								alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
							}
						});
					<?php } ?>
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	
	<?php if( $shipping_required ) { ?>
		//[type=\'datetime-local\']
		$(document).delegate('#button-interval', 'click', function() {
			
			$.ajax({
				url: 'index.php?route=module/timeslot/timeslot/save',
				type: 'post',
				data: $('#collapse-timeslot select'),
				dataType: 'html',
				beforeSend: function() {
					$('#button-interval').val('<?php echo $text_loading; ?>');
				},
				complete: function() { 
					$('#button-interval').val('<?php echo $button_continue; ?>');
				},
				success: function(json) {
					checkout_step(5);
					$.ajax({
						url: 'index.php?route=checkout/payment_method',
						dataType: 'html',
						success: function(html) { 
							$('#collapse-payment-method .checkout-content-body').html(html);
							
							/* $('#collapse-payment-method').parent().find('li.active').next().html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?></a>'); */
							
							$('a[href="#collapse-payment-method"]').trigger('click');
							
							$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
						},
						error: function(xhr, ajaxOptions, thrownError) { 
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
					
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
	<?php } ?>
	
	$(document).delegate('#button-payment-method', 'click', function() {
		$.ajax({
			url: 'index.php?route=checkout/payment_method/save',
			type: 'post',
			data: $('#collapse-payment-method input[type=\'radio\']:checked, #collapse-payment-method input[type=\'checkbox\']:checked, #collapse-payment-method textarea'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-payment-method').val('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#button-payment-method').val('<?php echo $button_continue; ?>');
			},
			success: function(json) {
				checkout_step(7);
				$('.alert, .text-danger').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
					} else if (json['error']) {
					if (json['error']['warning']) {
						$('#collapse-payment-method .checkout-content-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');
					}
					} else {
					$.ajax({
						url: 'index.php?route=checkout/confirm',
						dataType: 'html',
						complete: function() {
							$('#button-payment-method').val('<?php echo $button_continue; ?>');
						},
						success: function(html) {
							$('#collapse-checkout-confirm .checkout-content-body').html(html);
							
							$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');
							
							$('a[href=\'<?php echo $current_page_url; ?>#collapse-checkout-confirm\']').trigger('click');
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					});
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	/** jQueryTab.js : initializing jQueryTab plugin **/
		$(document).ready(function () {
			jQuery.jQueryTab({
				responsive:true,						// enable accordian on smaller screens
				collapsible:false,						// allow all accordions to collapse 
				useCookie: true,						// remember last active tab using cookie
				openOnhover: false,						// open tab on hover
				<?php if ($logged) { ?>
					initialTab: 2,								// tab to open initially; start count at 1 not 0
					<?php }else{ ?>
					initialTab: 1,	
				<?php } ?>
				cookieName: 'checkout-tab',
				tabClass:'tabs',							// class of the tabs
				headerClass:'accordion_tabs',	// class of the header of accordion on smaller screens
				contentClass:'tab_content',		// class of container
				activeClass:'active',					// name of the class used for active tab	
				tabTransition: 'fade',				// transitions to use - normal or fade
				tabIntime:500,								// time for animation IN (1000 = 1s)
				tabOuttime:0,									// time for animation OUT (1000 = 1s)			
				accordionTransition: 'slide',	// transitions to use - normal or slide
				accordionIntime:500,					// time for animation IN (1000 = 1s)
				accordionOuttime:400,					// time for animation OUT (1000 = 1s)
				before: function(){},					// function to call before tab is opened
				after: function(){ }						// function to call after tab is opened
			});
		});
		var screenWidth = $( window ).width();
		$(window).resize(function(){
			screenWidth =  $( window ).width();
		});
		$(document).ready(function(){
			if(screenWidth<=768){
				/* $('.cart-tabs a.accordion_tabs').each(function(index, element) { */
				$('a.accordion_tabs').each(function(index, element) {
					var href = $(element).attr('href');
					href = $('.cart-tabs ul.tabs li').find('a[data-for='+href+']').attr('href');
					$(element).attr('href', 'javascript:void(0)');
					var nextEleId = $( element ).next().attr( 'id' );
					if( nextEleId ) 
					$(element).attr( 'for', nextEleId );
				});
				
				/* $('.cart-tabs a.accordion_tabs').click(function(e){ */
				$('a.accordion_tabs').click(function(e){
					var _this = $(this);
					var href = _this.attr('href');
					var n = href.indexOf("javascript");
					if(!n){
						console.log('clicked: js:void');
						return false;
						}else{
						
					}
					
					var prevIndex 		= _this.index();
					$('a.accordion_tabs').each(function(index, el) {
						currentIndex = $(el).index();
						if( prevIndex >= 0 && currentIndex >= 0 && currentIndex > prevIndex ) { 
							$(el).attr( 'href', 'javascript: void(0);' );
						}
					});
					//changeUrl(this);
				});
				}else{
				$('a.checkoutTab').on("click",function(e){ 
					str = $(this).parent('li').find('a.checkoutTab').attr('href');
					n = str.indexOf("javascript");
					clickedTab = $(this).parent('li').find('a.checkoutTab').index('a.checkoutTab');
					<?php if ($logged) { ?>
						if(parseInt(clickedTab)==0){
							return false;
						}
					<?php } ?>
					if(!n){			
						prevActiveTabIndex = $(this).parents('.cart-tabs ul.tabs').find('li.active').index();
						if((parseInt(prevActiveTabIndex)-parseInt(clickedTab))>=0){ 			
							checkout_step(clickedTab);
							}else{ 
							return false;
						} 
						}else{
						checkout_step(clickedTab);
					}
					
					var prevIndex 		= $(this).index();
					$('a.checkoutTab').each(function(index, el) {
						currentIndex = $(el).index();
						if( prevIndex >= 0 && currentIndex >= 0 && currentIndex > prevIndex ) { 
							$(el).attr( 'href', 'javascript: void(0);' );
						}
					});
					
				});
			}
			<?php if ($logged) { ?>        
				function runCheckoutAjax() {
					$('#checkout_cart_update').load('index.php?route=checkout/checkout/update_info');          
					$.ajax({
						url: 'index.php?route=checkout/checkout/getUpdatedOrderSummary',
						dataType: 'html',
						success: function(html) {
							$('#checkout_summary > .order-summary').html(html);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							/*  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);   */
						}
					});                
				}
				setInterval(runCheckoutAjax, 5000);                
			<?php } ?>        
			
		});
		
		function checkout_step(tab) {
			$('a.checkoutTab').each(function(index, element){
				$('a.checkoutTab:eq('+parseInt(index)+')').attr('href', 'javascript: void(0);');
			});
			for(i=0; i<=parseInt(tab); i++){
				<?php if ($logged) { ?>
					if(i==0){continue;}
				<?php } ?>
				fortab = $('a.checkoutTab:eq('+parseInt(i)+')').attr('for');
				curpageurl = '<?php echo $current_page_url; ?>#'+fortab;
				$('a.checkoutTab:eq('+parseInt(i)+')').attr('href', curpageurl);
			}
			
			var currentId = $('a.checkoutTab:eq('+parseInt(tab)+')').attr('for');
			if( currentId ) {
				<?php if ($logged) { ?>
					if(tab==0){return;}
				<?php } ?>
				var prevIndex = false;
				var currIndex = false;
				$('a.accordion_tabs').each(function(index, el) {
					var nextEleId = $( el ).next().attr( 'id' );
					if( nextEleId == currentId ) { 
						$(el).attr( 'href', '#'+nextEleId );
						prevIndex = $(el).index();
						} else { 
						currentIndex = $(el).index();;
						if( prevIndex && currentIndex > prevIndex ) { 
							$(el).attr( 'href', 'javascript: void(0);' );
						}
					}
				});
			}
			
		}
		
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
	<style>.checkout_button{display:none !important;}</style>
	
	
	<?php echo $footer; ?>
