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
	
	<div class="dash-pages">
		<div class="fix-container">
			<div class="row">
			  <div class="col-md-12">
			  &nbsp;
			  <?php echo $content_top; ?>
			  </div>
			</div>
			<div class="row">
				<div class="col-md-3 column">
					<div class="left-panel">
						<?php echo $account_sidebar; ?>
					</div>
				</div>
				<div class="col-md-9 column">
					<section class="tab_content_wrapper">
						 <div class="tab_content" id="recurring">
							<div class="heading"><?php echo $heading_title; ?></div>
							
							
							<div class="tbl-scroll">
							<table class="tbl-normal tbl-responsive">
							  <thead>
								<tr>
								  <th><?php echo $column_image; ?></th>
								  <th><?php echo $column_name; ?></th>
								  <th><?php echo $column_model; ?></th>
								  <th><?php echo $column_stock; ?></th>
								  <th><?php echo $column_price; ?></th>
								  <th><?php echo $column_action; ?></th>
								</tr>
							  </thead>
							  <tbody>
								<?php if ($products) { ?>
								<?php foreach ($products as $product) { ?>
								  <tr>
									<td class="text-center"><?php if ($product['thumb']) { ?>
									 <span class="cellcaption"><?php echo $column_image; ?></span>
									  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
									  <?php }else{ ?>
									  <span class="cellcaption"><?php echo $column_image; ?></span>
										<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
									  <?php } ?>
									  </td>
									<td>
									<span class="cellcaption"><?php echo $column_name; ?></span>
									<span class="pro-mame"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></span></td>
									<td><span class="cellcaption"><?php echo $column_model; ?></span>
									<?php echo $product['model']; ?></td>
									<td><span class="cellcaption"><?php echo $column_stock; ?></span>
									<?php echo $product['stock']; ?></td>
									<td><span class="cellcaption"><?php echo $column_price; ?></span>
									<div class="priceblock">
									<?php if ($product['price']) { ?>
									  
										<?php if (!$product['special']) { ?>
										<span class="current-price"><?php echo $product['price']; ?></span>
										<?php } else { ?>
										<span class="cros-price"><?php echo $product['special']; ?></span> 
										<span class="current-price"><?php echo $product['price']; ?></span>
										<?php } ?>
									  <?php } ?>
									 </div> 								  
									  
									  </td>
									<td>
										<span class="cellcaption"><?php echo $column_action; ?></span>
										<div class="btn-action"> 
										<a onclick="cart.add('<?php echo $product['product_id']; ?>');" href="javascript:void(0)" title="<?php echo $button_cart; ?>" class="action"><i class="icon">
                        <svg xml:space="preserve" style="enable-background:new 0 0 2138.327 2138.327;" viewBox="0 0 2138.327 2138.327" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
                          <path d="M1032.925,1852.654c0,98.076-79.506,177.583-177.583,177.583S677.76,1950.73,677.76,1852.654
	c0-98.076,79.506-177.583,177.583-177.583S1032.925,1754.578,1032.925,1852.654z M1574.387,1675.072
	c-98.076,0-177.583,79.507-177.583,177.583c0,98.076,79.507,177.583,177.583,177.583c98.076,0,177.583-79.507,177.583-177.583
	C1751.969,1754.578,1672.463,1675.072,1574.387,1675.072z M2125.619,841.423l-218.512,649.464c0,0-18.088,96.383-110.247,96.383
	s-993.407,0-1103.389,0s-114.604-120.809-114.604-120.809S461.624,596.637,455.814,544.088s-73.013-91.498-73.013-91.498
	L93.651,317.522c-158.306-82.784-86.349-240.298,0-204.121c366.652,172.961,536.973,258.122,547.932,326.25
	c11.091,68.26,30.367,232.64,30.367,232.64v1.056c2.245-0.66,3.829-1.056,3.829-1.056s1124.382,0,1351.477,0
	C2190.447,672.291,2125.619,841.688,2125.619,841.423z M1809.535,1203.058l-2.245,0.132H737.57L759.619,1378h997.896
	L1809.535,1203.058z M1913.708,850.534H693.339l23.502,186.825c234.092,0,919.601,0,1141.678,0L1913.708,850.534z"/>
                        </svg>
                        </i> </a> 
						<a href="<?php echo $product['remove']; ?>" title="<?php echo $button_remove; ?>" class="action"> <i class="icon">
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
                        </i> </a> </div>
									</td>
								  </tr>
								<?php } ?>
								<?php } else { ?>
									<tr>
									  <td colspan="6">
										<?php echo $text_empty; ?>
									  </td>
									</tr>
									<?php } ?>
							  </tbody>
							</table>
							</div>
							
						</div>
					</section>
					<div class="gap"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					&nbsp;
					<?php echo $content_bottom; ?>
				</div>
			</div>
		</div>
	</div>
	
</div>
<?php echo $footer; ?>