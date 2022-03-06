<div class="module-sidebar">
	<div class="panel-heading"><?php echo $heading_title; ?> <span class="pull_right"><i class="icn-arrow"></i></span></div>
	<div class="panel-list">
	<div>
	  <form class="siteForm form-horizontal search-brands">
		  <select id="tokenize_mid" multiple="multiple" class="form-control">
			<?php foreach ($manufacturers as $manufacturer) { ?>
			<option value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id){ echo "SELECTED"; } ?> class="list-group-item active"><?php echo $manufacturer['name']; ?></option>
			<?php } ?>
		  </select>
		  <input type="search" value="" id="submit_src_mpid">
	  </form>
	</div>
	<ul id="brandslist" class="brandslist">
	  <?php foreach ($manufacturers as $manufacturer) { ?>
	  <li class="available_mids_<?php echo $manufacturer['manufacturer_id']; ?>" data-attr="<?php echo $manufacturer['name']; ?>"> 
		<a onclick="addTokenForSearch(this);"><img src="<?php echo $manufacturer['image']; ?>" class="brand-thumb" alt="<?php echo $manufacturer['name']; ?>"/><?php echo $manufacturer['name']; ?></a>
	  </li>
	  <?php } ?>
	</ul>
	</div>
</div>  
<script>
	var objectTokenize = $('#tokenize_mid').tokenize();
	var prev_mid = 'mid=';
	$(document).ready(function(){
		<?php 
			if(isset($mid) && !empty($mid)){
				foreach($manufacturers AS $manufacturer){
					if(in_array($manufacturer['manufacturer_id'], $mid)){
					?>
					prev_mid+= <?php echo $manufacturer['manufacturer_id']; ?>+',';
					objectTokenize.tokenAdd(<?php echo $manufacturer['manufacturer_id']; ?>, '<?php echo $manufacturer['name']; ?>');
					<?php
					}
				}
			}
		?>
		
		$('#submit_src_mpid').on('click',function(){
			var tmid = $('#tokenize_mid').val();
			/* if(jQuery.isEmptyObject(tmid)==false){ */
				searchByMFids(tmid);
			/*}*/
		});
		
	});
	function addTokenForSearch(e){
		var html = $(e).parent('li').attr('data-attr');
		mid = $(e).parent('li').attr('class').replace("available_mids_","");
		objectTokenize.tokenAdd(mid, html);
	}
	function searchByMFids(id){		
		var loc = "<?php echo $action; ?>";
		
		if(jQuery.isEmptyObject(id)===false){		
			new_mid = "mid="+id;
		}else{
			new_mid = "";
		}
		
		if(loc.indexOf('mid')>0){
			location = loc.replace(prev_mid.slice(0,-1),new_mid);	
		}else{
			separator = "?";
			if(loc.indexOf('?')>=0){
				separator = "&";
			}
			location = loc+separator+new_mid;		
		}
	}
</script>