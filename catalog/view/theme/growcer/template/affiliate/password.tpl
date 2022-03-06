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
	<?php if (isset($success)) { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>
		</div>
	  </div>
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
			<?php echo $content_top; ?>
			<div class="heading"><?php echo $heading_title; ?></div>
			  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal siteForm no-left-right-margin">
				<fieldset>
				  <legend><?php echo $text_password; ?></legend>
				  <div class="form-group required">
					<label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>
					<div class="col-sm-10">
					  <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" required="required" />
					  <?php if ($error_password) { ?>
					  <div class="text-danger"><?php echo $error_password; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-sm-2 control-label" for="input-confirm"><?php echo $entry_confirm; ?></label>
					<div class="col-sm-10">
					  <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" required="required"  />
					  <?php if ($error_confirm) { ?>
					  <div class="text-danger"><?php echo $error_confirm; ?></div>
					  <?php } ?>
					</div>
				  </div>
				</fieldset>
				<div class="buttons clearfix">
				  <div class="pull-left"><a href="<?php echo $back; ?>" class="themeBtn graybtn"><?php echo $button_back; ?></a></div>
				  <div class="pull-right">
					<input type="submit" value="<?php echo $button_submit; ?>" class="themeBtn greenbtn" />
				  </div>
				</div>
			  </form>
			  <?php echo $content_bottom; ?>			
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
  <!--body end here--> 
<!-- jQueryTab.js --> 
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['link']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'product\']').val(item['label']);
		$('textarea[name=\'link\']').val(item['value']);
	}
});
//--></script>
<?php echo $footer; ?>