<div class="buttons">
  <div class="gap"></div>
  <div class="pull-right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary themeBtn" data-loading-text="<?php echo $text_loading; ?>" />
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		type: 'get',
		url: 'index.php?route=payment/free_checkout/confirm',
		cache: false,
		beforeSend: function() {
			$('#button-confirm').val('<?php echo $text_loading; ?>');
		},
		complete: function() {
			$('#button-confirm').val('<?php echo $button_confirm; ?>');
		},
		success: function() {
			location = '<?php echo $continue; ?>';
		}
	});
});
//--></script>
