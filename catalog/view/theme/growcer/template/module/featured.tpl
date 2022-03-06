<section class="comn-padd">
  <div class="fix-container">
		<div class="featured-product clearfix">
			<div class="head_title">
				<h2><?php echo $heading_title; ?></h2>
			</div>
			<div class="slider-Block">
				<div class="products-listing featured-slider">
					<?php foreach ($products as $product) { ?>
					  <div class="slideItem">
						<div class="productBox">
						  <div class="imgBlock">
							<div class="productImg">
								  <a href="<?php echo $product['href']; ?>">	  
									<?php if(isset($product['thumb']) && $product['thumb']!=''){ ?>
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-effects img-responsive" />
									<?php }else{ ?>
										<img src="catalog/view/theme/growcer/images/placeholder.png"  alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-effects img-responsive" />
									<?php } ?>
								  </a>
							</div>
							<div class="actionBtn"> 
								<a href="javascript:void(0)" class="squrBtn zoom-icon" title="<?php echo $button_compare; ?>"  onclick="compare.add('<?php echo $product['product_id']; ?>');">
								<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve"><g><path d="M6.75,32.642h82.275L77.87,43.797c-0.683,0.683-0.683,1.791,0,2.475s1.791,0.683,2.475,0L94.487,32.13   c0.081-0.081,0.154-0.171,0.218-0.267c0.029-0.043,0.049-0.09,0.073-0.135c0.03-0.055,0.064-0.108,0.088-0.167   c0.024-0.058,0.038-0.118,0.055-0.178c0.015-0.05,0.034-0.097,0.044-0.149c0.045-0.226,0.045-0.459,0-0.686   c-0.01-0.051-0.029-0.099-0.044-0.149c-0.017-0.06-0.031-0.12-0.055-0.178c-0.024-0.059-0.058-0.112-0.088-0.167   c-0.025-0.045-0.044-0.092-0.073-0.135c-0.064-0.096-0.137-0.186-0.218-0.267L80.345,15.513c-0.683-0.683-1.791-0.683-2.475,0   s-0.683,1.792,0,2.475l11.155,11.155H6.75c-0.966,0-1.75,0.784-1.75,1.75S5.784,32.642,6.75,32.642z"></path><path d="M93.25,67.358H10.975L22.13,56.203c0.683-0.683,0.683-1.792,0-2.475s-1.791-0.683-2.475,0L5.513,67.87   c-0.081,0.081-0.154,0.171-0.218,0.267c-0.029,0.043-0.049,0.09-0.073,0.135c-0.03,0.055-0.064,0.108-0.088,0.167   c-0.024,0.058-0.038,0.118-0.055,0.178c-0.015,0.05-0.034,0.097-0.044,0.149c-0.045,0.226-0.045,0.459,0,0.686   c0.01,0.051,0.029,0.099,0.044,0.149c0.017,0.06,0.031,0.12,0.055,0.178c0.024,0.059,0.058,0.112,0.088,0.167   c0.025,0.045,0.044,0.092,0.073,0.135c0.064,0.096,0.137,0.186,0.218,0.267l14.142,14.142c0.683,0.683,1.791,0.683,2.475,0   s0.683-1.791,0-2.475L10.975,70.858H93.25c0.966,0,1.75-0.784,1.75-1.75S94.216,67.358,93.25,67.358z"></path></g></svg>
								</a> 
								<a href="javascript:void(0)" class="squrBtn fav-icon" title="<?php echo $button_wishlist; ?>"  onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
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
							<h2 class="title-name">
								<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
									<?php echo (strlen($product['name'])>15) ? substr($product['name'], 0, 15).'...' : $product['name']; ?>
								</a>
							</h2>
								<div class="rating">
									<?php 
									if ($product['rating']) { ?>
									<ul>
									<?php for($i=1; $i<=5; $i++) {
									if($product['rating']>=$i) { $class='active'; } else{$class='in-active';}; ?>			  
									<li class="<?php echo $class; ?>">
									<svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"  version="1.1">
									<g>
									<path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"  />
									</g>
									</svg>
									</li>
									<?php } ?>  
									</ul>
									<?php }else{ ?>
										 <ul>
											<?php for($i=1; $i<=5; $i++) { ?>
											<li class="in-active">
											  <svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"  version="1.1">
												<g>
												  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"  />
												</g>
											  </svg>
											</li>
											<?php } ?>
										  </ul>
									<?php } ?>  
								</div>
							<?php if ($product['price']) { ?>						
								<div class="priceblock"> 
									<?php 
									if (!$product['special']) { 
										?>
										<span class="current-price"><?php echo $product['price']; ?></span>
										<?php
									} else { ?>
										<span class="cros-price"><?php echo $product['price']; ?></span> 
										<span class="current-price"><?php echo $product['special']; ?></span> 
										<?php
									}
									?>								
									<br/>
									<?php
									if ($product['tax']) { ?>
									  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
									  <?php } ?>
								</div>														
								<?php } ?>
							<button type="button" class="themeBtn" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span class="txt"><?php echo $button_cart; ?></span> <i class="cartIcon">
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
						  </div>
						</div>
					  </div>
				  <!-- slide item -->
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</section>