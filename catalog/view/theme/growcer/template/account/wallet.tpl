<?php echo $header; ?>
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
	  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close"></button></div><div class="alert-after"></div>
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
		  
			<div class="dash-page-content" id="wallet_form">
				
					<label>Add Money</label>
					<input type="text" placeholder="Add Amount" name="wallet_amount" value="10" />
					<input value="Continue" id="button-wallet" data-loading-text="Loading..." class="btn btn-primary themeBtn" type="button">
				<?php //echo $payment; ?>
			
			</div>
			</div>
			
		 </div>
		</div> 
	</div>
</div>
<script>
// Payment Address
$(document).delegate('#button-wallet', 'click', function() {
	$.ajax({
		url: 'index.php?route=account/payment_method',
		dataType: 'html',
		beforeSend: function() {
			$('#button-wallet').val('Loading..');
		},
		success: function(html) {
			$('#wallet_form').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$(document).delegate('#button-wallet-payment-method', 'click', function() {
    $.ajax({
		url: 'index.php?route=account/confirm',
		dataType: 'html',
		beforeSend: function() {
			$('#button-wallet-payment-method').val('Loading..');
		},
		complete: function() {
			$('#button-wallet-payment-method').val('Continue');
		},
		success: function(html) {
			$('#wallet_form').html(html);

			/* $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

			$('a[href=\'<?php echo $current_page_url; ?>#collapse-checkout-confirm\']').trigger('click'); */
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
</script>
<?php echo $footer; ?>