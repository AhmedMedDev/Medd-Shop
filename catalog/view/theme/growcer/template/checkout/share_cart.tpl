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
        <div id="modal-3" class="md-modal md-effect-1 md-show">
            <div class="md-content">
                <div class="custom-content">
                    <div class="shop-with-friends-modal">
                        <img src="catalog/view/theme/growcer/images/banner-img2.jpg" class="shop-with-friends-img" alt="">
                        <div class="centered">
                            <div class="ic-strikethrough-header">
                                <h3><?php echo $text_invite_people; ?></h3>
                            </div>
                            <p><?php echo $text_share_this_link; ?></p>
                            <div class="gap"></div>
                            <div class="width50">
                                
                                <input type="text" class="custom-filed" id="share_cart_url1" readonly="readonly" value="<?php echo $share_url; ?>">
                                <div class="gap"></div>
                                <a class="themeBtn white" id="share_cart_link" onclick="javascript:copyShareCartLink('share_cart_url1','share_cart_link');"><?php echo $copy_link; ?></a>
                                <button class="themeBtn" type="button" data-dismiss="modal" onclick="location.href = '<?php echo $home_url; ?>';"><?php echo $text_lets_shop; ?></button>
                                <div class="gap"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>					
        <div class="md-overlay"></div>
    </div>
</div>
<div id="pop_up_main_container"></div>
<?php echo $footer; ?>            