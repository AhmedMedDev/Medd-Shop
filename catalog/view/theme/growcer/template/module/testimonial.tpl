<?php 

if(is_array($testimonials) && count($testimonials)>0){
?>
<section class="testimonial-wrapper">
  <div class="fix-container">
	<div class="testimonial-slider">
		<?php
		foreach($testimonials as $testimonial){
			echo '
			<div class="item">
				<p>'.$testimonial['description'].' </p>
				<h4>'.$testimonial['title'].'</h4>
			</div>
			';
		}
		?>
	</div>
  </div>
</section>
<?php

} ?>