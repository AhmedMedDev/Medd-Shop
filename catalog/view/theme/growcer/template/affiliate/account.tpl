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
	<?php if (isset($success) && $success!='') { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close" data-dismiss="alert"></button></div>
		</div>
		<div class="alert-after"></div>
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
			<?php echo $content_top; ?>
			<div class="heading"><?php echo $heading_title; ?></div>
			<div class="gap"></div>
			  <form id="profile_upload" class="siteForm form-horizontal " method="post" action="">
				<fieldset>
				<div class="form-group">
				  <label for="input-firstname" class="col-md-3 control-label"><?php echo $text_profile_picture;?></label>
				  <div class="col-md-9">
					<div class="upload-file">
					  <div class="uploadedphoto"><img id="edit_upic" src="<?php echo $profile_image; ?>" alt=""></div>
					  <div class="choose_file"><span><?php echo $text_change_photo; ?></span>
						<input type="file" title="Profile Picture" class="upload" onchange="popupImage(this)" id="user_profile_image" name="user_profile_image">
						<span class="profile_upload_status"></span>
					  </div>
					</div>
				  </div>
				</div>
				</fieldset>
			  </form>
			  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal siteForm">
				<fieldset>
				  <legend><?php echo $text_your_details; ?></legend>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
					<div class="col-md-9">
					  <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" required="required"  />
					  <?php if ($error_firstname) { ?>
					  <div class="text-danger"><?php echo $error_firstname; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
					<div class="col-md-9">
					  <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" required="required"  />
					  <?php if ($error_lastname) { ?>
					  <div class="text-danger"><?php echo $error_lastname; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-email"><?php echo $entry_email; ?></label>
					<div class="col-md-9">
					  <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" required="required"  />
					  <?php if ($error_email) { ?>
					  <div class="text-danger"><?php echo $error_email; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
					<div class="col-md-9">
					  <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" required="required"  />
					  <?php if ($error_telephone) { ?>
					  <div class="text-danger"><?php echo $error_telephone; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-md-3 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
					<div class="col-md-9">
					  <input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
					</div>
				  </div>
				</fieldset>
				<fieldset>
				  <legend><?php echo $text_your_address; ?></legend>
				  <div class="form-group">
					<label class="col-md-3 control-label" for="input-company"><?php echo $entry_company; ?></label>
					<div class="col-md-9">
					  <input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company" class="form-control" />
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-md-3 control-label" for="input-website"><?php echo $entry_website; ?></label>
					<div class="col-md-9">
					  <input type="text" name="website" value="<?php echo $website; ?>" placeholder="<?php echo $entry_website; ?>" id="input-website" class="form-control" />
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-address-1"><?php echo $entry_address_1; ?></label>
					<div class="col-md-9">
					  <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address-1" class="form-control" required="required"  />
					  <?php if ($error_address_1) { ?>
					  <div class="text-danger"><?php echo $error_address_1; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group">
					<label class="col-md-3 control-label" for="input-address-2"><?php echo $entry_address_2; ?></label>
					<div class="col-md-9">
					  <input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address-2" class="form-control" />
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-city"><?php echo $entry_city; ?></label>
					<div class="col-md-9">
					  <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="form-control" required="required"  />
					  <?php if ($error_city) { ?>
					  <div class="text-danger"><?php echo $error_city; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
					<div class="col-md-9">
					  <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
					  <?php if ($error_postcode) { ?>
					  <div class="text-danger"><?php echo $error_postcode; ?></div>
					  <?php } ?>
					</div>
				  </div>
				  <div class="form-group required">
					<label class="col-md-3 control-label" for="input-country"><?php echo $entry_country; ?></label>
					<div class="col-md-9">
					  <select name="country_id" id="input-country" class="form-control"  required="required" >
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
					<label class="col-md-3 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
					<div class="col-md-9">
					  <select name="zone_id" id="input-zone" class="form-control"  required="required" >
					  </select>
					  <?php if ($error_zone) { ?>
					  <div class="text-danger"><?php echo $error_zone; ?></div>
					  <?php } ?>
					</div>
				  </div>
				</fieldset>
				<div class="buttons clearfix">
				  <div class="pull-right">
					<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
				  </div>
				</div>
			  </form>
			  <?php echo $content_bottom; ?>			
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
  <!--body end here--> 
<!-- jQueryTab.js --> 
<script type="text/javascript"><!--
	
	function popupImage(e){

	$.ajax({
		url: 'index.php?route=tool/profile_upload',
		type: 'post',
		dataType: 'json',
		data: new FormData($('#profile_upload')[0]),
		cache: false,
		contentType: false,
		processData: false,
		beforeSend: function() {
			$('.profile_upload_status').html('loading...');
		},
		complete: function() {
			$('.profile_upload_status').html('');
		},
		success: function(json) {
			$('.profile_upload_status').parent().find('.text-danger').remove();

			if (json['error']) {
				$('.profile_upload_status').parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
			}
			if(json['profile']==false){
				window.location.href = json['success'];
			}
			else if (json['success']) {
				$('#edit_upic').attr('src', json['profile_image_2']);
				$('#account_upic').attr('src', json['profile_image_1']);
				//alert(json['success']);
				$('.profile_upload_status').parent().find('input').attr('value', json['code']);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
	
}
$('select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=affiliate/edit/country&country_id=' + this.value,
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