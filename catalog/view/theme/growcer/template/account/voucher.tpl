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
				<div class="heading">
				<?php echo $heading_title; ?>
				</div>
				<p><?php echo $text_description; ?></p>
				<div class="clearfix"></div>
				<div class="gap"></div>
				<div class="col-md-12 column">
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="siteForm form-horizontal">
						<fieldset>
						<div class="form-group required">
						  <label class="col-md-3 control-label" for="input-to-name"><?php echo $entry_to_name; ?></label>
						  <div class="col-md-9">
							<input type="text" name="to_name" value="<?php echo $to_name; ?>" id="input-to-name" class="form-control" />
							<?php if ($error_to_name) { ?>
							<div class="text-danger"><?php echo $error_to_name; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="form-group required">
						  <label class="col-md-3 control-label" for="input-to-email"><?php echo $entry_to_email; ?></label>
						  <div class="col-md-9">
							<input type="text" name="to_email" value="<?php echo $to_email; ?>" id="input-to-email" class="form-control" />
							<?php if ($error_to_email) { ?>
							<div class="text-danger"><?php echo $error_to_email; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="form-group required">
						  <label class="col-md-3 control-label" for="input-from-name"><?php echo $entry_from_name; ?></label>
						  <div class="col-md-9">
							<input type="text" name="from_name" value="<?php echo $from_name; ?>" id="input-from-name" class="form-control" />
							<?php if ($error_from_name) { ?>
							<div class="text-danger"><?php echo $error_from_name; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="form-group required">
						  <label class="col-md-3 control-label" for="input-from-email"><?php echo $entry_from_email; ?></label>
						  <div class="col-md-9">
							<input type="text" name="from_email" value="<?php echo $from_email; ?>" id="input-from-email" class="form-control" />
							<?php if ($error_from_email) { ?>
							<div class="text-danger"><?php echo $error_from_email; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="form-group required">
						  <label class="col-md-3 control-label"><?php echo $entry_theme; ?></label>
						  <div class="col-md-9">
							<ul class="radio-wrap">	
							<?php foreach ($voucher_themes as $voucher_theme) { ?>
							<?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id) { ?>
							<li>
								<label class="radio">
								<input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked"/>
								<i class="input-helper"></i><?php echo $voucher_theme['name']; ?></label>
							</li>
							<?php } else { ?>
							<li>
								<label class="radio">
								<input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>"/>
								<i class="input-helper"></i><?php echo $voucher_theme['name']; ?></label>
							</li>
							<?php } ?>
							<?php } ?>
							</ul>
							<?php if ($error_theme) { ?>
							<div class="text-danger"><?php echo $error_theme; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="form-group">
						  <label class="col-md-3 control-label" for="input-message"><span data-toggle="tooltip" title="<?php echo $help_message; ?>"><?php echo $entry_message; ?></span></label>
						  <div class="col-md-9">
							<textarea name="message" cols="40" rows="5" id="input-message" class="form-control"><?php echo $message; ?></textarea>
						  </div>
						</div>
						<div class="form-group">
						  <label class="col-md-3 control-label" for="input-amount"><span data-toggle="tooltip" title="<?php echo $help_amount; ?>"><?php echo $entry_amount; ?></span></label>
						  <div class="col-md-9">
							<input type="text" name="amount" value="<?php echo $amount; ?>" id="input-amount" class="form-control" size="5" />
							<?php if ($error_amount) { ?>
							<div class="text-danger"><?php echo $error_amount; ?></div>
							<?php } ?>
						  </div>
						</div>
						<div class="buttons clearfix">
						  <div class="pull-right"> 						  
							<div class="checkbox">	
								<label class="checkbox" for="agree">
								<?php if ($agree) { ?>
								<input type="checkbox" name="agree" value="1" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="agree" value="1" />
								<?php } ?>
								<i class="input-helper"></i>
								<?php echo $text_agree; ?>
								<?php if ($error_agree) { ?>
								<div class="text-danger"><?php echo $error_agree; ?></div>
								<?php } ?>
								</label>
							</div>
							&nbsp;
							<input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
						  </div>
						</div>
						</fieldset>
					  </form>
				</div>
				
				<div class="gap"></div>		
          </div>
        </div>
      </div>
    </div>
	<div class="row">
	  <div class="col-md-12 column">
		<?php echo $content_bottom; ?>
	  </div>
	</div>
  </div>
  <!--body end here--> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script>
<!-- jQueryTab.js --> 
<script type="text/javascript">
// initializing jQueryTab plugin 
$('.dashboard-tabs').jQueryTab({
    initialTab:1,				// tab to open initially; start count at 1 not 0
	tabInTransition: 'fadeIn',
    tabOutTransition: 'fadeOut',
    cookieName: 'active-tab-1' 
     
}); 
</script>
<?php echo $footer; ?>