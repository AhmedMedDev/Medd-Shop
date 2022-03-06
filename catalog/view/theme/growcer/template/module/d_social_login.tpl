<?php if (!$islogged) { ?>
<style>
.socialBtns span{color: #fff; }
.l-side {
    height: 20px;
    left: 10px;
    position: absolute;
    width: 20px;
	color: #fff;
}
.socialBtns .dsl-icon{font-size: 20px;}
.socialBtns .dsl-button.dsl-button-huge{font-size: 16px;}
</style>
<?php if($error){ ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i><?php echo $error; ?><button type="button" class="close" data-dismiss="alert"></button></div>
<?php } ?>
<ul class="clearfix">
	<?php foreach($providers as $key => $provider){ ?>
	<?php if ($provider['enabled']) { ?>
	<li>
		<div class="socialBtns" style="background-color:<?php echo $provider['background_color'];?>"> 
			<a id="dsl_<?php echo $provider['id']; ?>_button" class="dsl-button dsl-button-<?php echo $size; ?>" href="index.php?route=module/d_social_login/login&provider=<?php echo $key; ?>">
				<span class="l-side">
					<span class="<?php echo ($key != 'Google') ? 'dsl-icon' : ''; ?> <?php echo $provider['icon']; ?>"></span>
				</span>
				<span class="r-side"><?php echo $provider['heading']; ?></span>
			</a> 
		</div>
	</li>
	<?php } ?>
	<?php } ?>
</ul>
<script>
$( document ).ready(function() {
  $('.dsl-button').on('click', function(){
    $('.dsl-button').find('.l-side').spin(false);
    $(this).find('.l-side').spin('<?php echo $size; ?>', '#fff');
    
    $('.dsl-button').find('.dsl-icon').removeClass('dsl-hide-icon');
    $(this).find('.dsl-icon').addClass('dsl-hide-icon');
  })
})
</script>
<?php } ?>