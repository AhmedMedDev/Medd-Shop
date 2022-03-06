<form action="<?php echo isset($action) ? $action : ''; ?>" method="post" enctype="multipart/form-data" class="siteForm form-horizontal ">
	<fieldset>
		<div class="form-group">
			<label class="col-md-4 column control-label" for="input-coupon">
				<?php echo $entry_coupon; ?>
			</label>
			<div class="col-md-5 column">
				<input type="text" name="coupon" value="<?php echo $coupon; ?>" title="<?php echo $entry_coupon; ?>" id="input-coupon" class="form-control">
			</div>
			<div class="col-md-3 column">
			  <div class="pull-right">
				<input type="submit" value="<?php echo $button_coupon; ?>" id="button-coupon" class="btn btn-primary" />
			  </div>
			</div>
		</div>
	</fieldset>
</form>
<script type="text/javascript"><!--
$('#button-coupon').on('click', function(e) {
	e.preventDefault();
	$.ajax({
		url: 'index.php?route=total/coupon/coupon',
		type: 'post',
		data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-coupon').val('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-coupon').val('<?php echo $button_coupon; ?>');
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