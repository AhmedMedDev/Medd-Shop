<section class="comn-padd">
  <div class="fix-container">
	<div class="full-grid product-slide-block clearfix">
<?php if (count($products)>0) { $first_pro=$products[0]; ?>
<div class="grid pull_left">
	<div class="head_title">
		<h2><?php echo $heading_title; ?></h2>
	</div>
<div class="block">
<div class="new-product-block">
<div class="full-grid two-grid clearfix">

                  <div class="grid pull_left right-border">
                    <div class="productBox">
                      <div class="imgBlock">
                        <div class="productImg"><?php if ($first_pro['thumb']) { ?><a href="<?php echo $first_pro['href']; ?>"><img src="<?php echo $first_pro['thumb']; ?>" alt="<?php echo $first_pro['name']; ?>" /></a><?php } ?></div>
                        <div class="actionBtn"> <a href="#" class="squrBtn zoom-icon">
                          <svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
																	viewBox="0 0 611.997 611.998" style="enable-background:new 0 0 611.997 611.998;" xml:space="preserve">
                            <g>
                              <path d="M601.444,535.785L433.663,368.39c1.512-2.27,2.646-6.033,3.772-10.939c17.719-29.785,28.682-62.207,32.052-96.519
																			c0.772-7.915,1.126-16.208,1.126-24.13c0-26.012-4.343-52.088-13.19-77.665c-11.51-33.243-29.905-62.842-55.426-88.218
																			c-45.364-45.13-105.189-68.625-166.64-68.625c-60.702,0-120.801,23.607-166.269,68.625
																			c-30.315,30.009-50.391,65.633-61.08,105.938c-10.802,40.755-10.553,80.681,0,121.026c10.561,40.346,30.652,75.67,61.08,105.945
																			c45.355,45.131,105.567,68.617,166.269,68.617c47.125,0,89.964-13.625,129.688-38.455l6.033-3.771l168.529,168.15
																			c6.418,6.402,13.199,10.176,19.609,10.932c1.504,0.377,2.638,0.449,3.764,0.377c4.537-0.297,8.695-1.463,12.065-3.395
																			c4.552-2.598,9.427-6.41,14.703-11.686l7.544-7.537c5.276-5.285,9.089-10.158,11.688-14.703c1.922-3.369,3.016-7.922,3.016-13.576
																			v-3.018C611.997,549.345,608.048,542.373,601.444,535.785z M422.354,287.33c-8.848,33.131-25.634,62.207-50.52,87.092
																			c-36.194,36.188-84.832,56.553-136.478,56.553c-50.905,0-99.221-20.695-136.863-56.553c-73.957-70.466-73.651-202.198,0-273.34
																			c37.2-35.937,85.588-56.93,136.863-56.93c53.914,0,98.892,19.11,136.478,56.93c24.62,24.765,41.849,53.536,50.52,86.714
																			C431.024,220.973,431.226,254.103,422.354,287.33z"/>
                              <polygon points="258.353,138.401 212.732,138.401 212.732,214.563 136.571,214.563 136.571,260.184 212.732,260.184 
																			212.732,336.714 258.353,336.714 258.353,260.184 334.885,260.184 334.885,214.563 258.353,214.563 		"/>
                            </g>
                          </svg>
                          </a> <a href="javascript:void(0);" onclick="wishlist.add('<?php echo $first_pro['product_id']; ?>');" class="squrBtn fav-icon"><i class="icon ion-android-favorite-outline"></i></a> </div>
                      </div>
                      <div class="infoBlock align-center">
                        <h2 class="title-name"><a href="<?php echo $first_pro['href']; ?>"><?php echo $first_pro['name']; ?></a></h2>
						<?php if ($first_pro['rating']) { ?>
                        <div class="rating">
                          <ul>
							<?php for($i=1; $i<=5; $i++) {
								if($first_pro['rating']>=$i) { $class='active'; } else{$class='in-active';}; ?>
                            <li class="<?php echo $class; ?>">
                              <svg xml:space="preserve" enable-background="new 0 0 70 70" viewBox="0 0 70 70" height="18px" width="18px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg"  version="1.1">
                                <g>
                                  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"  />
                                </g>
                              </svg>
                            </li>
							<?php } ?>
                          </ul>
                        </div>
						<?php } ?>
                        <?php if ($first_pro['price']) { ?>
							<div class="priceblock"> 
							<?php if (!$first_pro['special']) { ?>                            	        
									<span class="current-price"><?php     echo $first_pro['price']; ?></span>
							  <?php } else { ?>
									<span class="cros-price"><?php echo $first_pro['price']; ?></span>
									<span class="current-price"><?php echo $first_pro['special']; ?></span>
							<?php } ?>						
							</div>
						<?php } ?>
                        <div class="add-to-cart"> <a href="javascript:void(0);"  onclick="cart.add('<?php echo $first_pro['product_id']; ?>');" class="themeBtn">Add  to Cart <span class="cartIcon">
                          <svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
				 viewBox="0 0 459.529 459.529" style="enable-background:new 0 0 459.529 459.529;" xml:space="preserve">
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
                      </div>
                    </div>
                  </div>
                  <div class="grid pull_right">
                    <div class="slideBlock">
                      <div class="prduct-sldr">
                        <div class="slideBox vertical-slider">
						<?php 
						$othr_products = array_shift($products);						
						foreach ($products as $product) { ?>
                          <div class="box"> <a href="<?php echo $product['href']; ?>" class="detail-box clearfix">
                            <div class="grid">
								<?php if ($product['thumb']) { ?>
								<div class="imgbox"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></div>
								<?php } ?>							                              
                            </div>
                            <div class="grid">
                              <div class="infoBlock">
                                <h2 class="title-name"><?php echo $product['name']; ?></h2>
                                <!--div class="qunty">200 GM</div-->
								<?php if ($product['price']) { ?>
								 <div class="priceblock">
								<?php if (!$product['special']) { ?>                            	        
										<span class="current-price"><?php  echo $product['price']; ?></span>
                            	  <?php } else { ?>
										<span class="cros-price"><?php echo $product['price']; ?></span>
										<span class="current-price"><?php echo $product['special']; ?></span>
								<?php } ?>
                                 </div>
								<?php } ?>
                              </div>
                            </div>
                            </a> </div>
						<?php } ?>
                        </div>
                      </div>
                    </div>
                  </div>
                
<?php /*
	<div class="row product-layout">
		<?php foreach ($products as $product) { ?>
			  <div class="AnyListDiv">
			    <div class="product-thumb transition">
                    <?php if ($product['thumb']) { ?>
                    <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                    <?php } ?>
                    <div>
                        <div class="caption">
                            <h4 style="height: 40px; overflow: hidden;"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                            <div style="height: 120px; overflow: auto;"><?php echo $product['description']; ?></div>

                            <?php if ($product['price']) { ?>
                            	<p class="price">
                            	  <?php if (!$product['special']) { ?>
                            	        <?php     echo $product['price']; ?>
                            	  <?php } else { ?>
                            	        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                            	  <?php } ?>
                                  <?php if ($product['tax']) { ?>
                                     <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                  <?php } ?>
                                  
                            	</p>
                            <?php } ?>
                            <?php if ($product['rating']) { ?>
                            <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
                            <?php } ?>
                        </div>
                        <div class="button-group">
                            <button class="btn-primary" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                            <button class="btn-wl" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                            <button class="btn-wl" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                        </div>
                    </div>
                </div>  
            </div>
        <?php } ?>
	</div>
	
	
	<script type="text/javascript">
		$(document).ready(
			function() {
				$('.AnyListDiv').each( 
					function(index) {
						var divclass = 'col-lg-12 col-md-12'; 
						if (($(this).closest('#column-right').length==0) && ($(this).closest('#column-left').length==0)) { // if we are in content area check the layout
							var cols = $('#column-right, #column-left').length; // how many columns we have
							// 2 columns - left, right and content - smallest content area - 2 boxes on row
							if (cols==2) 
								divclass = 'col-lg-6 col-md-6 col-sm-12 col-xs-12';
									
							// 1 column - left or right and content - 3 boxes on row	
							if (cols==1) 	
								divclass = 'col-lg-4 col-md-4 col-sm-8 col-xs-12';	
								
							// only content - largest content area - 4 boxes on row
							if (cols==0) 
								divclass = 'col-lg-3 col-md-3 col-sm-2 col-xs-12';	
						}
						$(this).addClass(divclass);
					}
				)
			}
		);
	</script>
*/?>
</div>
</div>
</div>
</div>
	
<?php } ?>
