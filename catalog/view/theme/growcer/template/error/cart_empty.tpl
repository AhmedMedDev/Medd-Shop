<?php echo $header; ?>
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
	<?php if ($attention) { ?>
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
	<div class="fix-container">
		<div class="row not-found  not-found-bg">
			<div class="col-md-12">
				  <div class="heading"><?php echo $heading_title; ?></div>
				  <div class="blank-info nothing-found"><h3><?php echo $text_error; ?></h3></div>
				  <div class="gap"></div>
				  <div class="buttons">
					<div class="pull-right"><a href="<?php echo $continue; ?>" class="themeBtn"><?php echo $button_continue; ?></a></div>
					<div class="gap"></div>
				  </div>
			</div>
		</div> 
	</div>
<!--wrapper end here-->
</div>
<script>
	$(document).ready(function(){
		 if($(".ghost").length > 0) {
			var eyes = $(".ghost i"),
				width = eyes.width(),
				height = eyes.height(),
				position = eyes.offset();
			$(document).on("mousemove", function(a) {
				a.pageX < position.left && eyes.removeClass("right").addClass("left"), a.pageX > position.left + 50 && eyes.removeClass("left").addClass("right"), a.pageX > position.left - 40 && a.pageX < position.left + 80 && eyes.removeClass("left right"), a.pageY < position.top - 25 && eyes.removeClass("bottom").addClass("top"), a.pageY > position.top + 25 && eyes.removeClass("top").addClass("bottom"), a.pageY > position.top - 10 && a.pageY < position.top + 10 && eyes.removeClass("top bottom")
			})
		}
		
	});
</script>
<?php echo $footer; ?>