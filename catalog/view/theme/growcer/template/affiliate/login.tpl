<?php echo $header; ?>
  <div id="body">
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?><button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>
  <?php } ?>
    <div style="background-image:url(<?php echo DIR_TEMPLATE_IMAGES;?>images/logBg.jpg);background-size:cover; background-position:center center;" class="userLogin">
		<div class="fix-container">
			<?php echo $column_left; ?>
			<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
			<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-9'; ?>
			<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
			<?php } ?>		
			<h2><?php echo $text_returning_affiliate; ?></h2>
			<h3><?php echo $text_i_am_returning_affiliate; ?></h3>
				<div class="loginForm">  
				
					  <form action="<?php echo $action; ?>" class="siteForm intu-form" method="post" enctype="multipart/form-data">
						<table width="100%" cellspacing="0" cellpadding="0" class="formTable">
						  <tbody>
							<tr>
								<td>
									<input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" required="required" />
								</td>
							  <td><input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" required="required" /></td>
							</tr>
							<tr>
							  <td><input type="submit" value="<?php echo $button_login; ?>"></td>
							  <td><div class="term">
								  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a> </div>
								  <?php if ($redirect) { ?>
								  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
								  <?php } ?>
							  </td>
							</tr>
							<tr>
								<td class="btm-panal" colspan="2">Don't have an account? <a href="<?php echo $register; ?>">Sign up</a> for free</td>
							</tr>
						  </tbody>
						</table>
					  </form>				
				
				
				</div>
		</div>
	</div>		
</div>
<?php echo $footer; ?>