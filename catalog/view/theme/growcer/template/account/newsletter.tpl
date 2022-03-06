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
					 <div class="row">
					  <div class="col-md-12">
						<div class="heading"><?php echo $heading_title; ?></div>
						<div class="gap"></div>
						<div class="siteForm">
						  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
							<fieldset>
							<legend><?php echo $entry_newsletter; ?></legend>
							<div class="required">
								<ul class="radio-wrap">
									<?php if ($newsletter) { ?>
										<li>
											<label class="radio">
											<input type="radio" name="newsletter" value="1" checked="checked"/>
											<i class="input-helper"></i><?php echo $text_yes; ?></label>
										</li>
										<li>
											<label class="radio">
											<input type="radio" name="newsletter" value="0" />
											<i class="input-helper"></i><?php echo $text_no; ?></label>
										</li>
									<?php }else{ ?>
										<li>
											<label class="radio">
											<input type="radio" name="newsletter" value="1"/>
											<i class="input-helper"></i><?php echo $text_yes; ?></label>
										</li>
										<li>
											<label class="radio">
											<input type="radio" name="newsletter" value="0"  checked="checked"/>
											<i class="input-helper"></i><?php echo $text_no; ?></label>
										</li>
									<?php } ?>
								</ul>
							</div>
							</fieldset>
							<div class="buttons">
							  <div class="pull-right">
								<a href="<?php echo $back; ?>" class="themeBtn graybtn"><?php echo $button_back; ?></a>
								<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
							  </div>
							</div>
							<div class="clearfix"></div>
						  </form>
						</div>
					  </div>
					</div>
					
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