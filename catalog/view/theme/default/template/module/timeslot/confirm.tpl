<?php if (!isset($redirect)) { ?>
<div class="gap"></div>
<div class="tbl-scroll">

  <table class="tbl-normal tbl-responsive">
    <thead>
      <tr>
        <th class="text-left"><?php echo $column_name; ?></th>
        <th class="text-left"><?php echo $column_model; ?></th>
        <th class="text-right"><?php echo $column_quantity; ?></th>
        <th class="text-right"><?php echo $column_price; ?></th>
        <th class="text-right"><?php echo $column_total; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="text-left pro-mame">
		  <span class="cellcaption"><?php echo $column_name; ?></span>
		  <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?>
          <?php if($product['recurring']) { ?>
          <br />
          <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
          <?php } ?></td>
        <td class="text-left">
			 <span class="cellcaption"><?php echo $column_model; ?></span>
			<?php echo $product['model']; ?>
		</td>
        <td class="text-right">
			 <span class="cellcaption"><?php echo $column_quantity; ?></span>
			<?php echo $product['quantity']; ?>
		</td>
        <td class="text-right">
			<span class="cellcaption"><?php echo $column_price; ?></span>
			<?php echo $product['price']; ?>
		</td>
        <td class="text-right">
			<span class="cellcaption"><?php echo $column_total; ?></span>
			<?php echo $product['total']; ?>
		</td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="text-left"><?php echo $voucher['description']; ?></td>
        <td class="text-left"></td>
        <td class="text-right">1</td>
        <td class="text-right"><?php echo $voucher['amount']; ?></td>
        <td class="text-right"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td colspan="4" class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
        <td class="text-right"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
	<?php
		$time_zone = '';
		if(!empty($_SESSION['time_zone'])){
			$time_zone = " ( ".$_SESSION['time_zone']." ) " ;
		}
		$delivery_time = $timing . $time_zone;
	?>
	<?php if(!empty($delivery_time)) : ?>
  <table class="tbl-normal tbl-responsive">
		<thead>
		  <tr>
			<td class="text-left"><?php echo $text_delivery_time; ?></td>
		  </tr>
		</thead>
		<tbody>
			<tr>
				<td class="text-left"><b>
					<?php echo $delivery_time; ?>
				</b></td>
			</tr>
		</tbody>
	</table>
	<?php endif; ?>
<div class="gap"></div>
<?php echo $payment; ?>
</div>
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?>