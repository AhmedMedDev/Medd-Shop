<?php echo $header; ?>
 <!--body start here-->
  <div id="body">
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
    <div class="page-head clearfix">
      <div class="fix-container">
        <div class="row">
          <div class="col-md-12">
            <div class="brands">
              <div class="heading"><?php echo $heading_title; ?></div>
			  <?php if ($categories) { ?>
              <p class="b-index"><strong><?php echo $text_index; ?></strong>
				<?php foreach ($categories as $category) { ?>
				&nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
				<?php } ?>
			  </p>
			  <?php foreach ($categories as $category) { ?>
              <h4 id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h4>
				<?php if ($category['manufacturer']) { ?>
				  <?php foreach (array_chunk($category['manufacturer'], 40) as $manufacturers) { ?>
				  <?php 
					$micount = 0;
					$mflag = true;
					$prev_close_flag = false;
					if($mflag){	
						echo '<div class="row">';
						$mflag=false;
					}	
				    foreach ($manufacturers as $manufacturer) { 
						
						if(($micount%1)==0 || $micount==0){
							if($prev_close_flag){
								echo '</ul></div>';
							}
							echo '<div class="col-md-3">';
							echo '<ul>';
							$prev_close_flag=true;
						}
						
						?>
						<li><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></li>
						<?php
						$micount++; 
					} ?>
					<?php
					if($prev_close_flag){
						echo '</ul></div>';
					}
					if(!$mflag){
						echo '</div>';
					}
					?>
				  <?php } ?>
				<?php } ?>
			  <?php }/*for*/ ?>
			  <?php } ?>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--body end here--> 
<?php echo $footer; ?>