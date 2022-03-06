<?php echo $header; ?>
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
	<div class="main-area">
		<div class="fix-container">
			<div class="heading"><?php echo $heading_title; ?></div>
			<?php if($products){ ?>
			<div class="head-bar">
				<div class="pull_left sort">
					<?php
							/* <div>
								<div class=""><a href="<?php echo $compare; ?>" id="compare-total"> <?php echo $text_compare; ?></a></div>
				<span class="showing"><?php echo $results; ?></span>
			</div> */
			?>
			<span class="s-by"> <?php echo $text_sort; ?> </span>
			<select onchange="location = this.value;" class="custom-filed">
				<?php foreach ($sorts as $sorts) { ?>
				<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
				<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
				<?php } ?>
				<?php } ?>
			</select>
		</div>
		<div class="pull_right">
			<div class="display-view"><a onclick="display('list');" title="<?php echo $button_list; ?>" data-toggle="tooltip" id="list-view" class="icn"><i>
						<svg viewBox="0 0 10 10" height="10" width="10" preserveAspectRatio="xMidYMid" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
							<path
								d="M3.349,9.436 L3.349,8.445 L9.999,8.445 L9.999,9.436 L3.349,9.436 ZM3.349,4.623 L9.999,4.623 L9.999,5.614 L3.349,5.614 L3.349,4.623 ZM3.349,0.504 L9.999,0.504 L9.999,1.495 L3.349,1.495 L3.349,0.504 ZM0.996,10.000 C0.447,10.000 0.001,9.552 0.001,8.999 C0.001,8.447 0.447,7.998 0.996,7.998 C1.545,7.998 1.991,8.447 1.991,8.999 C1.991,9.552 1.545,10.000 0.996,10.000 ZM0.996,5.960 C0.447,5.960 0.001,5.512 0.001,4.960 C0.001,4.407 0.447,3.958 0.996,3.958 C1.545,3.958 1.991,4.408 1.991,4.960 C1.991,5.512 1.545,5.960 0.996,5.960 ZM0.996,2.001 C0.447,2.001 0.001,1.552 0.001,1.000 C0.001,0.447 0.447,-0.002 0.996,-0.002 C1.545,-0.002 1.991,0.447 1.991,1.000 C1.991,1.552 1.545,2.001 0.996,2.001 Z" />
						</svg>
					</i> </a> <a onclick="display('grid');" class="icn active" title="<?php echo $button_grid; ?>" data-toggle="tooltip" id="grid-view"><i>
						<svg viewBox="0 0 9 9" height="9" width="9" preserveAspectRatio="xMidYMid" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
							<path
								d="M8.625,9.000 L5.625,9.000 C5.419,9.000 5.250,8.828 5.250,8.619 L5.250,5.577 C5.250,5.368 5.419,5.197 5.625,5.197 L8.625,5.197 C8.831,5.197 9.000,5.368 9.000,5.577 L9.000,8.619 C9.000,8.828 8.831,9.000 8.625,9.000 ZM8.250,5.957 L6.000,5.957 L6.000,8.239 L8.250,8.239 L8.250,5.957 ZM8.625,3.802 L5.625,3.802 C5.419,3.802 5.250,3.631 5.250,3.422 L5.250,0.380 C5.250,0.171 5.419,-0.000 5.625,-0.000 L8.625,-0.000 C8.831,-0.000 9.000,0.171 9.000,0.380 L9.000,3.422 C9.000,3.631 8.831,3.802 8.625,3.802 ZM8.250,0.760 L6.000,0.760 L6.000,3.042 L8.250,3.042 L8.250,0.760 ZM3.375,9.000 L0.375,9.000 C0.169,9.000 -0.000,8.828 -0.000,8.619 L-0.000,5.577 C-0.000,5.368 0.169,5.197 0.375,5.197 L3.375,5.197 C3.581,5.197 3.750,5.368 3.750,5.577 L3.750,8.619 C3.750,8.828 3.581,9.000 3.375,9.000 ZM3.000,5.957 L0.750,5.957 L0.750,8.239 L3.000,8.239 L3.000,5.957 ZM3.375,3.802 L0.375,3.802 C0.169,3.802 -0.000,3.631 -0.000,3.422 L-0.000,0.380 C-0.000,0.171 0.169,-0.000 0.375,-0.000 L3.375,-0.000 C3.581,-0.000 3.750,0.171 3.750,0.380 L3.750,3.422 C3.750,3.631 3.581,3.802 3.375,3.802 ZM3.000,0.760 L0.750,0.760 L0.750,3.042 L3.000,3.042 L3.000,0.760 Z" />
						</svg>
					</i> </a>
			</div>
		</div>
	</div>
	<style>
		.offerCap {
			background-color: rgba(0, 0, 0, 0.8);
			border-radius: 50%;
			bottom: 5px;
			color: #ffffff;
			font-size: 16px;
			font-weight: 700;
			height: 60px;
			padding: 13px;
			position: absolute;
			right: 5px;
			text-align: center;
			width: 60px;
		}

		.offerCap span {
			color: #fff;
			font-size: 18px;
			display: block;
			line-height: 1;
		}
	</style>
	<div class="products-listing boxes-4 productsListing">
		<ul>
			<?php
						foreach ($products as $product) {
						$discount = false;
						if(isset($product['special_without_currency']) && $product['special_without_currency']!=false){
								if($product['price_without_currency']>=$product['special_without_currency']){
									$discount = ceil((($product['price_without_currency']-$product['special_without_currency'])/($product['price_without_currency']))*100);
								}
							}
						?>
			<li>
				<div class="productBox">
					<div class="imgBlock">
						<div class="productImg">
							<a href="<?php echo $product['href']; ?>">
								<?php if ($product['thumb']) { ?>
								<img src="<?php echo $product['thumb']; ?>" class="img-effects" alt="<?php echo $product['name']; ?>" />
								<?php }else{ ?>
								<img src="catalog/view/theme/growcer/images/placeholder.png" class="img-effects" alt="<?php echo $product['name']; ?>" />
								<?php } ?>
							</a>
						</div>
						<div class="actionBtn">
							<a href="javascript:void(0)" class="squrBtn zoom-icon" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve">
									<g>
										<path
											d="M6.75,32.642h82.275L77.87,43.797c-0.683,0.683-0.683,1.791,0,2.475s1.791,0.683,2.475,0L94.487,32.13   c0.081-0.081,0.154-0.171,0.218-0.267c0.029-0.043,0.049-0.09,0.073-0.135c0.03-0.055,0.064-0.108,0.088-0.167   c0.024-0.058,0.038-0.118,0.055-0.178c0.015-0.05,0.034-0.097,0.044-0.149c0.045-0.226,0.045-0.459,0-0.686   c-0.01-0.051-0.029-0.099-0.044-0.149c-0.017-0.06-0.031-0.12-0.055-0.178c-0.024-0.059-0.058-0.112-0.088-0.167   c-0.025-0.045-0.044-0.092-0.073-0.135c-0.064-0.096-0.137-0.186-0.218-0.267L80.345,15.513c-0.683-0.683-1.791-0.683-2.475,0   s-0.683,1.792,0,2.475l11.155,11.155H6.75c-0.966,0-1.75,0.784-1.75,1.75S5.784,32.642,6.75,32.642z">
										</path>
										<path
											d="M93.25,67.358H10.975L22.13,56.203c0.683-0.683,0.683-1.792,0-2.475s-1.791-0.683-2.475,0L5.513,67.87   c-0.081,0.081-0.154,0.171-0.218,0.267c-0.029,0.043-0.049,0.09-0.073,0.135c-0.03,0.055-0.064,0.108-0.088,0.167   c-0.024,0.058-0.038,0.118-0.055,0.178c-0.015,0.05-0.034,0.097-0.044,0.149c-0.045,0.226-0.045,0.459,0,0.686   c0.01,0.051,0.029,0.099,0.044,0.149c0.017,0.06,0.031,0.12,0.055,0.178c0.024,0.059,0.058,0.112,0.088,0.167   c0.025,0.045,0.044,0.092,0.073,0.135c0.064,0.096,0.137,0.186,0.218,0.267l14.142,14.142c0.683,0.683,1.791,0.683,2.475,0   s0.683-1.791,0-2.475L10.975,70.858H93.25c0.966,0,1.75-0.784,1.75-1.75S94.216,67.358,93.25,67.358z">
										</path>
									</g>
								</svg>
							</a>
							<a href="javascript:void(0)" class="squrBtn fav-icon" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
								<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="369.486px" height="369.486px" viewBox="0 0 369.486 369.486"
									style="enable-background:new 0 0 369.486 369.486;" xml:space="preserve">
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
												C17.828,94.283,17.809,145.65,46.295,177.252z" />
										</g>
									</g>
								</svg>
							</a>
						</div>
						<?php if($discount){ ?>
						<div class="offerCap"><span><?php echo $discount; ?>%</span>OFF</div>
						<?php } ?>
					</div>

					<div class="infoBlock">
						<h2 class="title-name"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a></h2>
						<div class="rating">
							<?php
								if ($product['rating']) { ?>
							<ul>
								<?php for($i=1; $i<=5; $i++) {
										if($product['rating']>=$i) { $class='active'; } else{$class='in-active';}; ?>
								<li class="<?php echo $class; ?>">
									<svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"
										version="1.1">
										<g>
											<path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42" />
										</g>
									</svg>
								</li>
								<?php } ?>
							</ul>
							<?php }else{ ?>
							<ul>
								<?php for($i=1; $i<=5; $i++) { ?>
								<li class="in-active">
									<svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"
										version="1.1">
										<g>
											<path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42" />
										</g>
									</svg>
								</li>
								<?php } ?>
							</ul>
							<?php } ?>
						</div>
						<?php if ($product['price']) { ?>
						<div class="priceblock">
							<?php if (!$product['special']) { ?>
							<span class="current-price"><?php echo $product['price']; ?></span>
							<?php } else { ?>
							<span class="cros-price"><?php echo $product['price']; ?></span>
							<span class="current-price"><?php echo $product['special']; ?></span>
							<?php } ?>
						</div>
						<?php } ?>
						<div class="add-to-cart">
							<button type="button" class="themeBtn" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span class="txt"><?php echo $button_cart; ?></span> <i class="cartIcon">
									<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 459.529 459.529" style="enable-background:new 0 0 459.529 459.529;"
										xml:space="preserve">
										<g>
											<path d="M17,55.231h48.733l69.417,251.033c1.983,7.367,8.783,12.467,16.433,12.467h213.35c6.8,0,12.75-3.967,15.583-10.2
							l77.633-178.5c2.267-5.383,1.7-11.333-1.417-16.15c-3.117-4.817-8.5-7.65-14.167-7.65H206.833c-9.35,0-17,7.65-17,17
							s7.65,17,17,17H416.5l-62.9,144.5H164.333L94.917,33.698c-1.983-7.367-8.783-12.467-16.433-12.467H17c-9.35,0-17,7.65-17,17
							S7.65,55.231,17,55.231z" />
											<path d="M135.433,438.298c21.25,0,38.533-17.283,38.533-38.533s-17.283-38.533-38.533-38.533S96.9,378.514,96.9,399.764
							S114.183,438.298,135.433,438.298z" />
											<path d="M376.267,438.298c0.85,0,1.983,0,2.833,0c10.2-0.85,19.55-5.383,26.35-13.317c6.8-7.65,9.917-17.567,9.35-28.05
							c-1.417-20.967-19.833-37.117-41.083-35.7c-21.25,1.417-37.117,20.117-35.7,41.083
							C339.433,422.431,356.15,438.298,376.267,438.298z" />
										</g>
									</svg>
								</i> </button>
						</div>
					</div>
				</div>
			</li>

			<?php } ?>
		</ul>
	</div>
	<div class="gap"></div>
	<div class="clearfix"></div>
	<?php

					if(isset($data['pagination']) && $data['pagination']!=''){ ?>
	<div class="aligncenter">
		<div class="gap"><span id="loadmoreproducts"></span></div>
		<div class="gap"></div>
		<a class="themeBtn greenbtn" href="javascript:void(0);" id="load_more_btn"><?php echo isset($text_load_more) ? $text_load_more : 'Load More'; ?></a>
	</div>
	<?php } ?>

	<?php } else { ?>
	<div class="gap"></div>
	<div class="blank-info nothing-found"><?php echo $text_empty; ?></div>
	<div class="gap"></div>
	<?php } ?>

