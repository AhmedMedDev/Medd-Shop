<?php echo $header; ?>
<div id="body" >
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
	
	<?php if ($attention) { ?>
	<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<?php } ?>
	<?php if ($success) { ?>
	<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<?php } ?>
	<?php if ($error_warning) { ?>
	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
	</div>
	<?php } ?>
		
	<div class="main-area">
            <div id="modal-4" class="md-modal md-effect-1 md-show">
                            <div class="md-content">
                                    <div class="custom-content">


                                            <div class="shop-with-friends-modal">
                                                    <img src="catalog/view/theme/growcer/images/banner-img2.jpg" class="shop-with-friends-img" alt="">


                                                    <div class="modal-body">
                                                            <div class="centered">
                                                                    <h2><?php echo $text_user_wants_to_shop_with_you; ?> </h2>
                                                                    <div class="ic-strikethrough-header">
                                                                            <h3><?php echo $text_shop_with_friends; ?></h3>
                                                                    </div>
                                                                    <p><?php echo $text_shop_with_friend_and_get; ?></p>
                                                                    <div class="gap"></div>
                                                            </div>
                                                            <div class="row">
                                                                <form method="post" action="" id="share_cart_form">
                                                                    <div class="col-md-6">
                                                                            <div class="pull-right">
                                                                                    <button type="button" data-dismiss="modal" class="themeBtn medium sharecart" data-custom="2"><?php echo $text_decline_share_cart; ?></button>
                                                                            </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                            <div class="pull-left">
                                                                                    <button class="themeBtn medium sharecart" data-custom="1"><?php echo $text_join_share_cart; ?></button>
                                                                            </div>
                                                                    </div>
                                                                    <input type="hidden" name="cart_sharing_approved" value="0" id="cart_sharing_approved" />
                                                                </form>
                                                            </div>
                                                            <div class="gap"></div>
                                                    </div>



                                            </div>

                                    </div>
                            </div>
                    </div>
                    <div class="md-overlay"></div>
        </div>
</div>
<script>
    $(document).ready(function(){
        $('.sharecart').on('click',function(){
                var share_cart_val = $(this).data('custom');
                $('#cart_sharing_approved').val(share_cart_val);
                $('#share_cart_form').submit();
                
        });
    });
</script>
<div id="pop_up_main_container"></div>
<?php echo $footer; ?>            