<?php 
$server = 'http';

//if($this->request->server['HTTPS']){
if(!empty($_SERVER['HTTPS'])){
	$server = 'https';
}
echo $header; 
if( $share_thumb){
	$share_image = $share_thumb;
}else{
	$share_image = 'catalog/view/theme/growcer/images/placeholder.png';
}

?>
<meta property="og:title" content="<?php echo $heading_title; ?>"/>
<meta property="og:url" content="<?php echo "$server://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>"/>
<meta property="og:image" content="<?php echo $share_image; ?>"/>

<div id="body">
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
	<?php if (isset($attention)) { ?>
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
	<?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class=" fix-container <?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="fix-container">
		<div class="product-detail">
			<div class="row">
				<div class="col-md-6 column">
					 <?php if ($thumb || $images) {  ?>
					
					<div class="gallery-side">
						<div id="product-gallery" class="eagle-gallery img370">
							<div class="owl-carousel"> 
								<?php if (isset($thumb) && $thumb!='') { ?>
								<img src="<?php echo $popup; ?>" data-medium-img="<?php echo $thumb; ?>" data-big-img="<?php echo $popup; ?>" data-title="<?php echo $heading_title; ?>" class="img-effects" alt="<?php echo $heading_title; ?>"> 
								 <?php }else{ ?>
								 <img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects" alt="<?php echo $heading_title; ?>" />
								 <?php } ?>
								 <?php if ($images) { ?>
									<?php foreach ($images as $image) { ?>
									<img src="<?php echo $image['popup']; ?>" data-medium-img="<?php echo $image['thumb']; ?>" data-big-img="<?php echo $image['popup']; ?>" data-title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"> 
									<?php } ?>
								<?php } ?>
							</div>
						</div>
					</div>
					
					<?php  }else{  ?>
					<div class="imgBlock">
						<div class="productImg">
							<img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-responsive img-effects" alt="<?php echo $heading_title; ?>" />
						</div>
					</div>
					<?php  } ?>
				</div>
				<div class="col-md-6 column">
					<div class="desc-side">
					<div class="padd15">
						<div class="name"><?php echo $heading_title; ?></div>
						<ul class="list-unstyled">
							<?php 
								echo isset($manufacturer)? '<li>'.$text_manufacturer.' <a href="'.$manufacturers.'">'.$manufacturer.'</a></li>' : '';
								echo isset($model) ?  '<li><p>'.$text_model.' '.$model.'</p> </li>' : '';
								echo isset($reward) && intval( $reward ) > 0 ?  '<li><p title="'.$text_reward_tooltip.'">'.$text_reward.' '.$reward.'</p></li>' : '';
								echo isset($points) && intval( $points )> 0 ?  '<li><p title="'.$text_points_tooltip.'">'.$text_points.' '.$points.'</p></li>' : '';

								echo isset($stock) ?  '<li>'.$text_stock.' '.$stock.'</li>' : '';
							    if ($discounts) { 
									echo '<div class="gap"></div><div class="divider"></div><div class="gap"></div>';
									foreach ($discounts as $discount) { 
										echo $text_buy.$discount['quantity'].$text_discount.$text_discounted_price.$discount['price'].$text_buy_end.'<br/>'; 
									}
								} 
							?>							
						</ul>
						<?php if ($review_status) { ?>
						<?php 
							$ratings_review_html = '';
						?>
						<div class="review">
							<div class="rating">
								<?php 
								$ratings_review_html ='<ul>';
									$max_ratings = 5;
									$min_ratings = 0;
									if($rating>$min_ratings){
										for($rcount=1; $rcount<=$rating; $rcount++){
										$max_ratings--;
										
										$ratings_review_html.='<li class="active">
												  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
											<g>
													  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
													</g>
										  </svg>
										</li>';
										}
									}
									for($rcount=1; $rcount<=$max_ratings; $rcount++){
									
									$ratings_review_html.='<li class="in-active">
											  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
										<g>
												  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
												</g>
									  </svg>
									</li>';
									
									}
								$ratings_review_html.='</ul>';
								echo $ratings_review_html;
								?>
							</div>
						<?php echo $reviews; ?> / <a href="<?php echo $current_page_url; ?>#write_review_frm"><?php echo $text_write; ?></a>
						</div>
						<?php } ?>
					</div>
					<div class="gray-bg" id="product">
						<div class="row">
							<?php
						/***Default opencart code[***/
						?>
						<div class="col-md-12">
						<div class="product_extras">
							
							<form class="siteForm form-horizontal product-detail-form">
								<input type="hidden" name="product_page" value="1" />							
							<?php if ($options) { ?>
							<h3><?php echo $text_option; ?></h3>
							<?php foreach ($options as $option) { ?>
							<?php if ($option['type'] == 'select') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
							  <div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
									<?php if ($option_value['price']) { ?>
									(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
									<?php } ?>
									</option>
									<?php } ?>
								  </select>
							  </div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'radio') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
							 <div class="col-md-12">
								  <label class="control-label"><?php echo $option['name']; ?></label>
								  <div id="input-option<?php echo $option['product_option_id']; ?>">
									<div class="radio-wrap">
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									  <label class="radio">
										<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
										<i class="input-helper"></i>
										<?php echo $option_value['name']; ?>
										<?php if ($option_value['price']) { ?>
										(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
										<?php } ?>
									  </label>
									<?php } ?>
									</div>
								  </div>
							  </div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'checkbox') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label"><?php echo $option['name']; ?></label>
								  <div id="input-option<?php echo $option['product_option_id']; ?>">
									<div class="checkbox-wrap">
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									  <label class="checkbox">
										<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
										<i class="input-helper"></i>
										<?php echo $option_value['name']; ?>
										<?php if ($option_value['price']) { ?>
										(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
										<?php } ?>
									  </label>
									<?php } ?>
									</div>
								  </div>
							  </div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'image') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label"><?php echo $option['name']; ?></label>
								  <div id="input-option<?php echo $option['product_option_id']; ?>">
									<div class="radio-wrap">
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
									  <label class="radio">
										<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
										<i class="input-helper"></i>
										<img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
										<?php if ($option_value['price']) { ?>
										(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
										<?php } ?>
									  </label>
									<?php } ?>
									</div>
								  </div>
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'text') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'textarea') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'file') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label"><?php echo $option['name']; ?></label>
								  <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
								  <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'date') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <div class="input-group date">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn">
									<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
									</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'datetime') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <div class="input-group datetime">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn">
									<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									</span>
								  </div>
								</div>
							</div>
							<?php } ?>
							<?php if ($option['type'] == 'time') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<div class="col-md-12">
								  <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								  <div class="input-group time">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn">
									<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									</span></div>
								</div>	
							</div>
							<?php } ?>
							<?php } ?>
							<?php } ?>
							<?php if ($recurrings) { ?>
							<div class="form-group required">
								<div class="col-md-12">
									  <label class="control-label"><?php echo $text_payment_recurring ?></label>
									  <select name="recurring_id" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($recurrings as $recurring) { ?>
										<option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
										<?php } ?>
									  </select>
									  <div class="help-block" id="recurring-description"></div>
								 </div>
							</div>
							<?php } ?>
							 
							<?php if ($minimum > 1) { ?>
							<div class="text-danger">
								<i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?>
							</div>
							<div class="gap"></div>
							<?php } ?>
							
							</form>
							</div>
						  </div>
						<?php
						/*****]******/
						?>
						</div>
						<div class="desc-left">
							<div class="price">
								<?php if (!$special) { ?>
									<?php echo $price; ?>
								<?php } else { ?>
									<strike><?php echo $price; ?></strike> <?php echo $special; ?>
								<?php } ?>
								<?php if ($tax) { ?>
								<div class="clear"></div>
								<small><?php echo $text_tax; ?> <?php echo $tax; ?></small>
								<?php } ?>
							</div>
							<div class="quantity"><?php echo $text_product_quantity; ?>:
								<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
								<ul>
									<li id="lessqty" class="minus qty-but" onclick="decrement_quantity()">-</li>
									<li class="value">
									<input id="qty-field" type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
									</li>
									<li id="moreqty" class="qty-but plus" onclick="increment_quantity()">+</li>
								</ul>
							</div>
						</div>
						<div class="desc-right"> 
							<button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="themeBtn"><span class="txt"><?php echo $button_cart; ?></span> <i class="cartIcon">
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
							</i> </button>
							
							<button type="button" class="themeBtn graybtn" onclick="wishlist.add(<?php echo $product_id; ?>)"><span class="txt"><?php echo $button_wishlist; ?></span> <i class="cartIcon">
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
							</i> </button>
							
							
							<button type="button" class="themeBtn" onclick="compare.add(<?php echo $product_id; ?>)">
								<span class="txt"><?php echo $button_compare; ?></span> 
								<i class="cartIcon">
									<svg xml:space="preserve" enable-background="new 0 0 100 100" viewBox="0 0 100 100" y="0px" x="0px" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"><g><path d="M6.75,32.642h82.275L77.87,43.797c-0.683,0.683-0.683,1.791,0,2.475s1.791,0.683,2.475,0L94.487,32.13   c0.081-0.081,0.154-0.171,0.218-0.267c0.029-0.043,0.049-0.09,0.073-0.135c0.03-0.055,0.064-0.108,0.088-0.167   c0.024-0.058,0.038-0.118,0.055-0.178c0.015-0.05,0.034-0.097,0.044-0.149c0.045-0.226,0.045-0.459,0-0.686   c-0.01-0.051-0.029-0.099-0.044-0.149c-0.017-0.06-0.031-0.12-0.055-0.178c-0.024-0.059-0.058-0.112-0.088-0.167   c-0.025-0.045-0.044-0.092-0.073-0.135c-0.064-0.096-0.137-0.186-0.218-0.267L80.345,15.513c-0.683-0.683-1.791-0.683-2.475,0   s-0.683,1.792,0,2.475l11.155,11.155H6.75c-0.966,0-1.75,0.784-1.75,1.75S5.784,32.642,6.75,32.642z"/><path d="M93.25,67.358H10.975L22.13,56.203c0.683-0.683,0.683-1.792,0-2.475s-1.791-0.683-2.475,0L5.513,67.87   c-0.081,0.081-0.154,0.171-0.218,0.267c-0.029,0.043-0.049,0.09-0.073,0.135c-0.03,0.055-0.064,0.108-0.088,0.167   c-0.024,0.058-0.038,0.118-0.055,0.178c-0.015,0.05-0.034,0.097-0.044,0.149c-0.045,0.226-0.045,0.459,0,0.686   c0.01,0.051,0.029,0.099,0.044,0.149c0.017,0.06,0.031,0.12,0.055,0.178c0.024,0.059,0.058,0.112,0.088,0.167   c0.025,0.045,0.044,0.092,0.073,0.135c0.064,0.096,0.137,0.186,0.218,0.267l14.142,14.142c0.683,0.683,1.791,0.683,2.475,0   s0.683-1.791,0-2.475L10.975,70.858H93.25c0.966,0,1.75-0.784,1.75-1.75S94.216,67.358,93.25,67.358z"/></g></svg>
								</i> 
							</button>							
							
							<?php if(isset($stock) && strtolower($stock)=='out of stock'){ ?>
							<div>
								<a id="request_quote" onclick="getProductQuote('<?php echo $product_id; ?>', '1')" class="themeBtn"><?php echo $text_request_quote; ?></a>
							</div>
							<?php } ?> 
							</div>
							<div class="clear"></div>
						</div>
						<div class="padd15">
								  <div>
								  <?php if ($tags) { ?>
								  <p><?php echo $text_tags; ?>
									<?php for ($i = 0; $i < count($tags); $i++) { ?>
									<?php if ($i < (count($tags) - 1)) { ?>
									<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
									<?php } else { ?>
									<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
									<?php } ?>
									<?php } ?>
								  </p>
								  <div>&nbsp;</div>
								  <?php } ?>
								  </div>
								  <?php 
								  if(isset($text_shipping_quote_data)){
									  ?>
										  <div class="order-above"><i class="icn">
											<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="xMidYMid" width="25" height="17" viewBox="0 0 25 17">
											<path d="M0.877,11.327 L0.877,1.035 C0.877,0.464 1.356,-0.000 1.947,-0.000 L12.578,-0.000 C13.169,-0.000 13.649,0.464 13.649,1.035 L13.649,11.327 C13.649,11.517 13.489,11.672 13.292,11.672 L1.234,11.672 C1.037,11.672 0.877,11.517 0.877,11.327 ZM9.462,14.852 C9.462,16.038 8.468,17.000 7.242,17.000 C6.017,17.000 5.023,16.038 5.023,14.852 C5.023,13.666 6.017,12.705 7.242,12.705 C8.468,12.705 9.462,13.666 9.462,14.852 ZM8.352,14.852 C8.352,14.259 7.855,13.778 7.242,13.778 C6.629,13.778 6.132,14.259 6.132,14.852 C6.132,15.445 6.629,15.926 7.242,15.926 C7.855,15.926 8.352,15.445 8.352,14.852 ZM5.331,12.705 L0.357,12.705 C0.160,12.705 -0.000,12.859 -0.000,13.050 L-0.000,14.097 C-0.000,14.288 0.160,14.442 0.357,14.442 L4.343,14.442 C4.448,13.751 4.808,13.141 5.331,12.705 ZM21.076,14.852 C21.076,16.038 20.082,17.000 18.856,17.000 C17.630,17.000 16.636,16.038 16.636,14.852 C16.636,13.666 17.630,12.705 18.856,12.705 C20.082,12.705 21.076,13.666 21.076,14.852 ZM19.966,14.852 C19.966,14.259 19.469,13.778 18.856,13.778 C18.243,13.778 17.746,14.259 17.746,14.852 C17.746,15.445 18.243,15.926 18.856,15.926 C19.469,15.926 19.966,15.445 19.966,14.852 ZM25.000,13.050 L25.000,14.097 C25.000,14.288 24.840,14.442 24.643,14.442 L21.755,14.442 C21.548,13.071 20.329,12.014 18.856,12.014 C17.383,12.014 16.164,13.071 15.957,14.442 L10.141,14.442 C10.037,13.751 9.677,13.141 9.154,12.705 L14.669,12.705 L14.669,2.832 C14.669,2.451 14.988,2.142 15.382,2.142 L18.750,2.142 C19.698,2.142 20.585,2.597 21.115,3.358 L23.286,6.469 C23.605,6.926 23.775,7.464 23.775,8.014 L23.775,12.705 L24.643,12.705 C24.840,12.705 25.000,12.859 25.000,13.050 ZM21.381,6.549 L19.645,4.162 C19.578,4.070 19.469,4.015 19.353,4.015 L16.645,4.015 C16.448,4.015 16.288,4.170 16.288,4.361 L16.288,6.748 C16.288,6.938 16.448,7.093 16.645,7.093 L21.089,7.093 C21.378,7.093 21.547,6.778 21.381,6.549 Z" />
										  </svg>
											</i>
											<?php
												echo $text_shipping_quote_data;
											?>
											</div>
									<?php
									}
									?>
								  <div class="share" id="sharethis">
									<!-- Go to www.addthis.com/dashboard to customize your tools -->
									<div class="addthis_native_toolbox"></div>
								  </div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="about-product">
						<h2><?php echo $text_about_product; ?></h2>
						<div class="cell">
						  <h3><?php echo $tab_description; ?></h3>
						  <?php echo $description; ?>
						</div>
						<?php if ($attribute_groups) { ?>
							<div class="cell">
								<h3><?php echo $tab_attribute; ?></h3>
								<table>
							<?php foreach ($attribute_groups as $attribute_group) { ?>
									<thead>
									  <tr>
										<th><strong><?php echo $attribute_group['name']; ?></strong></th>
										<th>&nbsp;</th>
									  </tr>
									</thead>
									<tbody>
									<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
									  <tr>
										<td><?php echo $attribute['name']; ?></td>
										<td><?php echo $attribute['text']; ?></td>
									  </tr>
									<?php } ?>
									</tbody>
							<?php } ?>
								</table>
							</div>
						<?php } ?>
					</div>
				</div>
			</div>
			<div class="gap"></div>
			
			<?php if ($review_status) { ?>
			
			<div class="row">
				<div class="col-md-12">
					<div class="head_title">
					<h2><?php echo $text_customer_review; ?></h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="cust-review">
					<div class="rating size30">
					<?php if(isset($ratings_review_html)){ ?>
					<?php echo $ratings_review_html; ?>
						<?php echo $reviews; ?>  |  <?php echo $rating; ?> <?php echo $text_out_of_rating; ?> </div>
					<?php } ?>
				    </div>
				</div>
				<div class="col-md-3">
					<div class="stars-rating">
						<ul>
							<li>
							<div class="u-str"><?php echo $text_5_count; ?></div>
							<div class="prog"><span class="f-cl" style="width:<?php echo ($rating_count_total > 0) ? ($rating_count_5/$rating_count_total*100):0; ?>%"></span></div>
							<div class="t-star"><?php echo $rating_count_5; ?></div>
							</li>
							<li>
							<div class="u-str"><?php echo $text_4_count; ?></div>
							<div class="prog"><span class="f-cl" style="width:<?php echo ($rating_count_total > 0) ? ($rating_count_4/$rating_count_total*100):0; ?>%"></span></div>
							<div class="t-star"><?php echo $rating_count_4; ?></div>
							</li>
							<li>
							<div class="u-str"><?php echo $text_3_count; ?></div>
							<div class="prog"><span class="f-cl" style="width:<?php echo ($rating_count_total > 0) ? ($rating_count_3/$rating_count_total*100):0; ?>%"></span></div>
							<div class="t-star"><?php echo $rating_count_3; ?></div>
							</li>
							<li>
							<div class="u-str"><?php echo $text_2_count; ?></div>
							<div class="prog"><span class="f-cl" style="width:<?php echo ($rating_count_total > 0) ? ($rating_count_2/$rating_count_total*100):0 ?>%"></span></div>
							<div class="t-star"><?php echo $rating_count_2; ?></div>
							</li>
							<li>
							<div class="u-str"><?php echo $text_1_count; ?></div>
							<div class="prog"><span class="f-cl" style="width:<?php echo ($rating_count_total > 0) ? ($rating_count_1/$rating_count_total*100):0; ?>%"></span></div>
							<div class="t-star"><?php echo $rating_count_1; ?></div>
							</li>
						</ul>
					</div>
						</div>
				<div class="col-md-3">
					<div class="recommend-friend">&nbsp;</div>
				</div>
				<div class="col-md-3">
					<div class="btn-wrap-align"> 
						<a tabindex="0" class="addtocart-btn green " href="<?php echo $current_page_url; ?>#write_review_frm">
						<?php echo $text_write; ?><span class="cartIcon">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="xMidYMid" width="21" height="21" viewBox="0 0 21 21">
						<path d="M13.780,11.156 L7.219,11.156 C6.857,11.156 6.563,11.450 6.563,11.812 C6.563,12.174 6.857,12.468 7.219,12.468 L13.780,12.468 C14.143,12.468 14.436,12.174 14.436,11.812 C14.436,11.450 14.143,11.156 13.780,11.156 ZM15.092,7.219 L5.907,7.219 C5.545,7.219 5.251,7.513 5.251,7.875 C5.251,8.237 5.545,8.531 5.907,8.531 L15.092,8.531 C15.455,8.531 15.748,8.237 15.748,7.875 C15.748,7.513 15.455,7.219 15.092,7.219 ZM10.500,0.002 C4.702,0.002 0.002,4.114 0.002,9.187 C0.002,12.087 1.540,14.668 3.938,16.352 L3.938,20.998 L8.537,18.207 C9.174,18.312 9.828,18.373 10.500,18.373 C16.298,18.373 20.998,14.260 20.998,9.187 C20.998,4.114 16.298,0.002 10.500,0.002 ZM10.500,17.061 C9.733,17.061 8.993,16.972 8.282,16.820 L5.193,18.677 L5.234,15.634 C2.866,14.209 1.314,11.855 1.314,9.187 C1.314,4.839 5.426,1.314 10.500,1.314 C15.573,1.314 19.685,4.839 19.685,9.187 C19.685,13.536 15.573,17.061 10.500,17.061 Z"/>
						</svg>
						</span> </a> 
					</div>
				</div>
			</div>
			
			<div class="divider"></div>
			<div class="gap"></div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="head_title">
						<h2 id="write_review_frm"><?php echo $text_write; ?></h2>
					</div>
					<div class="write-form">
					<form class="siteForm" id="form-review">
					<?php if ($review_guest) { ?>
						<table>
							<tr>
								<td class="lable" width="40%"><?php echo $entry_rating;?> :</td>
								  <td>
									<div class="pro-rating">
									<div class="strenth poor"><?php echo $entry_bad; ?>&nbsp;&nbsp;&nbsp;</div>
									<div class="rating product-rating">
									<ul class="rating_inputs">
										<?php
										for($ircount=0; $ircount<5; $ircount++){
										?>
										<li class="">
										  <svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
											  <g>
											  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
											</g>
											</svg>
										</li>
										<?php
										}
										?>
									</ul>
									</div>
									<div class="strenth good"><?php echo $entry_good; ?></div>
										<input type="hidden" name="rating" id="ratingCount"  />
									</div>
									</td>
								</tr>
						<tr>
							<td class="lable"><?php echo $text_product_review; ?>:</td>
							<td>
								<div>
									<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
									<input required placeholder="<?php echo $entry_name; ?>" type="text" name="name" value="" id="input-name" class="form-control" />
								</div>
								<div>
									<label class="control-label" for="input-title"><?php echo $entry_title; ?></label>
									<input required placeholder="<?php echo $entry_title; ?>" type="text" name="title" value="" id="input-title" class="form-control" />
								</div>
								
								<div>
									<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
									<textarea required name="text" rows="5" id="input-review" class="form-control"></textarea>
									<div class="help-block"><?php echo $text_note; ?></div>
								</div>
								<div>
								<?php echo isset($captcha) ? '<div class="captcha_code" id="growcaptcha">'.$captcha.'</div>' : ''; ?>
								</div>
							</td>
						</tr>
						<tr>
						  <td class="lable"></td>
						  <td>
						  <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-theme"><?php echo $button_continue; ?></button>
						  </td>
						</tr>
					  </table>
					
					<?php } else { ?>
					<?php echo $text_login; ?>
					<?php } ?>
					</form>
				  </div>
						</div>
			</div>
			
			
			<div class="divider"></div>
			<div class="row">
				<div class="col-md-12">
					<div class="review-thread">
						<div id="review"></div>
					</div>
				</div>
			</div>
			
			<?php }/*review container*/ ?>
			
			
		</div>
	</div>
	  <!--fix-container-->
	  <?php 
	  /*****************RELATED PRODUCT CODE[ *******/
	  ?>
      <?php if ($products) {  ?>
	  
	<section class="comn-padd">
    <div class="fix-container">
        <div class="featured-product clearfix">
            <div class="head_title">
                <h2><?php echo $text_related; ?></h2>
            </div>
            <div class="slider-Block">
                <div class="products-listing featured-slider">
					<?php $i = 0; ?>
					<?php foreach ($products as $product) { ?>
					<?php if ($column_left && $column_right) { ?>
					<?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
					<?php } elseif ($column_left || $column_right) { ?>
					<?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
					<?php } else { ?>
					<?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
					<?php }  ?>
					<div class="slideItem <?php echo $class; ?>">
						<div class="productBox">
							<div class="imgBlock">
								<div class="productImg">
								<a href="<?php echo $product['href']; ?>">
								<?php if($product['thumb']){ ?>
								<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-effects" title="<?php echo $product['name']; ?>" />
								<?php }else{ ?>
								 <img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects" alt="<?php echo $product['name']; ?>" />
								<?php } ?>
								</a>
								</div>
								<div class="actionBtn"> 
									<a title="<?php echo $help_text_compare;?>" href="javascript:void(0)" onclick="compare.add(<?php echo $product['product_id']; ?>)" class="squrBtn zoom-icon">
									<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve"><g><path d="M6.75,32.642h82.275L77.87,43.797c-0.683,0.683-0.683,1.791,0,2.475s1.791,0.683,2.475,0L94.487,32.13   c0.081-0.081,0.154-0.171,0.218-0.267c0.029-0.043,0.049-0.09,0.073-0.135c0.03-0.055,0.064-0.108,0.088-0.167   c0.024-0.058,0.038-0.118,0.055-0.178c0.015-0.05,0.034-0.097,0.044-0.149c0.045-0.226,0.045-0.459,0-0.686   c-0.01-0.051-0.029-0.099-0.044-0.149c-0.017-0.06-0.031-0.12-0.055-0.178c-0.024-0.059-0.058-0.112-0.088-0.167   c-0.025-0.045-0.044-0.092-0.073-0.135c-0.064-0.096-0.137-0.186-0.218-0.267L80.345,15.513c-0.683-0.683-1.791-0.683-2.475,0   s-0.683,1.792,0,2.475l11.155,11.155H6.75c-0.966,0-1.75,0.784-1.75,1.75S5.784,32.642,6.75,32.642z"></path><path d="M93.25,67.358H10.975L22.13,56.203c0.683-0.683,0.683-1.792,0-2.475s-1.791-0.683-2.475,0L5.513,67.87   c-0.081,0.081-0.154,0.171-0.218,0.267c-0.029,0.043-0.049,0.09-0.073,0.135c-0.03,0.055-0.064,0.108-0.088,0.167   c-0.024,0.058-0.038,0.118-0.055,0.178c-0.015,0.05-0.034,0.097-0.044,0.149c-0.045,0.226-0.045,0.459,0,0.686   c0.01,0.051,0.029,0.099,0.044,0.149c0.017,0.06,0.031,0.12,0.055,0.178c0.024,0.059,0.058,0.112,0.088,0.167   c0.025,0.045,0.044,0.092,0.073,0.135c0.064,0.096,0.137,0.186,0.218,0.267l14.142,14.142c0.683,0.683,1.791,0.683,2.475,0   s0.683-1.791,0-2.475L10.975,70.858H93.25c0.966,0,1.75-0.784,1.75-1.75S94.216,67.358,93.25,67.358z"></path></g></svg>
									</a> 
									<a title="<?php echo $help_text_wishlist;?>" href="javascript:void(0)" onclick="wishlist.add(<?php echo $product['product_id']; ?>)" class="squrBtn fav-icon">
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
									</a> 
								</div>
							</div>
							<div class="infoBlock">
								<h4 class="title-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
								<?php
								/***Not required in current scope***/
								/***
								<p><?php echo $product['description']; ?></p>
								***/
								?>
								<div class="rating">
									<?php 
									$ratings_review_html ='<ul>';
										$max_ratings = 5;
										$min_ratings = 0;
										if($product['rating']>$min_ratings){
											for($rcount=1; $rcount<=$product['rating']; $rcount++){
											$max_ratings--;
											
											$ratings_review_html.='<li class="active">
													  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
												<g>
														  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
														</g>
											  </svg>
											</li>';
											}
										}
										for($rcount=1; $rcount<=$max_ratings; $rcount++){
										
										$ratings_review_html.='<li class="in-active">
												  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
											<g>
													  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
													</g>
										  </svg>
										</li>';
										
										}
									$ratings_review_html.='</ul>';
									echo $ratings_review_html;
									?>
								</div>								
								<?php if ($product['price']) { ?>
								  <div class="priceblock"> 									
									<?php if (!$product['special']) { ?>
									<?php echo '<span class="current-price">'.$product['price'].'</span>'; ?>
									<?php } else { ?>
									<span class="cros-price"><?php echo $product['price']; ?></span> <span class="current-price"><?php echo $product['special']; ?></span> 
									<?php } ?>
									<?php 
										if ($product['tax']) {
										/**Not required in current scope of the task**/
										/*********
										?>
										<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
										<?php 
										********/
										} 
									?>
								  </div>
								<?php } ?>
								<button type="button" class="themeBtn" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
								<span class="txt hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="cartIcon">
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
							</div><!--info block-->
						</div><!-- product box-->
					</div>
					<?php $i++; ?>
					<?php } ?>
					<!-- slide item -->
				</div>
			</div>
		</div>
	</div>
	</section>
	 
	  
	  
      <?php } ?>
	  
	  <?php 
	  /*****************RELATED PRODUCT CODE] *******/
	  ?>
    
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?>
	</div><!--main area-->
