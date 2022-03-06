<section class="bnr-section" id="boxed_slideshow<?php echo $module; ?>" class="owl-carousel" style="opacity: 1;">
    <div class="slider-two">
		<div class="fix-container">
		  <div class="home-slide">
			<?php foreach ($banners as $banner) { ?>
			<div class="slide-item" title="<?php echo $banner['title']; ?>" style="background-image:url('<?php echo $banner['image']; ?>');">
			  <div class="fix-container">
				<div class="sliderText fadeInDown animated">
					<div class="sliderText-in">
						<h3>Now Available in your area</h3>
						<h2>Wide Range of Fruits & Vegetables</h2>
						<h4>Pickup days vary by Market.</h4>
						<?php if ($banner['link']) { ?>
							<a href="<?php echo $banner['link']; ?>">Show Now</a> 
						<?php } ?>
					</div>
				</div>
			  </div>
			</div>
			<?php } ?>
		  </div>
		</div>
	</div>
</section>

<script type="text/javascript"><!--
$('#boxed_slideshow<?php echo $module; ?>').owlCarousel({
	items: 6,
	autoPlay: 3000,
	singleItem: true,
	navigation: true,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: true
});
--></script>