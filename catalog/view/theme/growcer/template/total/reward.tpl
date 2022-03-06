<form action="<?php echo isset($action) ? $action : ''; ?>" method="post" enctype="multipart/form-data" class="siteForm form-horizontal ">
	<fieldset>
		<div class="form-group">
			<label class="col-md-4 column control-label" for="input-reward">
				<?php echo $entry_reward; ?>
			</label>
			<div class="col-md-5 column">
				<input type="text" name="reward" value="<?php echo $reward; ?>" title="<?php echo $entry_reward; ?>" id="input-reward" class="form-control">
			</div>
			<div class="col-md-3 column">
			  <div class="pull-right">
				<input type="submit" value="<?php echo $button_reward; ?>" id="button-reward" class="btn btn-primary" />
			  </div>
			</div>
		</div>
	</fieldset>
</form>
<script type="text/javascript"><!--
$('#button-reward').on('click', function(e) {
	e.preventDefault();
	$.ajax({
		url: 'index.php?route=total/reward/reward',
		type: 'post',
		data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').val('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-reward').val('<?php echo $button_reward; ?>');
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