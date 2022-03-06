<?php if (count($currencies) > 1) { ?>
<div class="change-currency">
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
		<?php foreach ($currencies as $currency) { ?>
			<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>			
				<div class="current_curncy"> 
					<span class="curncy_sign"><?php echo $currency['symbol_left']; ?></span> 
					<?php echo $text_currency; ?>
				</div>
			<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>					
				<div class="current_curncy"> 
					<span class="curncy_sign"><?php echo $currency['symbol_right']; ?></span> 
					<?php echo $text_currency; ?>
				</div>
			<?php } ?>
		<?php } ?>	
		
		<div class="dropBox">
		  <ul class="drop-links">
		  <?php foreach ($currencies as $currency) { ?>
				  <?php if ($currency['symbol_left']) { ?>
							<li class="currency-select">
								<span class="curncy_sign" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?></span> <?php echo $currency['title']; ?>
							</li>
				  <?php } else { ?>
							<li class="currency-select">
								<?php echo $currency['title']; ?> <span class="curncy_sign" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?></span>						
							</li>		  
				  <?php } ?>
		  <?php } ?>			
		  </ul>
		</div>
	  <input type="hidden" name="code" value="" />
	  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
	</form>	
</div>
<?php } ?>