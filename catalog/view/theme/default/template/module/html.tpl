<?php 
if( $html_heading_name == "bottom_offers_section" ){
	?>
	<section class="">
		<div class="fix-container">
			<div class="advertise-Block clearfix">
			  <div class="advertise-list clearfix">	
				<?php echo $html; ?>
			  </div>
			</div>
		</div>			
	</section>
	<?php
}else if( $html_heading_name == "home_page_middle_html" ){
	?>
	<div>
	  <?php echo $html; ?>
	</div>
	<?php
}else{
	?>
	<div>
	  <?php if($heading_title) { ?>
		<h2><?php echo $heading_title; ?></h2>
	  <?php } ?>
	  <?php echo $html; ?>
	</div>
	<?php	
}
?>