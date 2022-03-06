<?php if (count($languages) > 1) { ?>
<div class="language">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
    <?php foreach ($languages as $language) { ?>
		<?php if ($language['code'] == $code) { ?>
				<div class="current-lang"> 
					<span class="curncy_sign">
						<img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
					</span> 
					<?php echo $text_language; ?>
				</div>		
		<?php } ?>
    <?php } ?>
		<div class="dropBox">
		  <ul class="drop-links">
			  <?php foreach ($languages as $language) { ?>
				<li>
					<a href="<?php echo $language['code']; ?>">
						<img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
					</a>
				</li>
			  <?php } ?>		  
		  </ul>
		</div>	
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
