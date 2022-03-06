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
		
		<!-- CSS ================================================== -->
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/reset.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/animate.min.css" />
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/common.css" />
		
		
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/tablet.css" /> 
		<link rel="stylesheet" type="text/css" href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" />
		
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
		<?php if(isset($demo_store_message)){ ?>
			<div class="demo-store-message"><?php  echo $demo_store_message; ?></div>
		<?php } ?>
		<main id="wrapper"> 
			
			
			<div class="demo-store-message"><?php echo $error_warning; ?></div>
			
			
		</main>
	</body>
</html>