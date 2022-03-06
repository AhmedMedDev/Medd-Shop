<div class="hide">
<?php echo $header; ?>
</div>
<!--body start here-->
  <div id="body">
	<div class="breadcrumb hide">
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
			<?php echo $column_left; ?>
			<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
			<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-9'; ?>
			<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
			<?php } ?>
			<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
				<div class="col-md-12">
					<div class="cms">
						<h2><?php echo $heading_title; ?></h2>
						<?php echo $description; ?>
						<?php echo $content_bottom; ?>
					</div>
				</div>
			</div>
			<?php echo $column_right; ?>
        </div>
      </div>
    </div>
  </div>
<!--body end here--> 
<div class="hide">
<?php echo $footer; ?>
</div>