<?php echo $header; ?>

<!--body start here-->
<div id="body">
    <div style="background-image:url(<?php echo DIR_TEMPLATE_IMAGES; ?>images/logBg.jpg);background-size:cover; background-position:center center;" class="userLogin">
        <div class="fix-container">
            <h2><?php echo $text_signup_title_1;?> <span><?php echo $text_signup_title_2;?></span></h2>
            <h3><?php echo $text_signup_title_3;?></h3>
            <div class="loginForm">
                <div class="socialLogin ">
                    <?php
                        if($social_login_status == 1) {
                            echo $social_login;
                    ?>
                    <div class="choice"><span class="or"><?php echo $text_signup_or;?></span></div>
                    <?php
                        }
                    ?>
                </div>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="siteForm intu-form">
                    <table width="100%" cellspacing="0" cellpadding="0" class="formTable">
                        <tr>
                            <td width="50%">
                                <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" />
                                <?php if ($error_firstname) { ?>
                                <div class="text-danger"><?php echo $error_firstname; ?></div>
                                <?php } ?>
                            </td>
                            <td width="50%">
                                <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />
                                <?php if ($error_lastname) { ?>
                                <div class="text-danger"><?php echo $error_lastname; ?></div>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
                                <?php if ($error_telephone) { ?>
                                <div class="text-danger"><?php echo $error_telephone; ?></div>
                                <?php } ?>
                            </td>
                            <td>
                                <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                <?php if ($error_email) { ?>
                                <div class="text-danger"><?php echo $error_email; ?></div>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                                <?php if ($error_password) { ?>
                                <div class="text-danger"><?php echo $error_password; ?></div>
                                <?php } ?>
                            </td>
                            <td>
                                <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" />
                                <?php if ($error_confirm) { ?>
                                <div class="text-danger"><?php echo $error_confirm; ?></div>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><?php echo $captcha; ?></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <?php if ($text_agree) { ?>
                                <div class="privacy-policy">
                                    <label class="checkbox">
                                        <?php if ($agree) { ?>
                                        <input type="checkbox" name="agree" value="1" checked="checked" />
                                        <?php } else { ?>
                                        <input type="checkbox" name="agree" value="1" />
                                        <?php } ?>
                                        <i class="input-helper"></i>
                                        <p><?php echo $text_agree;?></p>
                                    </label>
                                    <?php if ($error_warning) { ?>
                                    <div class="text-danger"><?php echo $error_warning; ?></div>
                                    <?php } ?>
                                </div>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="buttons clearfix">
                                    <div class="pull-right">
                                        <input type="submit" value="<?php echo $text_button_signup; ?>">
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <tr>

                            <td colspan="2" class="btm-panal">
                                <p><?php echo $text_account_already; ?></p>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<!--body end here-->
<script type="text/javascript">
    <!--
    // Sort the custom fields
    $('#account .form-group[data-sort]').detach().each(function() {
        if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#account .form-group').length) {
            $('#account .form-group').eq($(this).attr('data-sort')).before(this);
        }

        if ($(this).attr('data-sort') > $('#account .form-group').length) {
            $('#account .form-group:last').after(this);
        }

        if ($(this).attr('data-sort') < -$('#account .form-group').length) {
            $('#account .form-group:first').before(this);
        }
    });

    $('#address .form-group[data-sort]').detach().each(function() {
        if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#address .form-group').length) {
            $('#address .form-group').eq($(this).attr('data-sort')).before(this);
        }

        if ($(this).attr('data-sort') > $('#address .form-group').length) {
            $('#address .form-group:last').after(this);
        }

        if ($(this).attr('data-sort') < -$('#address .form-group').length) {
            $('#address .form-group:first').before(this);
        }
    });

    $('input[name=\'customer_group_id\']').on('change', function() {
        $.ajax({
            url: 'index.php?route=account/register/customfield&customer_group_id=' + this.value,
            dataType: 'json',
            success: function(json) {
                $('.custom-field').hide();
                $('.custom-field').removeClass('required');

                for (i = 0; i < json.length; i++) {
                    custom_field = json[i];

                    $('#custom-field' + custom_field['custom_field_id']).show();

                    if (custom_field['required']) {
                        $('#custom-field' + custom_field['custom_field_id']).addClass('required');
                    }
                }


            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('input[name=\'customer_group_id\']:checked').trigger('change');
    //-->
</script>
<script type="text/javascript">
    <!--
    $('button[id^=\'button-custom-field\']').on('click', function() {
        var node = this;

        $('#form-upload').remove();

        $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

        $('#form-upload input[name=\'file\']').trigger('click');

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function() {
            if ($('#form-upload input[name=\'file\']').val() != '') {
                clearInterval(timer);

                $.ajax({
                    url: 'index.php?route=tool/upload',
                    type: 'post',
                    dataType: 'json',
                    data: new FormData($('#form-upload')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function() {
                        $(node).button('loading');
                    },
                    complete: function() {
                        $(node).button('reset');
                    },
                    success: function(json) {
                        $(node).parent().find('.text-danger').remove();

                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });
    //-->
</script>
<script type="text/javascript">
    <!--
    $('select[name=\'country_id\']').on('change', function() {
        $.ajax({
            url: 'index.php?route=account/account/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
            },
            complete: function() {
                $('.fa-spin').remove();
            },
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('input[name=\'postcode\']').parent().parent().addClass('required');
                } else {
                    $('input[name=\'postcode\']').parent().parent().removeClass('required');
                }

                html = '<option value=""><?php echo $text_select; ?></option>';

                if (json['zone'] && json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';

                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }

                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }

                $('select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('select[name=\'country_id\']').trigger('change');
    //-->
</script>
<?php echo $footer; ?>