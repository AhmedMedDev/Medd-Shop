<div class="module-sidebar">
	<div class="panel-heading">
		<?php echo $heading_title; ?>
		<span class="pull_right"><i class="icn-arrow"></i></span>
	</div>
	<div class="panel-list">
		<div class="price-range">
			<div id="scale-slider"></div>
			<div class="gap"></div>
		</div>
		<div class="applyRangeBtn">
			<button onclick="javascript:applyPriceRange();" class="themeBtn"><?php echo $apply_btn;?></button>
		</div>
	</div>
</div>
<script type="text/javascript">
	var prev_price_range = "price_range=" + "<?php echo (isset($price_range[0])?$price_range[0]:0); ?>-<?php echo (isset($price_range[1])?$price_range[1]:$price_range_max)?>";
	$("#scale-slider")
		.slider({
			min: <?php echo floor($price_range_min) ; ?>,
			max: <?php echo ceil($price_range_max) ; ?>,
			range: true,
			values: [<?php echo (isset($price_range[0])?$price_range[0]:0); ?>, <?php echo (isset($price_range[1])?$price_range[1]:$price_range_max); ?>],
			slide: function(event, ui) {
				if (ui.values[0] == ui.values[1]) {
					return false;
				}
			}
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
	(function($) {
		$(function() {
			var callLock = false;
			$('.price-range #scale-slider,.price-range #scale-slider span').on('mouseup', function() {
				if (callLock == true) return;
				callLock = true;
				priceRange = [];
				$('#scale-slider .ui-slider-tip').each(function() {
					priceRange.push($(this).html());
				});
				var loc = "<?php echo $action; ?>";
				new_price_range = "price_range=" + priceRange.join("-");
				if (loc.indexOf('price_range') > 0) {
					//location = loc.replace(prev_price_range,new_price_range);
				} else {
					separator = "?";
					if (loc.indexOf('?') >= 0) {
						separator = "&";
					}
					//location = loc+separator+new_price_range;
				}
			});
		});
	})(jQuery);

	function applyPriceRange() {
		var loc = "<?php echo $action; ?>";
		priceRange = [];
		$('#scale-slider .ui-slider-tip').each(function() {
			priceRange.push($(this).html());
		});
		new_price_range = "price_range=" + priceRange.join("-");
		if (loc.indexOf('price_range') > 0) {
			location = loc.replace(prev_price_range, new_price_range);
		} else {
			separator = "?";
			if (loc.indexOf('?') >= 0) {
				separator = "&";
			}
			location = loc + separator + new_price_range;
		}

	}
</script>
<?php
if(isset($custom_css)){
	echo '<style>';
		echo '.ui-slider-pip.ui-slider-pip-last .ui-slider-label{'.$custom_css.'}';
	echo '</style>';
}
?>