<?php echo $header; ?>
<!--body start here-->
<div id="body">
	<div class="breadcrumb">
		<div class="fix-container">
		  <ul>
			<?php 
				$iteration 	 = 1;
				$bread_count = count($breadcrumbs); 
				foreach ($breadcrumbs as $breadcrumb) { 
					if($iteration<$bread_count){ ?>
					<li>
						<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
					</li>
					<?php }else{ ?>
					<li>
						<?php echo $breadcrumb['text']; ?>
					</li>
					<?php }
					$iteration++;
				} 
			?>
		  </ul>
		</div>
	</div>

	<?php if ($error_warning) { ?>
	  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	  </div>
	  <?php } ?>
	
	
	<div class="dash-pages">
		<div class="fix-container">
			<div class="row">
			  <div class="col-md-12">
			  &nbsp;
			  <?php echo $content_top; ?>
			  </div>
			</div>
			<div class="row">
				<div class="col-md-3 column">
					<div class="left-panel">
						<?php echo $account_sidebar; ?>
					</div>
				</div>
				<div class="col-md-9 column">
					<div class="heading"><?php echo $text_edit_address; ?></div>
					<div class="gap"></div>
					<div class="siteForm">
					<form class="siteForm form-horizontal " enctype="multipart/form-data" method="post" action="<?php echo $action; ?>">
						  <fieldset>
							<div class="form-group required">
							  <label for="input-firstname" class="col-md-3 control-label"><?php echo $entry_firstname; ?></label>
							  <div class="col-md-9">
								<input type="text" required name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
								<?php if ($error_firstname) { ?>
								<div class="text-danger"><?php echo $error_firstname; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-lastname" class="col-md-3 control-label"><?php echo $entry_lastname; ?></label>
							  <div class="col-md-9">
								<input type="text" required name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />
								<?php if ($error_lastname) { ?>
								<div class="text-danger"><?php echo $error_lastname; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group">
							  <label for="input-company" class="col-md-3 control-label"><?php echo $entry_company; ?></label>
							  <div class="col-md-9">
								<input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company" class="form-control" />
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-address_1" class="col-md-3 control-label"><?php echo $entry_address_1; ?></label>
							  <div class="col-md-9">
								<input type="text" required name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address_1" class="form-control" />
								<?php if ($error_address_1) { ?>
								<div class="text-danger"><?php echo $error_address_1; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group">
							  <label for="input-address_2" class="col-md-3 control-label"><?php echo $entry_address_2; ?></label>
							  <div class="col-md-9">
								<input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address_2" class="form-control" />
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-city" class="col-md-3 control-label"><?php echo $entry_city; ?></label>
							  <div class="col-md-9">
								<input type="text" required name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="form-control" />
								<?php if ($error_city) { ?>
								<div class="text-danger"><?php echo $error_city; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-postcode" class="col-md-3 control-label"><?php echo $entry_postcode; ?></label>
							  <div class="col-md-9">
								<input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
								<?php if ($error_postcode) { ?> 
								<div class="text-danger"><?php echo $error_postcode; ?></div>
								<?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-country" class="col-md-3 control-label"><?php echo $entry_country; ?></label>
							  <div class="col-md-9">
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
							  <?php if ($error_country) { ?>
							  <div class="text-danger"><?php echo $error_country; ?></div>
							  <?php } ?>
							  </div>
							</div>
							<div class="form-group required">
							  <label for="input-zone" class="col-md-3 control-label"><?php echo $entry_zone; ?></label>
							  <div class="col-md-9">
							  <select name="zone_id" id="input-zone" class="form-control">
							  </select>
							  <?php if ($error_zone) { ?>
							  <div class="text-danger"><?php echo $error_zone; ?></div>
							  <?php } ?>
							  <?php if ($error_country) { ?>
							  <div class="text-danger"><?php echo $error_country; ?></div>
							  <?php } ?>
							  </div>
							</div>
							
							<?php foreach ($custom_fields as $custom_field) { ?>
							<?php if ($custom_field['location'] == 'address') { ?>
							<?php if ($custom_field['type'] == 'select') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
							  <div class="col-md-9">
								<select name="custom-field<?php echo $custom_field['custom_field_id']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
								<option value=""><?php echo $text_select; ?></option>
								<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
								<?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
								<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
								<?php } ?>
								<?php } ?>
								</select>
							  <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
							  <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
							  <?php } ?>
							  </div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'radio') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
							  <div class="col-md-9">
									<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										 <?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
											<label>
											<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
											<?php echo $custom_field_value['name']; ?></label>
										 <?php }else { ?>
										  <label>
											<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
											<?php echo $custom_field_value['name']; ?></label>
										  <?php } ?>
									<?php } ?>
									 <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									  <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									  <?php } ?>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'checkbox') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
									<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $address_custom_field[$custom_field['custom_field_id']])) { ?>
									  <label>
										<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
										<?php echo $custom_field_value['name']; ?></label>
									  <?php } else { ?>
									  <label>
										<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
										<?php echo $custom_field_value['name']; ?></label>
									  <?php } ?>
									<?php } ?>
									<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'text') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
									<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
									<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'textarea') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
									<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
									<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
							
							<?php if ($custom_field['type'] == 'file') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
									 <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
									  <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
									  <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									  <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									  <?php } ?>
								</div>
							</div>
							<?php } ?>
							
							<?php if ($custom_field['type'] == 'date') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
									<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
									<span class="input-group-btn">
									<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									</span>
									</div>
									<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									  <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									  <?php } ?>
								</div>
							</div>
							<?php } ?>
							
							<?php if ($custom_field['type'] == 'time') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span>
									</div>
									<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
							
							 <?php if ($custom_field['type'] == 'datetime') { ?>
							<div class="form-group required">
							  <label for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="col-md-3 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-md-9">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span>
									 <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
									  <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
									  <?php } ?>
								</div>
							 </div>
							 <?php } ?>
							
							<?php } ?>
							<?php } ?>
							<div class="form-group required">
							  <label for="input-<?php echo $entry_default; ?>" class="col-md-3 control-label"><?php echo $entry_default ; ?></label>
								<div class="col-md-9">
									<ul class="radio-wrap">
										<?php if ($default) { ?>
										<li>
											<label class="radio">
											<input type="radio" name="default" value="1" checked="checked" />
											<i class="input-helper"></i><?php echo $text_yes; ?>
											</label>
										</li>
										<li>
											<label class="radio">
											<input type="radio" name="default" value="0" />
											<i class="input-helper"></i><?php echo $text_no; ?>
											</label>
										</li>
										<?php } else { ?>
										<li>
											<label class="radio">
											<input type="radio" name="default" value="1" />
											<i class="input-helper"></i><?php echo $text_yes; ?>
											</label>
										</li>
										<li>
											<label class="radio">
											<input type="radio" name="default" value="0" checked="checked" />
											<i class="input-helper"></i><?php echo $text_no; ?>
											</label>
										</li>
										<?php } ?>
									</ul>
								</div>
							</div>
						  </fieldset>
							<div class="buttons clearfix">
								<div class="pull-right">
									<a href="<?php echo $back; ?>" class="themeBtn graybtn"><?php echo $button_back; ?></a>
									<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
								</div>
							</div>
						</form>
					 </div>
					<div class="gap"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					&nbsp;
					<?php echo $content_bottom; ?>
				</div>
			</div>
		</div>
	</div>
	
</div>
<script type="text/javascript"><!--
// Sort the custom fields
$('.form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length) {
		$('.form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('.form-group').length) {
		$('.form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('.form-group').length) {
		$('.form-group:first').before(this);
	}
});
//--></script>
<script type="text/javascript"><!--
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
//--></script>
<script type="text/javascript"><!--
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
//--></script>
<?php echo $footer; ?>