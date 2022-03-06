<?php echo $header; ?>

<div id="login" class="login">
<div class="login-inner">
  <div class="logo-login"><img alt="" src="view/image/admin-login.png"></div>
  <div class="login-wrapper">
    <h3>Forgot <span> Your Password?</span></h3>
    <div class="form-login">
      <?php if ($success) { ?>
      <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="field-row">
          <div class="field">
            <div class="icon-svg"> <svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 216 216" style="enable-background:new 0 0 216 216;" xml:space="preserve">
              <path d="M108,0C48.353,0,0,48.353,0,108s48.353,108,108,108s108-48.353,108-108S167.647,0,108,0z M156.657,60L107.96,98.498
	L57.679,60H156.657z M161.667,156h-109V76.259l50.244,38.11c1.347,1.03,3.34,1.545,4.947,1.545c1.645,0,3.073-0.54,4.435-1.616
	l49.374-39.276V156z"/>
              </svg> </div>
            <input type="email" name="email" value=" " placeholder="E-Mail Address" />
          </div>
        </div>
        <div class="">
          <div class="field">
            <input type="submit" class="ripplelink" value="Reset" name="">
            <?php if ($redirect) { ?>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
            <?php } ?>
          </div>
        </div>
        <?php if ($login) { ?>
        <span class="forgot"><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></span>
        <?php } ?>
      </form>
    </div>
  </div> </div>
</div>
