<div class="sub-heading"><?php echo $text_shipping; ?></div>
<div class="gap"></div>
<form action="" method="post" enctype="multipart/form-data" class="siteForm form-horizontal ">
<fieldset>
  <div class="form-group required">
	<label class="col-md-4 control-label" for="input-country">
		<?php echo $entry_country; ?>
	</label>
	<div class="col-md-8">
		<select name="country_id" id="input-country" class="form-control">
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
  </div>
  <div class="form-group required">
	<label class="col-md-4 control-label" for="input-zone">
		<?php echo $entry_zone; ?>
	</label>
	<div class="col-md-8">
	  <select name="zone_id" id="input-zone" class="form-control"></select>
	</div>
  </div>
  <div class="form-group ">
	<label class="col-md-4 column control-label" for="input-firstname">
		<?php echo $entry_postcode; ?>
	</label>
	<div class="col-md-8 column">
	  <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
	</div>
  </div>
</fieldset>
<div class="buttons clearfix">
  <div class="pull-right">
	<input type="submit" id="button-quote" data-modal="modal-shipping" value="<?php echo $button_quote; ?>" class="btn btn-primary md-trigger expand">
  </div>
</div>
</form>
<script type="text/javascript"><!--
$(document).ready(function(){
	$('#pop_up_main_container').on('click','.md-close,.md-overlay,.popup-close',function(){
		$('#modal-1').removeClass('md-show');
		$('#pop_up_main_container').html('');
	});
});

$('#button-quote').on('click', function(e) {
	e.preventDefault();
	$.ajax({
		url: 'index.php?route=total/shipping/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-quote').val('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-quote').val('<?php echo $button_quote; ?>');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['error']) {
				if (json['error']['warning']) {
					$('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');

					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}

				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<div class="text-danger">' + json['error']['country'] + '</div>');
				}

				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<div class="text-danger">' + json['error']['zone'] + '</div>');
				}

				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<div class="text-danger">' + json['error']['postcode'] + '</div>');
				}
			}

			if (json['shipping_method']) {

				html  = '<div class="siteForm">';

				for (i in json['shipping_method']) {
					html += '<p><strong>' + json['shipping_method'][i]['title'] + '</strong></p>';

					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							html += '<div class="radio-wrap">';
							html += '  <label class="radio">';

							if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
								html += '<input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /><i class="input-helper"></i>';
							} else {
								html += '<input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" /><i class="input-helper"></i>';
							}

							html += json['shipping_method'][i]['quote'][j]['title'] + ' - ' + json['shipping_method'][i]['quote'][j]['text'] + '</label></div>';
						}
					} else {
						html += '<div class="alert alert-danger">' + json['shipping_method'][i]['error'] + '</div>';
					}
					
					html += '<div class="gap"></div>';
				}
				html += '     <div class="buttons-group clearfix"><div>';
				html += '        <button type="button" data-dismiss="modal" class="themeBtn graybtn popup-close"><?php echo $button_cancel; ?></button>';

				<?php if ($shipping_method) { ?>
				html += '        <input type="button" value="<?php echo $button_shipping; ?>" id="button-shipping" data-loading-text="<?php echo $text_loading; ?>" class="themeBtn" />';
				<?php } else { ?>
				html += '        <input type="button" value="<?php echo $button_shipping; ?>" id="button-shipping" data-loading-text="<?php echo $text_loading; ?>" class="themeBtn" disabled="disabled" />';
				<?php } ?>

				html += '      </div></div></div>';
				
				html_data = html;
				$('#pop_up_main_container').append('<div id="modal-1" class="md-modal md-effect-1"><a class="md-close"><svg xml:space="preserve" style="enable-background:new 0 0 612 612;" viewBox="0 0 612 612" height="612px" width="612px" y="0px" x="0px" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1"><g><g id="cross"><g><polygon points="612,36.004 576.521,0.603 306,270.608 35.478,0.603 0,36.004 270.522,306.011 0,575.997 35.478,611.397 306,341.411 576.521,611.397 612,575.997 341.459,306.011"/></g></g></g></svg></a><div class="md-content"><div class="custom-content"><div style="padding:25px;" class="shipping-estimate"></div></div></div></div><div class="md-overlay"></div>');

				$('#modal-1 .shipping-estimate').html(html_data);
				$('#modal-1').addClass('md-show');

				$('input[name=\'shipping_method\']').on('change', function() {
					$('#button-shipping').prop('disabled', false);
				});
			}
		}
	});
});



$(document).delegate('#button-shipping', 'click', function() {
	$.ajax({
		url: 'index.php?route=total/shipping/shipping',
		type: 'post',
		data: 'shipping_method=' + encodeURIComponent($('input[name=\'shipping_method\']:checked').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-shipping').val('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-shipping').val('<?php echo $text_loading; ?>');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert"></button></div>');

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}

			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=total/shipping/country&country_id=' + this.value,
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
//--></script>