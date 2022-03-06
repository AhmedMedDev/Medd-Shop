<form class="siteForm form-horizontal">
<legend><?php echo ($text_checkout_shipping_method) ? $text_checkout_shipping_method : ''; ?></legend>
<?php if ($shipping_methods) { ?>
	
<p><?php echo $text_shipping_method; ?></p>
<div class="gap"></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<fieldset>
  <?php if ($shipping_methods) { ?>
  <?php foreach ($shipping_methods as $shipping_method) { ?>
  <p><strong><?php echo $shipping_method['title']; ?></strong></p>
  <?php if (!$shipping_method['error']) { ?>
  <?php foreach ($shipping_method['quote'] as $quote) { ?>
  <div class=""> 
    <!--div class="col-md-12 column"-->
    
    <div class="radio-wrap">
      <label class="radio">
        <?php if ($quote['code'] == $code || !$code) { ?>
        <?php $code = $quote['code']; ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" />
        <?php } else { ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" />
        <?php } ?>
        <i class="input-helper"></i> <?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
    </div>
    <div class="gap"></div>
  </div>
  <?php } ?>
  <?php } else { ?>
  <div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
  <?php } ?>
  <?php } ?>
  <?php } ?>
  
  <div class=""> 
    <!--div class="col-md-12 column"-->
      <p><strong><?php echo $text_comments; ?></strong></p>
	    <div class="gap"></div>
      <p>
        <textarea name="comment" class="height120"><?php echo $comment; ?></textarea>
      </p>
	    <div class="gap"></div>
      <div class="buttons">
        <div class="pull-right">
          <div class="gap"></div>
          <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary themeBtn" />
        </div>
      </div>
  </div>
</fieldset>
<form>
