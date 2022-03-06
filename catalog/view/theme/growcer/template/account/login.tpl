<?php echo $header; ?>
<!--body start here-->
<div id="body">
    <div style="background-image:url(<?php echo DIR_TEMPLATE_IMAGES;?>images/logBg.jpg);background-size:cover; background-position:center center;" class="userLogin">
        <div class="fix-container">
            <h2><?php echo $text_login_title_1; ?></h2>
            <h3><?php echo $text_login_title_2; ?></h3>
            <div class="loginForm">
                <div class="socialLogin ">
                    <?php if ($error_warning_verified) { ?>
                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning_verified; ?><button type="button" class="close"></button></div>
                    <div class="alert-after"></div>
                    <?php } ?>
                    <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close"></button></div>
                    <div class="alert-after"></div>
                    <?php } ?>
                    <?php if ($error_warning) { ?>
                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?><button type="button" class="close"></button></div>
                    <div class="alert-after"></div>
                    <?php } ?>

                    <?php
                        if($social_login_status == 1) {
                             echo $social_login;
                    ?>
                    <div class="choice"><span class="or"><?php echo $text_login_or; ?></span></div>
                    <?php
                        }
                    ?>
                </div>
                <form action="<?php echo $action; ?>" class="siteForm intu-form" method="post" enctype="multipart/form-data">
                    <table width="100%" cellspacing="0" cellpadding="0" class="formTable">
                        <tbody>
                            <tr>
                                <td><input type="email" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control"></td>
                                <td><input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control"></td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="<?php echo $button_login; ?>"></td>
                                <td>
                                    <div class="term">
                                        <label class="checkbox">
                                            <input type="checkbox" value="" name="remember_me">
                                            <i class="input-helper"></i><?php echo $text_remember_me; ?></label>
                                        <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a> </div>
                                    <?php if ($redirect) { ?>
                                    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                                    <?php } ?>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="btm-panal">
                                    <p><?php echo $text_singup_1; ?> <a href="<?php echo $register; ?>"><?php echo $text_singup_2; ?></a> <?php echo $text_singup_3; ?></p>
                                </td>
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