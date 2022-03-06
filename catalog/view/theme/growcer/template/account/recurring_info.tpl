<?php echo $header; ?>
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
				 
				 
				<div id="content" class="col-md-12 column">
					<div class="tbl-scroll">
						<table class="tbl-normal tbl-responsive">
							<thead>
								<tr>
									<td colspan="2"><?php echo $text_recurring_detail; ?></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 50%;">
										<p><b><?php echo $text_recurring_id; ?></b> #<?php echo $recurring['order_recurring_id']; ?></p>
										<p><b><?php echo $text_date_added; ?></b> <?php echo $recurring['date_added']; ?></p>
										<p><b><?php echo $text_status; ?></b> <?php echo $status_types[$recurring['status']]; ?></p>
										<p><b><?php echo $text_payment_method; ?></b> <?php echo $recurring['payment_method']; ?></p>
									</td>
									<td class="left" style="width: 50%; vertical-align: top;">
										<p><b><?php echo $text_product; ?></b><a href="<?php echo $recurring['product_link']; ?>"><?php echo $recurring['product_name']; ?></a></p>
										<p><b><?php echo $text_quantity; ?></b> <?php echo $recurring['product_quantity']; ?></p>
										<p><b><?php echo $text_order; ?></b><a href="<?php echo $recurring['order_link']; ?>">#<?php echo $recurring['order_id']; ?></a></p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="gap"></div>
					<div class="tbl-scroll">
						<table class="tbl-normal tbl-responsive">
							<thead>
								<tr>
									<td><?php echo $text_recurring_description; ?></td>
									<td><?php echo $text_ref; ?></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 50%;">
									<p style="margin:5px;"><?php echo $recurring['recurring_description']; ?></p></td>
									<td style="width: 50%;">
									<p style="margin:5px;"><?php echo $recurring['reference']; ?></p></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="gap"></div>
					<p><?php echo $text_transactions; ?></p>
					<div class="gap"></div>
					
					<div class="tbl-scroll">
						<table class="tbl-normal tbl-responsive">
							<thead>
								<tr>
									<td><?php echo $column_date_added; ?></td>
									<td><?php echo $column_type; ?></td>
									<td><?php echo $column_amount; ?></td>
								</tr>
							</thead>
							<tbody>
								<?php if (!empty($recurring['transactions'])) { ?><?php foreach ($recurring['transactions'] as $transaction) { ?>
									<tr>
										<td><?php echo $transaction['date_added']; ?></td>
										<td><?php echo $transaction_types[$transaction['type']]; ?></td>
										<td><?php echo $transaction['amount']; ?></td>
									</tr>
								<?php } ?><?php }else{ ?>
								<tr>
									<td colspan="3" ><?php echo $text_empty_transactions; ?></td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
					</div>
					
					<div class="gap"></div>
					<?php echo $buttons; ?> 
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