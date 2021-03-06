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
				  <legend><?php echo $text_your_payment; ?></legend>
				  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-tax"><?php echo $entry_tax; ?></label>
					<div class="col-sm-10">
					  <input type="text" name="tax" value="<?php echo $tax; ?>" placeholder="<?php echo $entry_tax; ?>" id="input-tax" class="form-control" required="required"  />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-sm-2 control-label"><?php echo $entry_payment; ?></label>
					<div class="col-sm-9">
						<ul class="radio-wrap">
						  <li>
							<label class="radio">
							  <?php if ($payment == 'cheque') { ?>
							  <input type="radio" name="payment" value="cheque" checked="checked" />
							  <?php } else { ?>
							  <input type="radio" name="payment" value="cheque" />
							  <?php } ?>							
							  <i class="input-helper"></i><?php echo $text_cheque; ?></label>
						  </li>
						  <li>
							<label class="radio">
							  <?php if ($payment == 'paypal') { ?>
							  <input type="radio" name="payment" value="paypal" checked="checked" />
							  <?php } else { ?>
							  <input type="radio" name="payment" value="paypal" />
							  <?php } ?>
							  <i class="input-helper"></i><?php echo $text_paypal; ?></label>
						  </li>
						  <li>
							<label class="radio">
							  <?php if ($payment == 'bank') { ?>
							  <input type="radio" name="payment" value="bank" checked="checked" />
							  <?php } else { ?>
							  <input type="radio" name="payment" value="bank" />
							  <?php } ?>
							  <i class="input-helper"></i><?php echo $text_bank; ?></label>
						  </li>
						</ul>
					</div>
				  </div>
				  <div class="form-group payment" id="payment-cheque">
					<label class="col-sm-2 control-label" for="input-cheque"><?php echo $entry_cheque; ?></label>
					<div class="col-sm-10">
					  <input type="text" name="cheque" value="<?php echo $cheque; ?>" placeholder="<?php echo $entry_cheque; ?>" id="input-cheque" class="form-control" />
					</div>
				  </div>
				  <div class="form-group payment" id="payment-paypal">
					<label class="col-sm-2 control-label" for="input-paypal"><?php echo $entry_paypal; ?></label>
					<div class="col-sm-10">
					  <input type="text" name="paypal" value="<?php echo $paypal; ?>" placeholder="<?php echo $entry_paypal; ?>" id="input-paypal" class="form-control" />
					</div>
				  </div>
				  <div class="payment" id="payment-bank">
					<div class="form-group">
					  <label class="col-sm-2 control-label" for="input-bank-name"><?php echo $entry_bank_name; ?></label>
					  <div class="col-sm-10">
						<input type="text" name="bank_name" value="<?php echo $bank_name; ?>" placeholder="<?php echo $entry_bank_name; ?>" id="input-bank-name" class="form-control" />
					  </div>
					</div>
					<div class="form-group">
					  <label class="col-sm-2 control-label" for="input-bank-branch-number"><?php echo $entry_bank_branch_number; ?></label>
					  <div class="col-sm-10">
						<input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" placeholder="<?php echo $entry_bank_branch_number; ?>" id="input-bank-branch-number" class="form-control" />
					  </div>
					</div>
					<div class="form-group">
					  <label class="col-sm-2 control-label" for="input-bank-swift-code"><?php echo $entry_bank_swift_code; ?></label>
					  <div class="col-sm-10">
						<input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" placeholder="<?php echo $entry_bank_swift_code; ?>" id="input-bank-swift-code" class="form-control" />
					  </div>
					</div>
					<div class="form-group">
					  <label class="col-sm-2 control-label" for="input-bank-account-name"><?php echo $entry_bank_account_name; ?></label>
					  <div class="col-sm-10">
						<input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" placeholder="<?php echo $entry_bank_account_name; ?>" id="input-bank-account-name" class="form-control" />
					  </div>
					</div>
					<div class="form-group">
					  <label class="col-sm-2 control-label" for="input-bank-account-number"><?php echo $entry_bank_account_number; ?></label>
					  <div class="col-sm-10">
						<input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" placeholder="<?php echo $entry_bank_account_number; ?>" id="input-bank-account-number" class="form-control" />
					  </div>
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
$('input[name=\'payment\']').on('change', function() {
    $('.payment').hide();

    $('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');

//--></script>
<?php echo $footer; ?>