</div>
</div>
</div>
<script type="text/javascript">
	function display(view) {
		if (view == 'list') {
			if ($('.productsListing').hasClass('list-view')) {} else {
				$('.productsListing').removeClass('boxes-4');
				$('.productsListing').addClass('list-view');
				changeDisplayLayout('list');
				$('#grid-view').removeClass('active');
				$('#list-view').addClass('active');
			}
		} else {
			if ($('.productsListing').hasClass('boxes-4')) {} else {
				$('.productsListing').removeClass('list-view');
				$('.productsListing').addClass('boxes-4');
				changeDisplayLayout('grid');
				$('#list-view').removeClass('active');
				$('#grid-view').addClass('active');
			}
		}
	}

	function changeDisplayLayout(view) {
		if (view == 'list') {
			$('.productsListing > ul li').each(function(index, element) {
				var html = '';
				var imgBlock = $(element).find('.productBox .imgBlock').html();
				var title = $(element).find('.productBox .infoBlock .title-name').html();
				var rating = $(element).find('.productBox .infoBlock .rating').html();
				var priceblock = $(element).find('.productBox .infoBlock .priceblock').html();
				var add_to_cart = $(element).find('.productBox .infoBlock .add-to-cart').html();
				html += '<div class="imgBlock">' + imgBlock + '</div>';
				html += '<div class="desc-wrap">';
				html += '<h2 class="title-name">' + title + '</h2>';
				html += '<div class="rating">' + rating + '</div>';
				html += '</div>';

				if (typeof priceblock == 'undefined') {
					priceblock = '';
				}
				html += '<div class="price-btn-wrap">';
				html += '<div class="priceblock">' + priceblock + '</div>';
				html += '<div class="add-to-cart">' + add_to_cart + '</div>';
				html += '</div>';
				$(element).find('.productBox').html(html);
			});
		} else {
			$('.productsListing > ul li').each(function(index, element) {
				var html = '';
				var imgBlock = $(element).find('.productBox .imgBlock').html();
				var desc_wrap = $(element).find('.productBox .desc-wrap').html();
				var price_btn_wrap = $(element).find('.productBox .price-btn-wrap').html();
				html += '<div class="imgBlock">' + imgBlock + '</div>';
				html += '<div class="infoBlock">';
				html += desc_wrap;
				html += price_btn_wrap;
				html += '</div>';
				$(element).find('.productBox').html(html);
			});
		}
	}
	<?php if(isset($data['pagination']) && $data['pagination']!=''){ ?>

	$(document).ready(function() {

		var scrollFlag = true;
		var loadingData = false;
		var page = 2;

		function loadProducts(page_number) {
			if (loadingData) {
				return;
			}

			var display_view = '';
			$('span#loadmoreproducts').html('<?php echo $text_loading; ?>');
			$('.display-view a').each(function(index, element) {
				if ($(element).hasClass('active')) {
					display_view = $(element).attr('id');
				}
			});

			if (page_number > <?php echo $total_pages ?>) {
				$('span#loadmoreproducts').html('');
				$('#load_more_btn').remove();
				return false;
			}

			page_url = '<?php echo $pagination_url;?>&page=' + page_number + '&display_view=' + display_view;
			$.get(page_url, function(data) {
				if (data != "") {
					$(".productsListing > ul > li").last().after(data);
				} else {
					$('#load_more_btn').remove();
					scrollFlag = false;
				}
				page++;

				if (page > <?php echo $total_pages ?>) {
					$('span#loadmoreproducts').html('');
					$('#load_more_btn').remove();
					return false;
				}

				$('span#loadmoreproducts').html('');
				loadingData = false;
			});
		}


		$('#load_more_btn').bind("click", function() {
			loadProducts(page);
			loadingData = true;
		});


		var lastScroll = 0;
		$(window).scroll(function() {
			if (scrollFlag == true) {
				var currentScroll = $(this).scrollTop();
				if (currentScroll > lastScroll) {
					var wintop = $(window).scrollTop(),
						docheight = $(document).height(),
						winheight = $(window).height();
					var scrolltrigger = 0.60;

					if ((wintop / (docheight - winheight)) > scrolltrigger) {
						loadProducts(page);
						loadingData = true;
					}
				}
				lastScroll = currentScroll;
			}
		});

	});
	<?php } ?>
</script>
<?php echo $footer; ?>