</div>
<script type="text/javascript">
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});

$('#button-cart').on('click', function() {
	var current_quantity = jQuery('#qty-field').val();
	if(isNaN(current_quantity) || current_quantity<=0){ 
		jQuery('#qty-field').val(1);
	}
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart .txt').html('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-cart .txt').html('<?php echo $button_cart; ?>');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
                        
                        if (json['redirect']) {
                                //location = json['redirect'];
                        }                        
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
                if (json['error']['stock']) { 
                    $('#body').parent().before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> ' + json['error']['stock'] + ' <button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>');
                }
                
				/* Highlight any found errors */
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('#body').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>');

				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
                                $('#dropdown-box').load('index.php?route=common/cart/info #load_dropdown_data ',updateCartData);
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});       
        
});

var defaultProductQty = parseInt(<?php echo $minimum;?>);
if(isNaN(defaultProductQty)){
	defaultProductQty = 1;
}


function increment_quantity(){ 
	var current_quantity = jQuery('#qty-field').val();
	if(isNaN(current_quantity) || current_quantity<=0){ 
		jQuery('#qty-field').val(defaultProductQty);
	}else{
		jQuery('#qty-field').val(parseInt(current_quantity) + 1);
		/*parseInt(<?php echo $minimum;?>)*/
	}
}

