<form action="<?php echo isset($action) ? $action : ''; ?>" method="post" enctype="multipart/form-data" class="siteForm form-horizontal ">
	<fieldset>
		<div class="form-group">
			<label class="col-md-4 column control-label" for="input-voucher">
				<?php echo $entry_voucher; ?>
			</label>
			<div class="col-md-5 column">
				<input type="text" name="voucher" value="<?php echo $voucher; ?>" title="<?php echo $entry_voucher; ?>" id="input-voucher" class="form-control">
			</div>
			<div class="col-md-3 column">
			  <div class="pull-right">
				<input type="submit" value="<?php echo $button_voucher; ?>" id="button-voucher" class="btn btn-primary" />
			  </div>
			</div>
		</div>
	</fieldset>
</form>
<script type="text/javascript"><!--
$('#button-voucher').on('click', function(e) {
  e.preventDefault();	
  $.ajax({
    url: 'index.php?route=total/voucher/voucher',
    type: 'post',
    data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
    dataType: 'json',
    beforeSend: function() {
      $('#button-voucher').val('<?php echo $text_loading; ?>');
    },
    complete: function() {
      $('#button-voucher').val('<?php echo $button_voucher; ?>');
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