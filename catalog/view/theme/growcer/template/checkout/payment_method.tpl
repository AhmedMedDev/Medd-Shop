<form class="siteForm form-horizontal">
<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?><button type="button" class="close" data-dismiss="alert"></button></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><?php echo $text_payment_method; ?></p>
<div class="gap"></div>
<?php foreach ($payment_methods as $payment_method) { ?>
<fieldset>
	<div class="radio-wrap">
	  <label class="radio">
		<?php if ($payment_method['code'] == $code || !$code) { ?>
		<?php $code = $payment_method['code']; ?>
		<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
		<?php } else { ?>
		<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
		<?php } ?>
		<i class="input-helper"></i> 
		<?php echo $payment_method['title']; ?>
		<?php if ($payment_method['terms']) { ?>
		(<?php echo $payment_method['terms']; ?>)
		<?php } ?>
	  </label>
	</div>
</fieldset>
<div class="gap"></div>
<?php } ?>
<?php } ?>
<p><strong><?php echo $text_comments; ?></strong></p>
<fieldset>
<textarea name="comment" rows="8" class="form-control height120"><?php echo $comment; ?></textarea>
<div class="gap"></div>
</fieldset>
<?php if ($text_agree) { ?>
<fieldset>
	<label class="checkbox"  for="shipping_address">
		<?php if ($agree) { ?>
		<input type="checkbox" name="agree" value="1" checked="checked" />
		<?php } else { ?>
		<input type="checkbox" name="agree" value="1" />
		<?php } ?>
	<i class="input-helper"></i> <?php echo $text_agree; ?></label>
    <div class="gap"></div>
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary themeBtn" />
  </div>
</div>
</fieldset>
<?php } else { ?>
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary themeBtn" />
  </div>
</div>
<?php } ?>
</form>
