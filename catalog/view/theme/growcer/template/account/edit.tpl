<div class="heading"><?php echo $text_your_details; ?></div>
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
	<form class="siteForm form-horizontal " enctype="multipart/form-data" method="post" action="<?php echo $action; ?>">
	 <fieldset>
	<div class="form-group required">
	  <label for="input-firstname" class="col-md-3 control-label"><?php echo $entry_firstname; ?></label>
	  <div class="col-md-9">
		<input type="text" required required name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
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
	<div class="form-group required">
	  <label for="input-email" class="col-md-3 control-label"><?php echo $entry_email; ?></label>
	  <div class="col-md-9">
		<input type="email" required name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
	    <?php if ($error_email) { ?>
		<div class="text-danger"><?php echo $error_email; ?></div>
		<?php } ?>
	  </div>
	</div>
	<div class="form-group required">
	  <label for="input-telephone" class="col-md-3 control-label"><?php echo $entry_telephone; ?></label>
	  <div class="col-md-9">
		<input type="tel" required  name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
		<?php if ($error_telephone) { ?>
		<div class="text-danger"><?php echo $error_telephone; ?></div>
		<?php } ?>
	  </div>
	</div>
	<div class="form-group">
	  <label for="input-fax" class="col-md-3 control-label"><?php echo $entry_fax; ?></label>
	  <div class="col-md-9">
		<input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
	  </div>
	</div>
	<div class="form-group">
	  <label class="col-md-3 control-label"></label>
	  <div class="col-md-9">		
		<label class="checkbox" for="share_cart_show_friends">
				<input type="checkbox" name="share_cart_show_friends" value="1" <?php ((isset($share_cart_show_friends) && $share_cart_show_friends==1) ? 'checked' : '')  ?>>
			<i class="input-helper"></i><?php echo $entry_share_cart_show_friends; ?></b></a></label>
		
	  </div>
	</div>
  </fieldset>
  <div class="buttons clearfix">
	<div class="pull-right">
	  <input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
	</div>
  </div>
</form>

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