<?php echo $header; ?>

<div id="login" class="login">
  <div class="login-inner">
    <div class="logo-login">
        <?php
        if($admin_logo) { ?>           
            <img alt="" src="<?php echo $base.'image/'.$admin_logo;?>" width="213">
        <?php }
        else { ?>
            <img alt="" src="view/image/admin-login.png">
        <?php }
        ?>
        
    </div>
    <div class="login-wrapper">
      <h3>Login <span>Please fill your basic information</span></h3>
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
              <div class="icon-svg"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 24 24" style="enable-background:new 0 0 24 24;" xml:space="preserve">
                <g>
                  <path   d="M12,11.953c-0.665,0-1.203,0.518-1.203,1.156c0,0.427,0.243,0.795,0.601,0.996v1.316
		C11.398,15.74,11.669,16,12,16s0.602-0.26,0.602-0.578v-1.316c0.358-0.201,0.602-0.569,0.602-0.996
		C13.203,12.471,12.665,11.953,12,11.953z"/>
                  <path  d="M12,0C5.373,0,0,5.373,0,12s5.373,12,12,12s12-5.373,12-12S18.627,0,12,0z M12,5
		c2.393,0,4,1.607,4,4h-1.25c0-1.519-1.231-2.75-2.75-2.75S9.25,7.481,9.25,9H8C8,6.607,9.607,5,12,5z M17,16.5
		c0,0.828-0.672,1.5-1.5,1.5h-7C7.672,18,7,17.328,7,16.5v-5C7,10.672,7.672,10,8.5,10h7c0.828,0,1.5,0.672,1.5,1.5V16.5z"/>
                </g>
                </svg> </div>
              <input type="text" name="username" value="" placeholder="<?php echo $entry_username; ?>" id="input-username"  />
            </div>
          </div>
          <div class="field-row">
            <div class="field">
              <div class="icon-svg"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 44 44" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 44 44">
                <g>
                  <circle cx="18" cy="26" r="5"/>
                  <path d="m22,0c-12.2,0-22,9.8-22,22s9.8,22 22,22 22-9.8 22-22-9.8-22-22-22zm12.7,12.1l-8.8,8.8c-0.2,0.2-0.2,0.4-0.1,0.6 0.8,1.3 1.2,2.8 1.2,4.5 0,5-4,9-9,9s-9-4-9-9 4-9 9-9c1.6,0 3.1,0.4 4.5,1.2 0.2,0.1 0.4,0.1 0.6-0.1l.8-.8c0.2-0.2 0.2-0.5 0-0.7l-.5-.5c-0.4-0.4-0.4-1 0-1.4l1.4-1.4c0.4-0.4 1-0.4 1.4,0l.5,.5c0.2,0.2 0.5,0.2 0.7,0l.5-.5c0.2-0.2 0.2-0.5 0-0.7l-.5-.5c-0.4-0.4-0.4-1 0-1.4l1.4-1.4c0.2-0.2 0.5-0.3 0.7-0.3s0.5,0.1 0.7,0.3l.5,.5c0.2,0.2 0.5,0.2 0.7,0l.5-.5c0.2-0.2 0.5-0.3 0.7-0.3s0.5,0.1 0.7,0.3l1.4,1.4c0.2,0.2 0.3,0.5 0.3,0.7s-0.1,0.5-0.3,0.7z"/>
                </g>
                </svg> </div>
              <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" />
            </div>
          </div>
          <div class="">
            <div class="field">
              <input type="submit" class="ripplelink" value="Sign In" name="">
              <?php if ($redirect) { ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
            </div>
          </div>
          <?php if ($forgotten) { ?>
          <span class="forgot"><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></span>
          <?php } ?>
        </form>
      </div>
    </div>
  </div>
</div>
