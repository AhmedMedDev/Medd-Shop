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
        <div id="modal-2" class="md-modal md-effect-1 md-show">
            <div class="md-content">
                <div class="custom-content">
                    <div class="shop-with-friends-modal">
                        <img src="catalog/view/theme/growcer/images/banner-img2.jpg" class="shop-with-friends-img" alt="">
                        <div class="centered">
                            <div class="ic-strikethrough-header">
                                <h3><?php echo $text_shop_with_friends; ?></h3>
                            </div>
                            <p><?php echo $text_share_your_cart_with_friends; ?></p>
                        </div>
                        <div class="row">
                            <div class="col-md-6">

                                <div class="recent-carts">
                                    <h2><?php echo $text_recent_carts; ?></h2>
                                    <ul>
                                        <?php 
                                        foreach($data['cart_data'] as $key=>$val){
                                        ?>
                                        <li>
                                            <a href="<?php echo $data['cart_update_url'].'?cart_id='.$key; ?>"><span class="date"><?php echo date('m/d/y',strtotime($val['mc_datetime'])); ?></span><span class="cart-item"><?php echo $val['total_items']; ?> <?php echo $text_cart_items; ?> </span><?php if(strlen($val['mc_name'])>=1){ echo '( '.$val['mc_name'].' )';}else{ echo '( Shared Cart )';} ?></a>
                                            <span class="desc"><?php echo $val['mc_description']; ?></span>
                                        </li>                                                                                    
                                        <?php
                                        }
                                        ?>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="new-carts">
                                    <h2><?php echo $text_create_new_cart; ?></h2>
                                    <form class="siteForm" method="post" id="create_new_cart">
                                        <input type="text" onfocus="if (this.value == '<?php echo $text_cart_title; ?>')
                                                                                                {this.value = '';}" onblur="if (this.value == '')
                                                                                                {this.value = '<?php echo $text_cart_title; ?>';}" value="<?php echo $text_cart_title; ?>" name="cart_name" id="cart_name" />
                                        <br/><br/>
                                        <textarea id="cart_description" name="cart_description" class="height120" onfocus="if (this.value == '<?php echo $text_cart_description; ?>')
                                                                                                {this.value = '';}" onblur="if (this.value == '')
                                                                                                {this.value = '<?php echo $text_cart_description; ?>';}" ><?php echo $text_cart_description; ?></textarea>
                                        <div class="gap"></div>
                                        <input type="submit" value="<?php echo $text_start_new_cart; ?>" name="new_cart" />
                                        <a href="<?php echo $cart_url; ?>" class="themeBtn" ><?php echo $text_view_cart; ?></a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="md-overlay"></div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#create_new_cart').on('submit', function () {
            if ($('#cart_name').val() == 'Add a Title for this shared cart (optional)') {
                $('#cart_name').val('');
            }
            if ($('#cart_description').val() == 'Add a Description for this shared cart (optional)') {
                $('#cart_description').html('');
            }
        });
    });
</script>
<div id="pop_up_main_container"></div>
<?php echo $footer; ?>            