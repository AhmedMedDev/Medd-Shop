<?php echo $header; ?>
 <!--body start here-->
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
		<div class="row">
		  <div class="col-md-12">
		  &nbsp;
		  <?php echo $content_top; ?>
		  </div>
		</div>
        <div class="heading"><?php echo $heading_title; ?></div>
      <div class="tbl-scroll">  
	  <?php if ($products) { ?>
	  <table class="tbl-normal tbl-responsive tbl-comparison">
          <thead>
            <tr>
              <th colspan="<?php echo count($products) + 1; ?>"><strong><?php echo $text_product; ?></strong></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><?php echo $text_name; ?></td>
			  <?php foreach ($products as $product) { ?>
              <td class="pro-mame">
				<a href="<?php echo $product['href']; ?>"><strong><?php echo $product['name']; ?></strong></a>
			  </td>
			   <?php } ?>
            </tr>
            <tr>
               <td><?php echo $text_image; ?></td>
				<?php foreach ($products as $product) { ?>
				  <td class="text-center">
					<div class="image-thumb-90">
					  <?php if (isset($product['thumb']) && $product['thumb']!='') { ?>
					  <img src="<?php echo $product['thumb']; ?>" class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" />
					  <?php }else{ ?>
					  <img src="catalog/view/theme/growcer/images/placeholder.png"  class="img-effects img-responsive img-thumbnail" alt="<?php echo $product['name']; ?>" />
					  <?php } ?>
					</div>
				  </td>
				<?php } ?>
            </tr>
            <tr>
			  <td><?php echo $text_price; ?></td>
				<?php  foreach ($products as $product) { ?>
				<td><?php if ($product['price']) { ?>
				  <?php if ($product['tax']) { ?>
											<div class="clear"></div>
											<small><?php echo $text_tax; ?> <?php echo $product['tax']; ?></small>
					<?php } ?>
				  <?php if (!$product['special']) { ?>
				  <?php echo $product['price']; ?>
				  <?php } else { ?>
				  <span class="price-old cros-price"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
				  <?php } ?>
				  <?php } ?></td>
				<?php } ?>
            </tr>
            <tr>
				<td><?php echo $text_model; ?></td>
				<?php foreach ($products as $product) { ?>
				<td><?php echo $product['model']; ?></td>
				<?php } ?>
            </tr>
            <tr>
				<td><?php echo $text_manufacturer; ?></td>
				<?php foreach ($products as $product) { ?>
				<td><?php echo $product['manufacturer']; ?></td>
				<?php } ?>
            </tr>
            <tr>
				<td><?php echo $text_availability; ?></td>
				<?php foreach ($products as $product) { ?>
				<td><?php echo $product['availability']; ?></td>
				<?php } ?>
            </tr>
			<?php if ($review_status) { ?>
            <tr>
              <td><?php echo $text_rating; ?></td>
			   <?php foreach ($products as $product) { ?>
              <td>
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
              <br />
			  <?php echo $product['reviews']; ?>
			  </td>
			  <?php } ?>
            </tr>
			<?php } ?>
            <tr>
				<td><?php echo $text_summary; ?></td>
				<?php foreach ($products as $product) { ?>
				<td class="description"><?php echo $product['description']; ?></td>
				<?php } ?>
            </tr>
            <tr>
				<td><?php echo $text_weight; ?></td>
				<?php foreach ($products as $product) { ?>
				<td><?php echo $product['weight']; ?></td>
				<?php } ?>
            </tr>
            <tr>
				<td><?php echo $text_dimension; ?></td>
				<?php foreach ($products as $product) { ?>
				<td><?php echo $product['length']; ?> x <?php echo $product['width']; ?> x <?php echo $product['height']; ?></td>
				<?php } ?>            
			</tr>
          </tbody>
           <?php foreach ($attribute_groups as $attribute_group) { ?>
			<thead>
			  <tr>
				<td colspan="<?php echo count($products) + 1; ?>"><strong><?php echo $attribute_group['name']; ?></strong></td>
			  </tr>
			</thead>
			<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
			<tbody>
			  <tr>
				<td><?php echo $attribute['name']; ?></td>
				<?php foreach ($products as $product) { ?>
				<?php if (isset($product['attribute'][$key])) { ?>
				<td><?php echo $product['attribute'][$key]; ?></td>
				<?php } else { ?>
				<td></td>
				<?php } ?>
				<?php } ?>
			  </tr>
			</tbody>
			<?php } ?>
			<?php } ?>
          <tbody>
            <tr>
              <td></td>
			  <?php foreach ($products as $product) { ?>
              <td><button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" class="themeBtn">
			  <span class="txt"><?php echo $button_cart; ?></span>
			  <i class="cartIcon">
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
                        </i>
			  </button>
                <a class="themeBtn graybtn" href="<?php echo $product['remove']; ?>"><?php echo $button_remove; ?></a></td>
			  <?php } ?> 
            </tr>
          </tbody>
        </table>
	  <?php } else { ?>
      <div class="blank-info nothing-found"><?php echo $text_empty; ?></div>
	  <div class="gap"></div>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="themeBtn"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
	   </div>
		<div class="gap"></div>
      </div>
      <!--slider--> 
      <section class="comn-padd">
		<div class="fix-container">
			<?php echo $content_bottom; ?>
		</div>
	  </section>
      <!--slider/--> 
    </div>
  </div>
  
  <!--body end here--> 
<?php echo $footer; ?>
