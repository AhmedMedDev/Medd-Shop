<form class="siteForm form-horizontal">
    <legend><?php echo ($text_checkout_shipping_address) ? $text_checkout_shipping_address : ''; ?></legend>
    <?php if ($addresses) { ?>
    <div id="shipping-existing">
        <div class="address-bar">
            <ul>
                <?php foreach ($addresses as $address) { ?>
                <?php if ($address['address_id'] == $address_id) { ?>
                <li>
                    <div class="radio-wrap">
                        <label class="radio">
                            <input type="radio" name="address_id" value="<?php echo $address['address_id']; ?>" checked="checked">
                            <i class="input-helper"></i></label>
                    </div>
                    <strong>
                        <?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>
                    </strong><br />
                    <?php echo $address['address_1']; ?>,<br />
                    <?php echo $address['city']; ?>,<br />
                    <?php echo $address['zone']; ?>,<br />
                    <?php echo $address['country']; ?><br />
                </li>
                <?php } else { ?>

                <li>
                    <div class="radio-wrap">
                        <label class="radio">
                            <input type="radio" name="address_id" value="<?php echo $address['address_id']; ?>">
                            <i class="input-helper"></i></label>
                    </div>
                    <strong>
                        <?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>
                    </strong><br />
                    <?php echo $address['address_1']; ?>,<br />
                    <?php echo $address['city']; ?>,<br />
                    <?php echo $address['zone']; ?>,<br />
                    <?php echo $address['country']; ?><br />
                </li>

                <?php } ?>
                <?php } ?>
                <li class="add-new">
                    <a href="javascript:void(0)" id="new_shipping_address">
                        <div class="btn-action action-wrapper">
                            <span class="action">
                                <i class="icon ion-ios-plus-empty size-64"></i>
                            </span>
                        </div>
                        <?php echo $text_address_new; ?>
                    </a>
                </li>
            </ul>
        </div>
        <div class="gap"></div>
    </div>
    <?php } ?>
    <!--div class="col-md-12"-->
    <div>
        <div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
            <div class="radio-wrap">
                <label class="radio">
                    <input type="radio" name="existing_shipping_address" value="existing" />
                    <i class="input-helper"></i> <?php echo $text_address_existing; ?>
                </label>
                <div class="gap"></div>
            </div>
            <div class="form-group required">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-firstname"><?php echo $entry_firstname; ?></label>
                    <input type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-shipping-firstname" class="form-control" />
                </div>
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-lastname"><?php echo $entry_lastname; ?></label>
                    <input type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-shipping-lastname" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <label class=" control-label" for="input-shipping-company"><?php echo $entry_company; ?></label>
                    <input type="text" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-shipping-company" class="form-control" />
                </div>
            </div>
            <div class="form-group required">
                <div class="col-md-12 ">
                    <label class=" control-label" for="input-shipping-address-1"><?php echo $entry_address_1; ?></label>
                    <input type="text" name="address_1" value="" placeholder="<?php echo $entry_address_1; ?>" id="input-shipping-address-1" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <label class=" control-label" for="input-shipping-address-2"><?php echo $entry_address_2; ?></label>
                    <input type="text" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-shipping-address-2" class="form-control" />
                </div>
            </div>
            <div class="form-group required">
                <div class="col-md-6 required">
                    <label class=" control-label" for="input-shipping-city"><?php echo $entry_city; ?></label>
                    <input type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" id="input-shipping-city" class="form-control" />
                </div>
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-postcode"><?php echo $entry_postcode; ?></label>
                    <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-shipping-postcode" class="form-control" />
                </div>
            </div>
            <div class="form-group required">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-country"><?php echo $entry_country; ?></label>
                    <select name="country_id" id="input-shipping-country" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($countries as $country) { ?>
                        <?php if ($country['country_id'] == $country_id) { ?>
                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-zone"><?php echo $entry_zone; ?></label>
                    <select name="zone_id" id="input-shipping-zone" class="form-control">
                    </select>
                </div>
            </div>
            <?php foreach ($custom_fields as $custom_field) { ?>
            <?php if ($custom_field['location'] == 'address') { ?>
            <?php if ($custom_field['type'] == 'select') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label"><?php echo $custom_field['name']; ?></label>
                    <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="radio">
                            <label>
                                <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                <?php echo $custom_field_value['name']; ?></label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label"><?php echo $custom_field['name']; ?></label>
                    <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                <?php echo $custom_field_value['name']; ?></label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'text') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>"
                        id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                        class="form-control"><?php echo $custom_field['value']; ?></textarea>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'file') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label"><?php echo $custom_field['name']; ?></label>
                    <button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i>
                        <?php echo $button_upload; ?></button>
                    <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'date') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="input-group date">
                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD"
                            id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'time') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="input-group time">
                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm"
                            id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                </div>
            </div>
            <?php } ?>
            <?php if ($custom_field['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-md-6">
                    <label class=" control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="input-group datetime">
                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm"
                            id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                </div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
        </div>
        <div class="buttons clearfix">
            <div class="pull-right">
                <input type="hidden" name="shipping_address" value="existing" />
                <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    <!--
    $('input[name=\'existing_shipping_address\']').on('change', function() {
        if (this.value == 'existing') {
            $('input[name=shipping_address]').attr('value', 'existing');
            $('#shipping-existing').show();
            $('#shipping-new').hide();
        }
    });
    $('#new_shipping_address').on('click', function() {
        $('input[name=shipping_address]').attr('value', 'new');
        $('input[name=existing_shipping_address]').removeAttr('checked');
        $('#shipping-existing').hide();
        $('#shipping-new').show();
    });
    //-->
</script>
<script type="text/javascript">
    <!--
    $('#collapse-shipping-address .form-group[data-sort]').detach().each(function() {
        if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#collapse-shipping-address .form-group').length) {
            $('#collapse-shipping-address .form-group').eq($(this).attr('data-sort')).before(this);
        }

        if ($(this).attr('data-sort') > $('#collapse-shipping-address .form-group').length) {
            $('#collapse-shipping-address .form-group:last').after(this);
        }

        if ($(this).attr('data-sort') < -$('#collapse-shipping-address .form-group').length) {
            $('#collapse-shipping-address .form-group:first').before(this);
        }
    });
    //-->
</script>
<script type="text/javascript">
    <!--
    $('#collapse-shipping-address button[id^=\'button-shipping-custom-field\']').on('click', function() {
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
                            $(node).parent().find('input[name^=\'custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input[name^=\'custom_field\']').attr('value', json['code']);
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
    /* $('.date').datetimepicker({
    	pickTime: false
    });

    $('.time').datetimepicker({
    	pickDate: false
    });

    $('.datetime').datetimepicker({
    	pickDate: true,
    	pickTime: true
    }); */
    //-->
</script>
<script type="text/javascript">
    <!--
    $('#collapse-shipping-address select[name=\'country_id\']').on('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#collapse-shipping-address select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
            },
            complete: function() {
                $('.fa-spin').remove();
            },
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('#collapse-shipping-address input[name=\'postcode\']').parent().parent().addClass('required');
                } else {
                    $('#collapse-shipping-address input[name=\'postcode\']').parent().parent().removeClass('required');
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

                $('#collapse-shipping-address select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#collapse-shipping-address select[name=\'country_id\']').trigger('change');
    //-->
</script>