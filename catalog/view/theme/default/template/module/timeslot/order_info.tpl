<?php
echo $header; 
?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
<button type="button" class="close" data-dismiss="alert"></button>
</div>
<div class="alert-after"></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
<button type="button" class="close" data-dismiss="alert"></button>
</div>
<div class="alert-after"></div>
<?php } ?>
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
            <div class="tbl-scroll">
				<table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th class="text-left" colspan="2"><?php echo $text_order_detail; ?></th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td class="text-left" style="width: 50%;"><?php if ($invoice_no) { ?>
					  <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
					  <?php } ?>
					  <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
					  <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
					<td class="text-left"><?php if ($payment_method) { ?>
					  <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
					  <?php } ?>
					  <?php if ($shipping_method) { ?>
					  <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
					  <?php } ?></td>
				  </tr>
				</tbody>
			  </table>
			</div>
			<div class="gap"></div>
			<div class="tbl-scroll">
			  <table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th class="text-left" style="width: 50%;"><?php echo $text_payment_address; ?></th>
					<?php if ($shipping_address) { ?>
					<th class="text-left"><?php echo $text_shipping_address; ?></th>
					<?php } ?>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td class="text-left"><?php echo $payment_address; ?></td>
					<?php if ($shipping_address) { ?>
					<td class="text-left"><?php echo $shipping_address; ?></td>
					<?php } ?>
				  </tr>
				</tbody>
			  </table>
			</div>
			<div class="gap"></div>
			<div class="tbl-scroll">
				<table class="tbl-normal tbl-responsive">
				  <thead>
					<tr>
					  <th><?php echo $column_name; ?></th>
					  <th><?php echo $column_model; ?></th>
					  <th><?php echo $column_quantity; ?></th>
					  <th><?php echo $column_price; ?></th>
					  <th><?php echo $column_total; ?></th>
					  <?php if ($products) { ?>
					  <th style="width: 20px;"></th>
					  <?php } ?>
					</tr>
				  </thead>
				  <tbody>
					<?php foreach ($products as $product) { ?>
					<tr>
					  <td class="text-left"><?php echo $product['name']; ?>
						<?php foreach ($product['option'] as $option) { ?>
						<br />
						&nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
						<?php } ?></td>
					  <td><?php echo $product['model']; ?></td>
					  <td><?php echo $product['quantity']; ?></td>
					  <td><?php echo $product['price']; ?></td>
					  <td><?php echo $product['total']; ?></td>
					  <td style="white-space: nowrap;"><?php if ($product['reorder']) { ?>
						<a href="<?php echo $product['reorder']; ?>" data-toggle="tooltip" title="<?php echo $button_reorder; ?>" class="btn btn-primary"><i class="fa fa-shopping-cart"></i></a>
						<?php } ?>
						<a href="<?php echo $product['return']; ?>" data-toggle="tooltip" title="<?php echo $button_return; ?>" class="btn btn-danger"><i class="fa fa-reply"></i></a></td>
					</tr>
					<?php } ?>
					<?php foreach ($vouchers as $voucher) { ?>
					<tr>
					  <td><?php echo $voucher['description']; ?></td>
					  <td></td>
					  <td>1</td>
					  <td><?php echo $voucher['amount']; ?></td>
					  <td><?php echo $voucher['amount']; ?></td>
					  <?php if ($products) { ?>
					  <td></td>
					  <?php } ?>
					</tr>
					<?php } ?>
				  </tbody>
				  <tfoot>
					<?php foreach ($totals as $total) { ?>
					<tr>
					  <td colspan="3"></td>
					  <td><b><?php echo $total['title']; ?></b></td>
					  <td><?php echo $total['text']; ?></td>
					  <?php if ($products) { ?>
					  <td></td>
					  <?php } ?>
					</tr>
					<?php } ?>
				  </tfoot>
				</table>
			  </div>
			  <div class="gap"></div>
			  <?php if ($comment) { ?>
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
			  <?php if ( $delivery_time ) { ?>
			  <div class="heading"><?php echo $text_delivery_time; ?></div>
			  <div class="tbl-scroll">
				  <table class="tbl-normal tbl-responsive">
					<tbody>
					  <tr>
						<td><?php echo $delivery_time."(".$_SESSION['time_zone'].")"; ?></td>
					  </tr>
					</tbody>
				  </table>
			  </div>
			  <?php } ?>
			  <?php if ($histories) { ?>
			  <div class="heading"><?php echo $text_history; ?></div>
			  <div class="tbl-scroll">
			  <table class="tbl-normal tbl-responsive">
				<thead>
				  <tr>
					<th><?php echo $column_date_added; ?></th>
					<th><?php echo $column_status; ?></th>
					<th><?php echo $column_comment; ?></th>
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