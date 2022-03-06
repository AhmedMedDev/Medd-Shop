<?php echo $header; ?>
<div id="body">
	<?php if (!empty($attention)) { ?>
	<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<div class="alert-after"></div>
	<?php } ?>
	<?php if ($success) { ?>
	<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<div class="alert-after"></div>
	<?php } ?>
	<?php if ($error_warning) { ?>
	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<div class="alert-after"></div>
	<?php } ?>
	<?php
		echo (!empty($content_top)) ? $content_top : '';
		echo (!empty($column_left)) ? $column_left : '';
		echo (!empty($column_right)) ? $column_right : '';
		echo (!empty($content_bottom)) ? $content_bottom : '';
		echo (!empty($testimonials)) ? $testimonials : ''; 
	?>
</div>
<?php echo $footer; ?>