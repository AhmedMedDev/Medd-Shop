<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
	<!--<![endif]-->
	<head>
		<meta charset="UTF-8" />
		<!-- Mobile Specific Metas ================================================== -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><?php echo $title; ?></title>
		<base href="<?php echo $base; ?>" />
		<?php if ($description) { ?>
			<meta name="description" content="<?php echo $description; ?>" />
		<?php } ?>
		<?php if ($keywords) { ?>
			<meta name="keywords" content="<?php echo $keywords; ?>" />
		<?php } ?>
		
		<?php if ($og_thumb) { ?>
			<meta property="og:image" content="<?php echo $og_thumb; ?>">
			<?php } else { ?>
			<meta property="og:image" content="<?php echo $logo; ?>">
		<?php } ?>
		
		<!-- CSS ================================================== -->
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/reset.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/animate.min.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/common.css" />
		<?php if (isset($page_route) && $page_route=='home') { ?>
			<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/index.css" />
			<?php }else{ ?>
			<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/inner.css" />
		<?php } ?>
		
		<?php
			foreach ($styles as $style) { ?>
			<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
			<?php 
			}  
		?>
		
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/tablet.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/slick.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/eagle.gallery.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/footer.css" />
		
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/mobile.css" />
		<link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,700,400italic,900,900italic,300,300italic" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Roboto:400,300italic,300,400italic,500,500italic,700,700italic,900,900italic" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/ionicons.min.css" />
		<script>
			var arabic_defined='<?php echo $lang; ?>';
			<?php	
				if($lang == 'ar'){
					echo 'arabic_defined="ar";';
				}
			?>
		</script>
		<?php
			/* Add css for Arabic */
			if($lang == 'ar'){?>
			<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/arabic.css" />
			<?php	
			}
			/* Add css for Arabic */
		?>
		
		<?php foreach ($links as $link) { ?>
			<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
		<?php } ?>
		
		<!-- JS ================================================== -->
		<script src="catalog/view/theme/growcer/js/jquery-latest.js" type="text/javascript"></script>
		<script src="catalog/view/theme/growcer/js/modernizr-1.7.min.js" type="text/javascript"></script>
		<script src="catalog/view/theme/growcer/js/respond.src.js" type="text/javascript"></script>
		<script src="catalog/view/theme/growcer/js/slick.js" type="text/javascript"></script>
		<script src="catalog/view/theme/growcer/js/common-function.js" type="text/javascript"></script>
		<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
		
		<script src="catalog/view/theme/growcer/js/responsive-img.min.js" type="text/javascript"></script>
		
		<?php foreach ($scripts as $script) { ?>
			<script src="<?php echo $script; ?>" type="text/javascript"></script>
		<?php } ?>
		<?php foreach ($analytics as $analytic) { ?>
			<?php echo $analytic; ?>
		<?php } ?>
	</head>
	<body class="<?php echo $class; ?>">
		
		<?php if($api_checkout_process === true) { ?>
			<div class="app-hide" style="display:none">
			<?php } ?>
			
			<?php if(isset($demo_store_message)){ ?>
				<div class="demo-store-message"><?php  echo $demo_store_message; ?></div>
			<?php } ?>
			<main id="wrapper"> 
				<!--[ header start here ]-->
				<header id="header">
					<div class="top-header">
						<div class="fix-container">
							<div class="full-grid clearfix">
								<div class="grid pull_left">
									<div class="top-lft-link">
										<?php echo $currency; ?>
										<?php echo $language; ?>			 
									</div>
								</div>
								<div class="grid pull_right"> <span class="togal_btn"></span>
									<div class="top-rght-link">
										<ul class="link-list">
											<li>
												<div class="visitor-name">
													<h3><?php echo $text_welcome_home; ?> <span class="visitor"><?php echo ucwords($welcome_username); ?></span></h3>
												</div>
											</li>
											<li><a href="javascript:void(0);" title="<?php echo $text_account; ?>"><?php echo $text_account; ?></a>
												<div class="dropBox">
													<ul class="drop-links">
														<?php if ($logged) { ?>
															<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
															<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
															<li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
															<li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
															<li><a href="<?php echo $listing; ?>"><?php echo $shop_with_friends; ?></a></li>
															<li><a href="<?php echo $share_cart; ?>"><?php echo $share_cart_txt; ?></a></li>                                                
															<li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>                                                
															<?php } else { ?>
															<li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
															<li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
															<?php 
															}
															if($aff_logged){
															?>
															<li><a href="<?php echo $aff_account; ?>"><?php echo $text_affiliate_account; ?></a></li>
															<li><a href="<?php echo $aff_logout; ?>"><?php echo $text_affiliate_logout; ?></a></li><?php
															}
															
														?>
													</ul>
												</div>
											</li>
											<li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
											<li><a href="<?php echo $compare; ?>" id="compare-total" title="<?php echo $text_compare; ?>" data-compare="<?php echo count($compareTotal); ?>"><?php echo $text_compare; ?></a></li>
											<li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><?php echo $text_checkout; ?></a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="main-header">
						<div class="fix-container">
							<div class="full-grid clearfix"> <span id="navToggle" class="togl-menu"></span>
								<div class="grid pull_left">
									<div class="logo">
										<?php 
											if ($logo){ ?>
											<a href="<?php echo $home; ?>">
												<img src="<?=$base?>image/<?=$logo;?>" data-src-base="<?=$base?>image/" data-src-base2x="<?=$base?>image/" data-src='<768:<?=$logo_mobile?>, <1024:<?=$logo;?>,  >1024:<?=$logo;?>' title="<?php echo $name; ?>" alt="<?php echo $name; ?>">
											</a>
											
											<?php 
											} else { ?>
											<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
											<?php 
											} 
										?>		  
									</div>
								</div>
								<div class="giid pull_right">
									<div class="hdr-rght-field">
										<div class="toglBtns">
											<ul>
												<li> 
													<a href="javascript:void(0)" title="Search" class="srchTogl">
														<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"	 width="20px" height="20px" viewBox="0 0 485.213 485.213" style="enable-background:new 0 0 485.213 485.213;" xml:space="preserve">
															<g>
																<path d="M471.882,407.567L360.567,296.243c-16.586,25.795-38.536,47.734-64.331,64.321l111.324,111.324
																c17.772,17.768,46.587,17.768,64.321,0C489.654,454.149,489.654,425.334,471.882,407.567z"/>
																<path d="M363.909,181.955C363.909,81.473,282.44,0,181.956,0C81.474,0,0.001,81.473,0.001,181.955s81.473,181.951,181.955,181.951
																C282.44,363.906,363.909,282.437,363.909,181.955z M181.956,318.416c-75.252,0-136.465-61.208-136.465-136.46
																c0-75.252,61.213-136.465,136.465-136.465c75.25,0,136.468,61.213,136.468,136.465
																C318.424,257.208,257.206,318.416,181.956,318.416z"/>
																<path d="M75.817,181.955h30.322c0-41.803,34.014-75.814,75.816-75.814V75.816C123.438,75.816,75.817,123.437,75.817,181.955z"/>
															</g>
														</svg>
													</a> 
												</li>
												<?php if (!$logged) { ?>					
													<li>
														<a href="<?php echo $login; ?>" title="Login">
															<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="20px" height="20px" viewBox="0 0 585.354 585.354" style="enable-background:new 0 0 585.354 585.354;" xml:space="preserve">
																<path d="M292.679,0C198.29,0,121.496,76.791,121.496,171.183v97.767c0,1.111-1.371,2.983-2.448,3.341
																c-9.257,3.087-16.775,5.762-23.657,8.415c-8.207,3.164-14.397,12.259-14.397,21.157v224.641c0,8.837,6.15,17.94,14.305,21.172
																c63.097,25.003,129.505,37.678,197.379,37.678s134.282-12.678,197.382-37.681c8.152-3.231,14.299-12.332,14.299-21.169V301.863
																c0-8.898-6.189-17.993-14.4-21.16c-6.885-2.653-14.402-5.328-23.652-8.415c-1.074-0.358-2.445-2.231-2.445-3.342V171.18
																C463.857,76.791,387.068,0,292.679,0z M246.053,370.281c0-25.769,20.875-46.622,46.623-46.622
																c25.746,0,46.621,20.851,46.621,46.622c0,17.075-9.629,31.371-23.311,39.475v77.081c0,12.886-10.426,23.311-23.311,23.311
																c-12.886,0-23.311-10.425-23.311-23.311v-77.081C255.683,401.652,246.053,387.356,246.053,370.281z M405,171.18v84.355
																c-36.834-7.926-74.623-11.94-112.306-11.943c-37.666,0-75.447,4.015-112.338,11.934V171.18c0-61.935,50.386-112.32,112.32-112.32
																C354.609,58.859,405,109.245,405,171.18z"/>
															</svg>
														</a> 
													</li>
													<li>
														<a href="<?php echo $register; ?>" title="Sign Up">
															<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="20px" height="20px" viewBox="0 0 350 350" style="enable-background:new 0 0 350 350;" xml:space="preserve">
																<g>
																	<path d="M175,171.173c38.914,0,70.463-38.318,70.463-85.586C245.463,38.318,235.105,0,175,0s-70.465,38.318-70.465,85.587
																	C104.535,132.855,136.084,171.173,175,171.173z"/>
																	<path d="M41.909,301.853C41.897,298.971,41.885,301.041,41.909,301.853L41.909,301.853z"/>
																	<path d="M308.085,304.104C308.123,303.315,308.098,298.63,308.085,304.104L308.085,304.104z"/>
																	<path d="M307.935,298.397c-1.305-82.342-12.059-105.805-94.352-120.657c0,0-11.584,14.761-38.584,14.761
																	s-38.586-14.761-38.586-14.761c-81.395,14.69-92.803,37.805-94.303,117.982c-0.123,6.547-0.18,6.891-0.202,6.131
																	c0.005,1.424,0.011,4.058,0.011,8.651c0,0,19.592,39.496,133.08,39.496c113.486,0,133.08-39.496,133.08-39.496
																	c0-2.951,0.002-5.003,0.005-6.399C308.062,304.575,308.018,303.664,307.935,298.397z"/>
																</g>
															</svg>
														</a> 
													</li>
												<?php }	?>
												<li> 
													<a href="<?php echo $shopping_cart; ?>" title="Cart">
														<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
														width="20px" height="20px" viewBox="0 0 459.529 459.529" style="enable-background:new 0 0 459.529 459.529;" xml:space="preserve">
															<g>
																<path d="M17,55.231h48.733l69.417,251.033c1.983,7.367,8.783,12.467,16.433,12.467h213.35c6.8,0,12.75-3.967,15.583-10.2
																l77.633-178.5c2.267-5.383,1.7-11.333-1.417-16.15c-3.117-4.817-8.5-7.65-14.167-7.65H206.833c-9.35,0-17,7.65-17,17
																s7.65,17,17,17H416.5l-62.9,144.5H164.333L94.917,33.698c-1.983-7.367-8.783-12.467-16.433-12.467H17c-9.35,0-17,7.65-17,17
																S7.65,55.231,17,55.231z"/>
																<path d="M135.433,438.298c21.25,0,38.533-17.283,38.533-38.533s-17.283-38.533-38.533-38.533S96.9,378.514,96.9,399.764
																S114.183,438.298,135.433,438.298z"/>
																<path d="M376.267,438.298c0.85,0,1.983,0,2.833,0c10.2-0.85,19.55-5.383,26.35-13.317c6.8-7.65,9.917-17.567,9.35-28.05
																c-1.417-20.967-19.833-37.117-41.083-35.7c-21.25,1.417-37.117,20.117-35.7,41.083
																C339.433,422.431,356.15,438.298,376.267,438.298z"/>
															</g>
														</svg>
													</a> 
												</li>
											</ul>
										</div>
										<div class="hdr-srch">
											<?php echo $search; ?>
										</div>
										<div class="signIn-signUp"> 
											<?php if (!$logged) { ?>	
												<a href="<?php echo $login; ?>" class="theme-Btn login_btn"><?php echo $text_login; ?></a> <span class="or">OR</span> <a href="<?php echo $register; ?>" class="theme-Btn signup_btn"><?php echo $text_register; ?></a> 
											<?php } ?>
										</div>
										<div class="hdr_checkout">                
											<?php echo $cart; ?>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<?php if ($categories) { ?>	
						<div class="menuBar">
							<div class="fix-container">
								<ul class="menu">
									<li> <a href="javascript:void(0);" class="more_menu">
										<div class="js-menu"> <span class="menu_lbl"><?php echo $text_category_menu; ?></span> </div>
									</a>
									<div class="js_drop_menu">
										<ul id="menu-v">
											<?php foreach ($categories as $category) { ?>
												<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
													<?php if ($category['children']) { ?>
														<div class="nav-flyout">
															<div class="inner-container">
																<div class="wrap_box">
																	<?php $i=1;
																		foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) {
																			foreach ($children as $child) { 
																			?>
																			<div class="grid">
																				<div class="cat-menu">
																					<div class="inBox"> <a href="<?php echo $child['href']; ?>" class=""><?php echo $child['name']; ?></a>
																						
																						<?php if ($child['children']) { ?>
																							<?php $count_child_child = 0; ?>
																							<?php foreach (array_chunk($child['children'], ceil(count($child['children']) / $child['column'])) as $children_children) { ?>
																								<ul class="sub-categories nav-main-subnav"> 
																									<?php foreach ($children_children as $child_child) { ?>
																										<?php if($count_child_child==6) break; ?>
																										<li><a href="<?php echo $child_child['href']; ?>"><?php echo $child_child['name']; ?></a></li>
																										<?php $count_child_child++; ?>	
																									<?php } ?>
																								</ul>
																							<?php } ?>
																							<?php if($count_child_child>=1){ ?>
																								<a class="linkmore" href="<?php echo $child['href'] ?>"><?php echo $text_category_view_all; ?></a> 
																							<?php } ?>
																						<?php } ?>
																						
																					</div>
																				</div>
																				<!--Cat Menu--> 
																			</div>
																			<!--Grid list-->
																			<?php if($i%4==0){ echo '<div class="clear"></div>'; } ?>
																			<?php $i++; }
																		} ?>
																</div><!--wrap  box-->
															</div><!--inner-container-->
														</div><!--nav flyout-->
														
													<?php } ?>
													
												</li>
												<!--List-->
											<?php } ?>
										</ul>
										<div class="moreCatgry"><a href="<?php echo $view_all_categories; ?>"><?php echo $text_category_more; ?></a></div>
									</div><!--js drop menu-->
									</li>
									<li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
									<?php foreach ($categories as $category) { ?>
										<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>          
									<?php } ?>          
								</ul>
							</div><!--fix container-->
						</div><!--menu bar-->
					<?php } ?>  
				</header>
				
				<!--[// header end here ]-->
				
				<?php if($api_checkout_process === true) { ?>
				</div>
			<?php } ?>			