function decrement_quantity(){
	var current_quantity = jQuery('#qty-field').val();
	if(isNaN(current_quantity)  || current_quantity<=0){ 
		jQuery('#qty-field').val(defaultProductQty);
	}else{
		if ((current_quantity > 1) && (current_quantity > defaultProductQty)){
			jQuery('#qty-field').val(parseInt(current_quantity)-1);
			/*parseInt(<?php echo $minimum; ?>)*/
		}
	}
}

$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).text('<?php echo $text_loading; ?>');
				},
				complete: function() {
					$(node).text('<?php echo $button_upload; ?>');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').html('Submitting');
		},
		complete: function() {
			$('#button-review').html('<?php echo $button_continue; ?>');
		},
		success: function(json) {
			$('.alert-success, .alert-danger, .text-danger').remove();

			if (json['error']) {
				$('#form-review').prepend('<div class="text-danger"><div class="gap"></div><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
            
            /* if (json['error']) {
					$('#form-review .g-recaptcha').after('<div class="text-danger"><div class="gap"></div><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
            } */
			
			if (json['success']) {
				$('#form-review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>');
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				if(json['captcha']=="reload"){
					setTimeout(function() {
					window.location.href = "<?php echo $current_page_url; ?>";
					}, 5000);
				}
			}
		}
	});
});

$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});

$(document).ready(function() {
	$('#product-gallery').eagleGallery({
		openGalleryStyle: 'transform',
		changeMediumStyle: true
	});
	
	$('.rating_inputs li').bind('click', function(){
		var checked_li_index = 1;
		checked_li_index += $(this).index();
		checked_li_index = parseInt(checked_li_index);
		var leftTickCounter = 5;
		var tickCounter = 0;
		if(!$(this).hasClass('selected')){
			for(var icount = 0, ckCount=1; ckCount<=checked_li_index; icount++, ckCount++){//select
				$('.rating_inputs li').eq(icount).addClass('selected');
				tickCounter++;
				leftTickCounter--;
			}
		}
		else{
			if($(this).hasClass('selected')){
				for(var icount = parseInt(checked_li_index); icount<5; icount++){
					$('.rating_inputs li').eq(icount).removeClass('selected');
					tickCounter++;
					leftTickCounter--;
				}
			}
		}
		$('#ratingCount').val(checked_li_index);
		
	});
	
});

</script>
<!-- Go to www.addthis.com/dashboard to customize your tools -->
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-573342bfbfdc7b4a"></script>
<?php echo $footer; ?>