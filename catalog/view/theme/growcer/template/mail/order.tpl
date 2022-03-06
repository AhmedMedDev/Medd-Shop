<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="Your Page Description" />
<title><?php echo $title; ?></title>
</head>
<body bgcolor="#ececec" style="margin:0 auto; padding:0;">
<table width="600" cellspacing="0" cellpadding="0" border="0"  style="margin:0 auto;font-family:arial;">
  <tr> 
    <!-- header start here-->
    <td><table cellspacing="0" border="0" width="100%" style="padding:5px 0  10px 0;">
        <tr>
          <td align="center"><a href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img src="<?php echo $logo; ?>" alt="<?php echo $store_name; ?>" style="border: none;" /></a></td>
        </tr>
      </table></td>
    <!-- header end here--> 
  </tr>
  
  <!-- nav end here--> 
  
  <!--content start here-->
  <tr>
    <td style="background:#fff;vertical-align:top;  border:solid 1px #ccc;"><table width="100%" cellspacing="20" cellpadding="0" border="0">
        <tr>
          <td><table width="100%" cellpadding="0" border="0" style="padding:0;">
              <tr>
                <td style="vertical-align: bottom;">
				<p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0;"><?php echo $text_greeting; ?></p>
				<br>
				<?php if ($customer_id) { ?>
				<p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0;"><?php echo $text_link; ?></p>
				<p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0;"><a href="<?php echo $link; ?>"><?php echo $link; ?></a></p>
				<?php } ?>
				<?php if ($download) { ?>
				<p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0;"><?php echo $text_download; ?></p>
				<p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0;"><a href="<?php echo $download; ?>"><?php echo $download; ?></a></p>
				<?php } ?>
				<table style="border-collapse:collapse;width:100%;border-top:1px solid #ddd;border-left:1px solid #ddd;margin-bottom:20px">
                    <thead>
                      <tr>
                        <td colspan="2" style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_order_detail; ?></td>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;" width="50%"><b><?php echo $text_order_id; ?></b> <?php echo $order_id; ?><br>
                          <b><?php echo $text_date_added; ?></b> <span data-term="goog_1353833176" class="aBn" tabindex="0"><span class="aQJ"><?php echo $date_added; ?></span></span><br>
                          <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br>
                          <?php if ($shipping_method) { ?>
						  <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
						  <?php } ?></td>
                        <td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;" width="50%">
						<b><?php echo $text_email; ?></b> <?php echo $email; ?><br />
						<b><?php echo $text_telephone; ?></b> <?php echo $telephone; ?><br />
						<b><?php echo $text_ip; ?></b> <?php echo $ip; ?><br />
						<b><?php echo $text_order_status; ?></b> <?php echo $order_status; ?><br /></td>
                      </tr>
                    </tbody>
                  </table>
				  
				  <?php if ($comment) { ?>
				  <table style="border-collapse:collapse;width:100%;border-top:1px solid #ddd;border-left:1px solid #ddd;margin-bottom:20px">
					<thead>
					  <tr>
						<td style="font-size: 12px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; background-color: #ddd; font-weight: bold; text-align: left; padding: 7px; color: #222222;"><?php echo $text_instruction; ?></td>
					  </tr>
					</thead>
					<tbody>
					  <tr>
						<td style="font-size: 12px;	border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; text-align: left; padding: 7px;"><?php echo $comment; ?></td>
					  </tr>
					</tbody>
				  </table>
				  <?php } ?>
				  
                  <table style="border-collapse:collapse;width:100%;border-top:1px solid #ddd;border-left:1px solid #ddd;margin-bottom:20px">
                    <thead>
                      <tr>
                        <td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222" width="50%"><?php echo $text_payment_address; ?></td>
                         <?php if ($shipping_address) { ?>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222" width="50%"><?php echo $text_shipping_address; ?></td>
						<?php } ?>
                      </tr>
                    </thead>					
					<tbody>
					  <tr>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $payment_address; ?></td>
						<?php if ($shipping_address) { ?>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $shipping_address; ?></td>
						<?php } ?>
					  </tr>
					</tbody>
					
                  </table>
				  <?php if( isset( $_SESSION['default'] ) && isset( $_SESSION['default']['delivery_time'] ) && $_SESSION['default']['delivery_time'] != '' ) { ?>
				  <table style="border-collapse: collapse; width: 100%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;">
					<thead>
					  <tr>
						 <td style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;">Delivery Time</td>
					  </tr>
					</thead>
					<tbody>
					  <tr>
						  <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><b><?php echo $_SESSION['default']['delivery_time']."(".$_SESSION['time_zone'].")"; ?></b></td>
					  </tr>
					</tbody>
				  </table>
				  <?php } ?>
                  <table style="border-collapse:collapse;width:100%;border-top:1px solid #ddd;border-left:1px solid #ddd;margin-bottom:20px">
                    <thead>					  
					  <tr>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_product; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_model; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_quantity; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_price; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo $text_total; ?></td>
					  </tr>
					  
                    </thead>					
					<tbody>
					  <?php foreach ($products as $product) { ?>
					  <tr>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $product['name']; ?>
						  <?php foreach ($product['option'] as $option) { ?>
						  <br />
						  &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
						  <?php } ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $product['model']; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $product['quantity']; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $product['price']; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $product['total']; ?></td>
					  </tr>
					  <?php } ?>
					  <?php foreach ($vouchers as $voucher) { ?>
					  <tr>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $voucher['description']; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;">1</td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $voucher['amount']; ?></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;"><?php echo $voucher['amount']; ?></td>
					  </tr>
					  <?php } ?>
					</tbody>
									
					<tfoot>
					  <?php foreach ($totals as $total) { ?>
					  <tr>
						<td colspan="4" style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:right;padding:7px"><b><?php echo $total['title']; ?>:</b></td>
						<td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:right;padding:7px"><?php echo $total['text']; ?></td>
					  </tr>
					  <?php } ?>
					</tfoot>
					
					
                  </table>
                  <p style="margin-top:0px;margin-bottom:20px; font-size:12px;"><?php echo $text_footer; ?></p></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>  
</table>
</body>
</html>