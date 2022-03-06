<?php if (count($products)>0) {  ?>
<section class="">
    <div class="fix-container">
        <div class="offerblock clearfix">
          <div class="grid left_grid">
            <div class="offer-value orangeBg">
              <?php echo $html_block_offers; ?>
            </div>
          </div>
          <div class="grid rght_grid">
            <div class="product-offer-block">
				<div class="product-slider">
					<div class="offer-slider">
						<?php  
						foreach ($products as $product) { ?>
						<?php 
							$discount = false;
							if(isset($product['special_without_currency']) && $product['special_without_currency']!=false){
								if($product['price_without_currency']>=$product['special_without_currency']){
									$discount = ceil((($product['price_without_currency']-$product['special_without_currency'])/($product['price_without_currency']))*100);
								}
							}
						?>
						<div class="slide_Box">
							<div class="productBox"> <a href="<?php echo $product['href']; ?>">
							  <div class="imgBlock">
								<div class="productImg">
									<?php if(isset($product['thumb']) && $product['thumb']!=''){ ?>
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-effects img-responsive" />
									<?php }else{ ?>
										<img src="catalog/view/theme/growcer/images/placeholder.png" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-effects img-responsive" />
									<?php } ?>
								</div>
								<?php if($discount){ ?>
								<div class="offerCap"><span><?php echo $discount; ?>%</span>OFF</div>
								<?php } ?>
							  </div>
							  <div class="infoBlock">
								<h2 class="title-name"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo (strlen($product['name'])>15) ? substr($product['name'], 0, 15).'...' : $product['name']; ?></a></h2>
								<div class="rating">
								<?php if ($product['rating']) { ?>
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
									<?php if (!$product['special']) { ?>                            	        
											<span class="current-price"><?php echo $product['price']; ?></span>
									  <?php } else { ?>
											<span class="cros-price"><?php echo $product['price']; ?></span>
											<span class="current-price"><?php echo $product['special']; ?></span>
									<?php } ?>						
									</div>
								<?php } ?>
							  </div>
							  </a> </div>
						  </div>
						<?php
						}
						?>
					</div>
				</div>
			</div>
		  </div>
		</div>
  </div>
</section>
<?php } ?>