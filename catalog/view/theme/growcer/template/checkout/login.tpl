<div class="row">
  <div class="col-md-12">
    <div class="sub-heading"><?php echo $text_new_customer; ?></div>
	<div class="gap"></div>
    <p><?php echo $text_checkout; ?></p>
    <div class="gap"></div>
	<form class="siteForm form-horizontal">
	<div class="form-group">
			<div class="col-md-6 column">
			  <div class="radio-wrap">
				<label class="radio">
					<?php if ($account == 'register') { ?>
					<input type="radio" name="account" value="register" checked="checked" />
					<?php } else { ?>
					<input type="radio" name="account" value="register" />
					<?php } ?>
					<i class="input-helper"></i> <?php echo $text_register; ?>
				</label>
			  </div>
			</div>
			<?php if ($checkout_guest) { ?>
			<div class="col-md-6 column">
			  <div class="radio-wrap">
				<label class="radio">
					<?php if ($account == 'guest') { ?>
					<input type="radio" name="account" value="guest" checked="checked" />
					<?php } else { ?>
					<input type="radio" name="account" value="guest" />
					<?php } ?>
					<i class="input-helper"></i> <?php echo $text_guest; ?>
				</label>
			  </div>
			</div>
			<?php } ?>
	</div>
    <p><?php echo $text_register_account; ?></p>
	<div class="gap"></div>
    <input type="button" value="<?php echo $button_continue; ?>" id="button-account" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary themeBtn" />
	</form>
	<div class="gap"></div>
  </div>
  
  </div>
  
  <div class="gap"></div>
  <div class="divider"></div>
    <div class="gap"></div>
  <div class="row">
  <div class="col-md-12">
    <div class="sub-heading"><?php echo $text_returning_customer; ?></div>
	<div class="gap"></div>
    <p><?php echo $text_i_am_returning_customer; ?></p>
	<form class="siteForm form-horizontal">
    <div class="form-group">
	    <div class="col-md-12">
		  <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
		  <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control text-input" />
	    </div>
    </div>
    <div class="form-group">
		<div class="col-md-12">
		  <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
		  <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control text-input" />
		  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
		</div>
	</div>
    <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary themeBtn" />
	</form>
	<div class="gap"></div>
  </div>
  
</div>