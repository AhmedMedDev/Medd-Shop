<?php if($api_checkout_process === true) { ?>
<div class="app-hide" style="display:none">
	<?php } ?>

	<footer id="footer" class="<?php echo (!empty($hide_Data)) ? $hide_Data : ''; ?>">

		<?php
			$WEBSITE_URL = '';

			$count_manufacturers = count($footer_manufacturers);
			if($count_manufacturers){
			?>
		<div class="footer_top comn-padd">
			<div class="fix-container">
				<div class="logo_listing">
					<?php
							foreach($footer_manufacturers as $key=>$value){
							?>
					<div class="item-slide">
						<div class="in">
							<img src="<?php echo str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$value['image']);?>" alt="<?php echo $value['name'];?>" />
						</div>
					</div>
					<?php
							}
						?>
				</div>
			</div>
		</div>
		<?php
			}
		?>
		<div class="mainFooter">
			<div class="top_ftr comn-padd">
				<div class="fix-container">
					<div class="full-grid clearfix three_grid">
						<div class="grid">
							<div class="grower-info">
								<div class="ftr-logo">
									<?php if(isset($footer_sections[9]) &&  $footer_sections[9]['heading']!= 'hide'){
										echo '<h2 class="block-title">';
										echo html_entity_decode($footer_sections[9]['heading'], ENT_QUOTES, 'UTF-8');
										echo '</h2>';
									} ?>
									<?php
										if ($logo){ ?>
									<a href="<?php echo $home; ?>">
										<img src="<?php echo str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$logo); ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
									</a>
									<?php
										} else { ?>
									<h1>
										<a href="<?php echo str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$home); ?>">

											<?php echo $name; ?>
										</a>
									</h1>
									<?php
										}
									?>
								</div>
								<?php if(isset($footer_sections[9])){
									echo html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[9]['content']), ENT_QUOTES, 'UTF-8');
								} ?>
							</div>
						</div>
						<div class="grid">
							<div class="newsletter">
								<h2 class="block-title"><?php echo $text_subscribe_to_newsletter; ?></h2>
								<p><?php echo $text_subscribe_content; ?></p>
								<div class="col-sm-4" id="error-msg"></div>
								<div class="newsletter-form">
									<form class="news-subscribe-form" id="news-subscribe-form" action="<?php echo str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$newsletter); ?>" method="post">
										<table width="100%" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<input type="text" class="form-control" id="input-newsletter" placeholder="<?php echo $text_newsletter_text; ?>" value="" name="newsletter">
												</td>
												<td>
													<input type="button" id="subscribe" class="themeBtn" value="<?php echo $text_subscribe; ?>">
												</td>
											</tr>
										</table>
									</form>
								</div>
							</div>
						</div>
						<?php
							if(isset($footer_sections[1])){
							?>
						<div class="grid">
							<div class="connect-by-media">
								<h2 class="block-title"><?php echo $footer_sections[1]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[1]['content']), ENT_QUOTES, 'UTF-8'); ?>
								<?php echo  html_entity_decode($social_code, ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>
					</div>
				</div>
			</div>
			<div class="mid_ftr">
				<div class="fix-container">
					<div class="main-footer clearfix">
						<?php
							if(isset($footer_sections[2]) && $footer_sections[2]['status'] == 1){
							?>
						<div class="grid">
							<div class="footer-link">
								<h2 class="block-title"><?php echo $footer_sections[2]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[2]['content']), ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>



						<?php
							if(isset($footer_sections[3]) && $footer_sections[3]['status'] == 1){
							?>
						<div class="grid">
							<div class="footer-link">
								<h2 class="block-title"><?php echo $footer_sections[3]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[3]['content']), ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>


						<?php
							if(isset($footer_sections[4]) && $footer_sections[4]['status'] == 1){
							?>
						<div class="grid">
							<div class="footer-link">
								<h2 class="block-title"><?php echo $footer_sections[4]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[4]['content']), ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>

						<?php
							if(isset($footer_sections[5]) && $footer_sections[5]['status'] == 1){
							?>
						<div class="grid">
							<div class="footer-link">
								<h2 class="block-title"><?php echo $footer_sections[5]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[5]['content']), ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>
						<?php
							if(isset($footer_sections[6]) && $footer_sections[6]['status'] == 1){
							?>
						<div class="grid">
							<div class="footer-link">
								<h2 class="block-title"><?php echo $footer_sections[6]['heading']; ?></h2>
								<?php echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[6]['content']), ENT_QUOTES, 'UTF-8'); ?>
							</div>
						</div>
						<?php
							}
						?>
					</div>
				</div>
			</div>
			<div class="bottm_ftr comn-padd">
				<div class="fix-container">
					<div class="full-grid clearfix">
						<div class="grid pull_left">
							<?php
								if(isset($footer_sections[7]) && $footer_sections[7]['status'] == 1){
									$sectionSevenContent = html_entity_decode(str_ireplace('{WEBSITE_URL}', $WEBSITE_URL, $footer_sections[7]['content']), ENT_QUOTES, 'UTF-8');

									echo html_entity_decode(str_ireplace('{COPYRIGHT_YEAR}', date('Y'), $sectionSevenContent), ENT_QUOTES, 'UTF-8');
								}
							?>
						</div>
						<div class="grid pull_right">
							<?php
								if(isset($footer_sections[8]) && $footer_sections[8]['status'] == 1){
									echo  html_entity_decode(str_ireplace('{WEBSITE_URL}',$WEBSITE_URL,$footer_sections[8]['content']), ENT_QUOTES, 'UTF-8');
								}
							?>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--<div class="fixed-demo-btn no-print" id="demo-btn">
			<a id="btn-demo" href="javascript:void(0);" onclick="showDemoPopup();" class="">
				Discuss Your Project
			</a>
		</div>-->

		<div class="demoPopup-dev modal">
			<div class="modal-body">
				<div class="popup -bg" style="max-width: 700px; margin:auto">
					<a href="javascript:void(0);" onclick="hideDemoPopup();" class="popup__crossed"></a>
					<div class="popup-content">
						<div class="popup__logo">
							<?php if($logo) { ?>
							<img src="<?=$logo;?>" alt="<?php echo $name; ?>">
							<?php } ?>
						</div>
						<div class="started-wrapper">
							<div class="started-box">
								<div class="graphic"><img src="catalog/view/theme/growcer/images/get-started.png" alt=""></div>
								<p>I Really Liked The Features Of Growcer And Want To Discuss My Project</p>
								<a href="https://www.fatbit.com/website-design-company/requestaquote.html#demo" target="_blank" class="popup__btn btn--primary">Get Started</a>
							</div>
							<div class="started-box">
								<div class="graphic"><img src="catalog/view/theme/growcer/images/free-demo.png" alt=""></div>
								<p>I Want To Learn More About Growcer And Need A Personalized Live Demo</p>
								<a href="https://www.fatbit.com/grocery-ecommerce-store-software.html#requestdemo" target="_blank" class="popup__btn btn--secondary">Book A Free Demo</a>
							</div>
						</div>
						<div style="text-align:center;"> <a href="https://www.fatbit.com/grocery-ecommerce-store-software.html" target="_blank" class="view-packages__btn">Know More About Growcer</a></div>
					</div>
				</div>
			</div>
		</div>
		<div class="demoPopup-dev modal-overlay"></div>

		<script>
			function showDemoPopup() {
				$('.demoPopup-dev').addClass('modal-is-visible');
			}

			function hideDemoPopup() {
				$('.demoPopup-dev').removeClass('modal-is-visible');
			}
		</script>

	</footer>
	</main>
	<?php if($api_checkout_process === true) { ?>
</div>
<?php } ?>

</body>

</html>