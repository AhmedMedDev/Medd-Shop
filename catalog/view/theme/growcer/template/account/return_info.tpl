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
            <div class="heading"><?php echo $heading_title; ?></div>
            <div class="tbl-scroll">
				<table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th colspan="2"><?php echo $text_return_detail; ?></th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td><b><?php echo $text_return_id; ?></b> #<?php echo $return_id; ?><br />
					  <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
					<td><b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
					  <b><?php echo $text_date_ordered; ?></b> <?php echo $date_ordered; ?></td>
				  </tr>
				</tbody>
			  </table>
            </div>
			<div class="gap"></div>
			<div class="heading"><?php echo $text_product; ?></div>
			<div class="tbl-scroll">
			  <table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th style="width: 33.3%;"><?php echo $column_product; ?></th>
					<th style="width: 33.3%;"><?php echo $column_model; ?></th>
					<th style="width: 33.3%;"><?php echo $column_quantity; ?></th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td><?php echo $product; ?></td>
					<td><?php echo $model; ?></td>
					<td><?php echo $quantity; ?></td>
				  </tr>
				</tbody>
			  </table>
			  <table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th style="width: 33.3%;"><?php echo $column_reason; ?></th>
					<th style="width: 33.3%;"><?php echo $column_opened; ?></th>
					<th style="width: 33.3%;"><?php echo $column_action; ?></th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td><?php echo $reason; ?></td>
					<td><?php echo $opened; ?></td>
					<td><?php echo $action; ?></td>
				  </tr>
				</tbody>
			  </table>
			</div>
            <div class="gap"></div>
			<?php if ($comment) { ?>
			<div class="heading"><?php echo $text_product; ?></div>
				<div class="tbl-scroll">
				  <table class="tbl-normal tbl-responsive">
					<thead>
					  <tr>
						<th><?php echo $text_comment; ?></th>
					  </tr>
					</thead>
					<tbody>
					  <tr>
						<td><?php echo $comment; ?></td>
					  </tr>
					</tbody>
				  </table>
				</div>
				<div class="gap"></div>
			<?php } ?>	
			<?php if ($histories) { ?>
			<div class="heading"><?php echo $text_history; ?></div>
			<div class="tbl-scroll">
			  <table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th style="width: 33.3%;"><?php echo $column_date_added; ?></th>
					<th style="width: 33.3%;"><?php echo $column_status; ?></th>
					<th style="width: 33.3%;"><?php echo $column_comment; ?></th>
				  </tr>
				</thead>
				<tbody>
				  <?php foreach ($histories as $history) { ?>
				  <tr>
					<td><?php echo $history['date_added']; ?></td>
					<td><?php echo $history['status']; ?></td>
					<td><?php echo $history['comment']; ?></td>
				  </tr>
				  <?php } ?>
				</tbody>
			  </table>
			</div>
			<div class="gap"></div>
			  <?php } ?>
            <div class="gap"></div>
            <div class="buttons clearfix">
              <div class="pull-right"><a class="themeBtn" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a></div>
            </div>
            <div class="gap"></div>
          </div>
        </div>
      </div>
    </div>
	<div class="row">
	  <div class="col-md-12 column">
		<?php echo $content_bottom; ?>
	  </div>
	</div>
  </div>
  <!--body end here--> 
<?php echo $footer; ?>