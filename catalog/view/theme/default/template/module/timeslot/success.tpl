<?php echo $header; ?>
<!--body start here-->
  <div id="body">
	<?php if ($api_checkout_process !== true) { ?>
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
	<?php } ?>
    <div class="page-head clearfix">
      <div class="fix-container">
        <div class="row">		
			<div class="col-md-12">
				<div class="cms">
				<h2><?php echo $heading_title; ?></h2>
				<?php echo $text_message; ?>
				
				<?php 
					if( isset( $delivery_time ) && $delivery_time != "" ) { 
						echo "<p>" . $text_delivered_on;
						echo "<strong> ".$delivery_time." ( ".$_SESSION['time_zone']." )</strong></p>";
					}
				?>
				
				<a href="<?php echo $continue; ?>" class="themeBtn"><?php echo $button_continue; ?></a>
				</div>
			</div>
        </div>
      </div>
    </div>
  </div>
<!--body end here--> 
<?php echo $footer;