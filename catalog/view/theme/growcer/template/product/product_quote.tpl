<a href="javascript:void(0);" class="productQuoteRequest md-trigger expand" data-modal="productQuoteRequest"></a>
<div id="productQuoteRequest" class="md-modal md-effect-1 md-show">
		<a class="md-close">
			<svg xml:space="preserve" style="enable-background:new 0 0 612 612;" viewBox="0 0 612 612" height="612px" width="612px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1">
				<g>
					<g id="cross">
						<g>
							<polygon points="612,36.004 576.521,0.603 306,270.608 35.478,0.603 0,36.004 270.522,306.011 0,575.997 35.478,611.397 
				306,341.411 576.521,611.397 612,575.997 341.459,306.011 			"/>
						</g>
					</g>
				</g>
			</svg>
		</a>
		<div class="md-content">
			<div class="custom-content">
				<div style="padding:25px;" class="cms">
					<h2><?php echo $heading_title; ?></h2>
					<p id="result"></p>
					<form method="post" id="productQuoteRequestFrm" enctype="multipart/form-data" class="siteForm form-horizontal">
						<div class="form-group">
							<label class="col-md-3 control-label"><?php echo $text_product; ?></label>
							<div class="col-md-7">
								<input type="text" name="product_name" <?php echo isset($product_quote_info['name']) ? 'value="'.$product_quote_info['name'].'" readonly' : '' ?> class="form-control"/>
								<span class="error_product_name text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label"><?php echo $text_quantity; ?></label>
							<div class="col-md-7">
								<input type="number" min="1" value="1" name="quantity" class="form-control"/>
								<span class="error_quantity text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $text_name; ?></label>
							<div class="col-md-7">
								<input required type="text"  name="name" value="<?php echo isset($entry_name) ? $entry_name : ''; ?>" class="form-control"/>
								<span class="error_name text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $text_email; ?></label>
							<div class="col-md-7">
								<input required type="email" value="<?php echo isset($entry_email) ? $entry_email : ''; ?>" name="email" class="form-control"/>
								<span class="error_email text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $text_phone; ?></label>
							<div class="col-md-7">
								<input maxlength="20" type="phone"  value="<?php echo isset($entry_phone) ? $entry_phone : ''; ?>" name="phone" class="form-control"/>
								<span class="error_phone text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $text_comments; ?></label>
							<div class="col-md-7">
								<textarea required name="comments" placeholder="<?php echo $text_comments_help;?>" class="height120 form-control"></textarea>
								<span class="error_comments text-danger"></span>
							</div>
							<div class="col-md-2"></div>
						</div>
						<?php if($captcha){ ?>
						<div class="form-group required">
								<div class="col-md-3"></div>
								<div class="col-md-7">
									<?php echo $captcha; ?>
									<span class="error_captcha text-danger"></span>
								</div>
								<div class="col-md-2"></div>
						</div>
						<?php } ?>
						<div class="form-group">
							<div class="col-md-3"></div>
							<div class="col-md-7">
							<input type="hidden" name="product_id" value="<?php echo isset($product_quote_info['product_id']) ? $product_quote_info['product_id'] : ''; ?>"/>
							<input type="hidden" name="url_referrer" value="<?php echo $url_referrer; ?>"/>
							<?php if(isset($route)){ ?>
							<input type="hidden" name="route" value="<?php echo $route; ?>"/>
							<?php } ?>
							<?php if(isset($type)){ ?>
							<input type="hidden" name="type" value="<?php echo $type; ?>"/>
							<?php } ?>
							<div class="iamhoneytrap">
							<input type="text" name="how_day" value=""/>
							</div>
							<input type="submit" onclick="submitProductQuote(event)" id="submitQBtn" value="<?php echo $text_button; ?>" class="themeBtn"/>
							</div>
							<div class="col-md-2"></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="md-overlay"></div>
	<script src="catalog/view/theme/growcer/js/modalEffects.js"></script>
	<script src="catalog/view/theme/growcer/js/classie.js"></script>
	<script>
		$('#productQuoteRequest .md-close').on('click', function(){
			$('#result').html('');
			$('#productQuoteRequest').removeClass('md-show');
		});
		$('.iamhoneytrap').hide();
	</script>