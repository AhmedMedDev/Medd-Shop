<?php if ($reviews) { ?>
<ul>
<?php foreach ($reviews as $review) { ?>
	<li>
		<div class="head">
			<div class="pull_left">
				<div class="heading"><?php echo ucwords($review['title']); ?></div>
				<div class="rating">
					<?php 
					$ratings_review_html ='<ul>';
						$max_ratings = 5;
						$min_ratings = 0;
						if($review['rating']>$min_ratings){
							for($rcount=1; $rcount<=$review['rating']; $rcount++){
							$max_ratings--;
							
							$ratings_review_html.='<li class="active">
									  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
								<g>
										  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
										</g>
							  </svg>
							</li>';
							}
						}
						for($rcount=1; $rcount<=$max_ratings; $rcount++){
						
						$ratings_review_html.='<li class="in-active">
								  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 70 70" enable-background="new 0 0 70 70" xml:space="preserve">
							<g>
									  <path d="M51,42l5.6,24.6L35,53.6l-21.6,13L19,42L0,25.4l25.1-2.2L35,0l9.9,23.2L70,25.4L51,42z M51,42"/>
									</g>
						  </svg>
						</li>';
						
						}
					$ratings_review_html.='</ul>';
					echo $ratings_review_html;
					?>
					<p class="inline"> <strong><?php echo ucwords($review['author']); ?></strong> </p>
				</div>
			</div>
			<div class="pull_right">
				<div class="date"><?php echo $review['date_added']; ?></div>
			</div>
		</div>
		<div class="desc">
			<?php echo $review['text']; ?>
		</div>
		<div class="gap"></div>
	</li>
<?php } ?>
	<li class="paging">
		<div class="pull_left"><?php echo $pagination; ?></div>
		<div class="pull_right"></div>
	</li>
</ul>
<?php } else { ?>
<div class="gap"></div>
<p><?php echo $text_no_reviews; ?></p>
<div class="gap"></div>
<?php } ?>