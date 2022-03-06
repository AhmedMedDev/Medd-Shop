<div class="list-group">
<h3 style="padding:8px 0;margin:0;text-align:center;width:100%;background:#000;color:#FFF;"><?php echo $heading_title; ?></h3>
 
 
 <?php foreach ($manufacturers as $manufacturer) { ?>
  <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id) { ?>
  <a href="<?php echo $manufacturer['href']; ?>" class="list-group-item active"><?php echo $manufacturer['name']; ?>
  <?php if($manufacturer['image']){ ?>
<img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" class="img-responsive"  width="20px" style="float:right;"/>
<?php } ?></a>
  <?php } else { ?>
  <a href="<?php echo $manufacturer['href']; ?>" class="list-group-item"><?php echo $manufacturer['name']; ?>
   <?php if($manufacturer['image']){ ?>
  <img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>" class="img-responsive" width="20px"  style="float:right;"/>
  <?php } ?>
  <?php } ?></a>
  <?php } ?>
  
  
  
  <!-- 
 for manufacturer list remove if you want without side navigation
 -->
 
 <!--
  <select onchange="gobrandpage(this.value)" class="form-control">
  	<?php foreach ($manufacturers as $manufacturer) { ?>
    <option value="<?php echo $manufacturer['href']; ?>" <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id){ echo "SELECTED"; } ?> class="list-group-item active"><?php echo $manufacturer['name']; ?></option>
    <?php } ?>
  
  </select>-->
  
  
  
</div>
<script>
	function gobrandpage(id){
		window.location.href=id;
	}
</script>