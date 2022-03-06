<?php echo $header; ?>

  <!--body start here-->
  <div id="body">
    <div style="background-image:url(<?php echo DIR_TEMPLATE_IMAGES; ?>images/logBg.jpg);background-size:cover; background-position:center center;" class="userLogin">
      <div class="fix-container">
        <h2><?php echo $page_heading_title; ?></h2>
        <h3><?php echo $text_email; ?></h3>
        <div class="loginForm">
		   <?php if ($error_warning) { ?>
		  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
		  <?php } ?>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="siteForm intu-form">
            <table width="100%" cellspacing="0" cellpadding="0" class="formTable">
              <tbody>
                <tr>
					<td colspan="2">
					<input type="email" name="email" autocomplete="off" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
					</td>
                </tr>
                <tr>
					<td colspan="2"><?php echo isset($captcha) ? $captcha : ''; ?></td>
				</tr>
                <tr>
                  <td><input type="submit" value="<?php echo $button_submit; ?>"></td>
                  <td></td>
                </tr>
                <tr>
                  <td colspan="2" class="btm-panal"><a href="<?php echo $back; ?>"><strong><?php echo $button_back; ?></strong></a></td>
                </tr>
              </tbody>
            </table>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!--body end here--> 
  
<?php echo $footer; ?>