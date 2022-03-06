<?php 
if( $html_heading_name == "bottom_html_block" ){
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
}else if( $html_heading_name == "homepage_below_slider_html" ){
	?>
	<section class="comn-padd grayBg">      
		<div class="fix-container"> 
	 <?php echo $html;	 ?>
		</div>
	</section>
<?php
}else{
	?>
	  <?php if($heading_title) { ?>
		<h2><?php echo $heading_title; ?></h2>
	  <?php } ?>
	  <?php echo $html; ?>
	<?php	
}
?>