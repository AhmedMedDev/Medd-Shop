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
			<p class="sub-heading"><?php echo $text_description; ?></p>
			<div class="gap"></div>
			  <form class="form-horizontal siteForm no-left-right-margin">
				<div class="form-group">
				  <label class="col-sm-2 control-label" for="input-code"><?php echo $entry_code; ?></label>
				  <div class="col-sm-10">
					<textarea cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" id="input-code" class="form-control"><?php echo $code; ?></textarea>
				  </div>
				</div>
				<div class="form-group">
				  <label class="col-sm-2 control-label" for="input-generator"><span data-toggle="tooltip" title="<?php echo $help_generator; ?>"><?php echo $entry_generator; ?></span></label>
				  <div class="col-sm-10">
					<input type="text" name="product" value="" placeholder="<?php echo $entry_generator; ?>" id="input-generator" class="form-control" />
				  </div>
				</div>
				<div class="form-group">
				  <label class="col-sm-2 control-label" for="input-link"><?php echo $entry_link; ?></label>
				  <div class="col-sm-10">
					<textarea name="link" cols="40" rows="5" placeholder="<?php echo $entry_link; ?>" id="input-link" class="form-control"></textarea>
				  </div>
				</div>
			  </form>
			  <div class="buttons clearfix">
				<div class="pull-right"><a href="<?php echo $continue; ?>" class="themeBtn greenbtn"><?php echo $button_submit; ?></a></div>
			  </div>
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
$(document).ready(function(){
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
});
//--></script>
<?php echo $footer; ?>