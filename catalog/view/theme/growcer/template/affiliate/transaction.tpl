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
	<?php if (isset($success)) { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close" data-dismiss="alert"></button></div><div class="alert-after"></div>
		</div>
	  </div>
	  <?php } ?>
    <div class="dash-pages">
      <div class="fix-container">
		<div class="row">
          <div class="col-md-12">
		  &nbsp;
		  <?php echo $content_top; ?>
		  </div>
        </div>
        <div class="row">
			<div class="col-md-3 column">
				<div class="left-panel">
				  <?php echo $account_sidebar; ?>
				</div>
			</div>
            <div class="col-md-9 column">
			<?php echo $content_top; ?>
			<div class="heading"><?php echo $heading_title; ?></div>
			<p class="sub-heading"><?php echo $text_balance; ?> <strong><?php echo $balance; ?></strong>.</p>
			<div class="gap"></div>
			  <div class="tbl-scroll">
				<table class="tbl-normal tbl-responsive">
				  <thead>
					<tr>
					  <th class="text-left"><?php echo $column_date_added; ?></th>
					  <th class="text-left"><?php echo $column_description; ?></th>
					  <th class="text-right"><?php echo $column_amount; ?></th>
					</tr>
				  </thead>
				  <tbody>
					<?php if ($transactions) { ?>
					<?php foreach ($transactions  as $transaction) { ?>
					<tr>
					  <td class="text-left"><?php echo $transaction['date_added']; ?></td>
					  <td class="text-left"><?php echo $transaction['description']; ?></td>
					  <td class="text-right"><?php echo $transaction['amount']; ?></td>
					</tr>
					<?php } ?>
					<?php } else { ?>
					<tr>
					  <td class="text-center" colspan="5"><?php echo $text_empty; ?></td>
					</tr>
					<?php } ?>
				  </tbody>
				</table>
			  </div>
			  <div class="text-right"><?php echo $pagination; ?></div>
				<div class="gap"></div>
			  <div class="buttons clearfix">
				<div class="pull-right"><a href="<?php echo $continue; ?>" class="themeBtn greenbtn"><?php echo $button_back; ?></a></div>
			  </div>
			  <?php echo $content_bottom; ?>		
			
			
			</div>
        </div>
        <div class="row">
          <div class="col-md-12">
		  &nbsp;
		  <?php echo $content_bottom; ?>
		  </div>
        </div>
      </div>
    </div>
  </div>
  <!--body end here--> 
<?php echo $footer; ?>