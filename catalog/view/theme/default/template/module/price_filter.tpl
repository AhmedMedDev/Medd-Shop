<div class="divider"></div>
<div class="panel-heading">
	<?php echo $heading_title; ?>
	<span class="pull_right"><i class="icn-arrow"></i></span>
</div>
<div class="panel-list">
	<div class="price-range">
				<div id="scale-slider"></div>
	</div>	
	<!--
	<div class="panel-footer text-right">
		<button type="button" id="button-price-filter" class="themeBtn"><?php echo $button_filter; ?></button>
	</div>
	-->
	<div class="gap"></div>
</div>
<div class="divider"></div>

<script type="text/javascript">

$("#scale-slider")
	.slider({ 
        min: <?php echo round($price_range_min) ; ?>, 
        max: <?php echo round($price_range_max) ; ?>, 
        range: true, 
        values: [<?php echo (isset($price_range[0])?$price_range[0]:0); ?>, <?php echo (isset($price_range[1])?$price_range[1]:$price_range_max); ?>] 
    })
                        
    .slider("pips", {
        rest: false,
		<?php if (!$right_code) { ?>
		prefix: "<?php echo $price_code; ?>"
		<?php } else { ?>
		suffix: "<?php echo $price_code; ?>"
		<?php } ?>
    })
                        
    .slider("float");
(function( $ ) {
  $(function() {
    //$('#button-price-filter').on('click', function() {
	var callLock = false;
    $('.price-range #scale-slider,.price-range #scale-slider span').mouseup(function() {
		if(callLock==true) return;
		callLock = true;
		priceRange = [];
		$('#scale-slider .ui-slider-tip').each(function(){
			priceRange.push($(this).html());
		});
		location = "<?php echo $action; ?>"+"&price_range="+priceRange.join("-");
	
		/* $('.<?php echo $product_class; ?>').hide();
		$('.clearfix').remove();
		$('.<?php echo $product_class; ?>').each(function(){
			if( $(this).find( ".price span.price-new" ).length ) {
				var price = $(this).find( ".price span.price-new" ).html().replace('<?php echo $price_code; ?>','').replace(',','');
			} else {
				var text = $(this).find('.price').html().replace('<?php echo $price_code; ?>','');
				if( $(this).find( ".price span" ).length ) {
					var price = text.substring(0,text.indexOf('<span')).replace(',','');
				} else {
					var price = text.replace(',','');
				}
				
			}	
			
			price = parseInt(price);
			
			if( !isNaN(price) && (price > priceRange[0] && price < priceRange[1]) ){
				$(this).fadeIn("slow");
			}
		}); */
		
	});
  });
})(jQuery);

</script>