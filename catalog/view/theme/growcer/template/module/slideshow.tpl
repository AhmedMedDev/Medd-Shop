<?php
$class = 'slider-one';
$fixed_container_start = '';
$fixed_container_end = '';
if($slider_type=='slider-two' || $slider_type==''){
	$class = 'slider-two';
	$fixed_container_start = '<div class="fix-container">';
	$fixed_container_end = '</div>';
}
?>
<section class="bnr-section">
  <div class="<?php echo $class; ?>">
	<?php echo $fixed_container_start; ?>
	<div class="home-slide">
		<?php foreach ($banners as $banner) { ?>
		  <div class="slide-item" style="background-image:url('<?php echo $banner['image']; ?>');">
			<div class="fix-container">
			<?php
                $style = '';
                if((!isset($banner['entry_heading_h3']) || $banner['entry_heading_h3']=='') || (!isset($banner['entry_heading_h2']) || $banner['entry_heading_h2']=='') || (  
                    !isset($banner['entry_heading_h4']) || $banner['entry_heading_h4']=='')) {
                    $style = "background-color:transparent;";
                }
              ?> 
			  <div class="sliderText fadeInDown animated" style="<?php echo $style;?>">
				<div class="sliderText-in">
				  <?php if(isset($banner['entry_heading_h3']) && $banner['entry_heading_h3']!='') { echo '<h3>'.$banner['entry_heading_h3'].'</h3>'; }?>
				  <?php if(isset($banner['entry_heading_h2']) && $banner['entry_heading_h2']!='') { echo '<h2>'.$banner['entry_heading_h2'].'</h2>'; }?>
				  <?php if(isset($banner['entry_heading_h4']) && $banner['entry_heading_h4']!='') { echo '<h4>'.$banner['entry_heading_h4'].'</h4>'; }?>
				  <?php if ($banner['link']) { ?>
				  <a href="<?php echo $banner['link']; ?>"><?php echo $banner['title']; ?></a> 
				  <?php } ?>
				  </div>
			  </div>
			</div>
		  </div>
		<?php } ?>
	</div>
	<?php echo $fixed_container_end; ?>
  </div>
</section>