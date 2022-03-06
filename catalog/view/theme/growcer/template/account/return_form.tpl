<?php echo $header; ?>
<!--body start here-->
  <div id="body">
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
	<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
		</div>
			<div class="alert-after"></div>
	<?php } ?>
    <div class="dash-pages">
      <div class="fix-container">
		<div class="row">
		  <div class="col-md-12">
		  &nbsp;
		  <?php echo $content_top; ?>
		  </div>
		</div>
		<div class="row">
          <div class="col-md-3 column">
            <div class="left-panel">
              <?php echo $account_sidebar; ?>
            </div>
          </div>
          <div class="col-md-9 column">

			<div class="dash-page-content">
				<!--div class="dashboard-tabs"-->
				<div class="account-nav">
					<!--ul class="tabs"-->
					<a href="javascript:void(0);" class="toggle-account-nav"><?php echo $nav_text_return; ?><span class="tantoo"></span></a>
					<ul>
				  <li><a data-for="#order_history" href="<?php echo $order; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_order; ?>"><?php echo $nav_text_order; ?></a></li>
				  <li><a data-for="#download" href="<?php echo $download; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_download; ?>"><?php echo $nav_text_download; ?></a></li>
				  <?php if($reward){ ?>
				  <li><a data-for="#reward" href="<?php echo $reward; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_reward; ?>"><?php echo $nav_text_reward; ?></a></li>
				  <?php } ?>
				  <li class="active"><a data-for="#return" href="<?php echo $return; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_return; ?>"><?php echo $nav_text_return; ?></a></li>
				  <li><a  data-for="#transaction" href="<?php echo $transaction; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_transaction; ?>"><?php echo $nav_text_transaction; ?></a></li>
				  <li><a  data-for="#recurring" href="<?php echo $recurring; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_recurring; ?>"><?php echo $nav_text_recurring; ?></a></li>
				</ul>
			</div>
			<section class="account_content">
				<!--div class="tab_content" id="order_history"></div-->
				<div id="order_history"></div>
				<!--div class="tab_content" id="download"></div-->
				<div id="download"></div>
				<!--div class="tab_content" id="reward"></div-->
				<div id="reward"></div>
					<!--div class="tab_content" id="return"-->
					<div id="return">
					<div class="pull-left">
						<div class="heading">
						<?php echo $heading_title; ?>
						</div>
						<p><?php echo $text_description; ?></p>
					</div>
					<div class="pull-right">
						<a class="themeBtn graybtn" href="<?php echo $add_return; ?>"><?php echo $button_back; ?></a>
					</div>
					<div class="clearfix"></div>
					<div class="gap"></div>
					<div class="col-md-12 column">
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="siteForm form-horizontal">
						<fieldset>
						  <legend><?php echo $text_order; ?></legend>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
							<div class="col-md-9">
							  <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
							  <?php if ($error_firstname) { ?>
							  <div class="text-danger"><?php echo $error_firstname; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
							<div class="col-md-9">
							  <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />
							  <?php if ($error_lastname) { ?>
							  <div class="text-danger"><?php echo $error_lastname; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-email"><?php echo $entry_email; ?></label>
							<div class="col-md-9">
							  <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
							  <?php if ($error_email) { ?>
							  <div class="text-danger"><?php echo $error_email; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
							<div class="col-md-9">
							  <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
							  <?php if ($error_telephone) { ?>
							  <div class="text-danger"><?php echo $error_telephone; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-order-id"><?php echo $entry_order_id; ?></label>
							<div class="col-md-9">
							  <input type="text" name="order_id" value="<?php echo $order_id; ?>" placeholder="<?php echo $entry_order_id; ?>" id="input-order-id" class="form-control" />
							  <?php if ($error_order_id) { ?>
							  <div class="text-danger"><?php echo $error_order_id; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group">
							<label class="col-md-3 control-label" for="input-date-ordered"><?php echo $entry_date_ordered; ?></label>
							<div class="col-md-3">
							  <div class="input-group date cust-cal"><input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" placeholder="<?php echo $entry_date_ordered; ?>" data-date-format="YYYY-MM-DD" id="input-date-ordered" class="form-control" /><span class="input-group-btn">
								<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
								</span>
							</div>
							</div>
						  </div>
						</fieldset>
						<fieldset>
						  <legend><?php echo $text_product; ?></legend>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-product"><?php echo $entry_product; ?></label>
							<div class="col-md-9">
							  <input type="text" name="product" value="<?php echo $product; ?>" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
                              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
							  <?php if ($error_product) { ?>
							  <div class="text-danger"><?php echo $error_product; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label" for="input-model"><?php echo $entry_model; ?></label>
							<div class="col-md-9">
							  <input type="text" name="model" value="<?php echo $model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
							  <?php if ($error_model) { ?>
							  <div class="text-danger"><?php echo $error_model; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group">
							<label class="col-md-3 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
							<div class="col-md-9">
							  <input type="text" name="quantity" value="<?php echo $quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="form-control" />
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $entry_reason; ?></label>
							<div class="col-md-9">

							<ul class="radio-wrap">

							  <?php foreach ($return_reasons as $return_reason) { ?>
							  <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>

							  <li>
								<label class="radio">
								<input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" checked="checked"/>
								<i class="input-helper"></i><?php echo $return_reason['name']; ?></label>
							  </li>


							  <?php } else { ?>
							  <li>
								<label class="radio">
								<input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>"/>
								<i class="input-helper"></i><?php echo $return_reason['name']; ?></label>
							  </li>

							  <?php  } ?>
							  <?php  } ?>
							</ul>
							  <?php if ($error_reason) { ?>
							  <div class="text-danger"><?php echo $error_reason; ?></div>
							  <?php } ?>
							</div>
						  </div>
						  <div class="form-group required">
							<label class="col-md-3 control-label"><?php echo $entry_opened; ?></label>
							<div class="col-md-9">
							  <ul class="radio-wrap">
								<?php if ($opened) { ?>
								<li>
									<label class="radio">
									<input type="radio" name="opened" value="1" checked="checked"/>
									<i class="input-helper"></i><?php echo $text_yes; ?></label>
								</li>
								<?php } else { ?>
								<li>
									<label class="radio">
									<input type="radio" name="opened" value="1"/>
									<i class="input-helper"></i><?php echo $text_yes; ?></label>
								</li>
								<?php } ?>

								<?php if (!$opened) { ?>
								<li>
									<label class="radio">
									<input type="radio" name="opened" value="0" checked="checked"/>
									<i class="input-helper"></i><?php echo $text_no; ?></label>
								</li>
								<?php } else { ?>
								<li>
									<label class="radio">
									<input type="radio" name="opened" value="0"/>
									<i class="input-helper"></i><?php echo $text_no; ?></label>
								</li>
								<?php } ?>
								</ul>
							</div>
						  </div>
						  <div class="form-group">
							<label class="col-md-3 control-label" for="input-comment"><?php echo $entry_fault_detail; ?></label>
							<div class="col-md-9">
							  <textarea name="comment" rows="10" placeholder="<?php echo $entry_fault_detail; ?>" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
							</div>
						  </div>
						  <div class="form-group">
							<div class="col-md-3">&nbsp;</div>
							<div class="col-md-9"><?php echo $captcha; ?></div>
						  </div>
						</fieldset>
						<?php if ($text_agree) { ?>
						<div class="buttons clearfix">
						  <div class="pull-left"><a class="theme-Btn" href="<?php echo $back; ?>" class="btn btn-danger"><?php echo $button_back; ?></a></div>
              <div class="pull-right"><?php //echo $text_agree; ?>
                  <label class="checkbox">
                        <?php if ($agree) { ?>
                        <input type="checkbox" name="agree" value="1" checked="checked" />
                        <?php } else { ?>
                        <input type="checkbox" name="agree" value="1" />
                        <?php } ?>
                        <i class="input-helper"></i>
                          <p><?php echo $text_agree;?></p>
                          <?php if ($error_agree) { ?>
                            <div class="text-danger"><?php echo $error_agree; ?></div>
                          <?php } ?>
                    </label>
							<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
						  </div>
						</div>
						<?php } else { ?>
						<div class="buttons clearfix">
						  <div class="pull-left"><a href="<?php echo $back; ?>" class="themeBtn graybtn"><?php echo $button_back; ?></a></div>
						  <div class="pull-right">
							<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
						  </div>
						</div>
						<?php } ?>
					  </form>

					</div>

					<div class="gap"></div>
				</div>
				<!--div class="tab_content" id="transaction"></div-->
				<div id="transaction"></div>
				<!--div class="tab_content" id="recurring"></div-->
				<div id="recurring"></div>
			</section>
			<div class="gap"></div>
			</div>
          </div>
        </div>
      </div>
    </div>
	<div class="row">
	  <div class="col-md-12 column">
		<?php echo $content_bottom; ?>
	  </div>
	</div>
  </div>
  <!--body end here-->
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script>
<!-- jQueryTab.js -->
<script type="text/javascript">
// initializing jQueryTab plugin
$('.dashboard-tabs').jQueryTab({
    initialTab:1,				// tab to open initially; start count at 1 not 0
	tabInTransition: 'fadeIn',
    tabOutTransition: 'fadeOut',
    cookieName: 'active-tab-1'

});
$('.dashboard-tabs a.accordion_tabs').each(function(index, element) {
	var href = $(element).attr('href');
	href = $('.dashboard-tabs ul.tabs li').find('a[data-for='+href+']').attr('href');
	$(element).attr('href', href);
});
$('.dashboard-tabs a.accordion_tabs').click(function(e){
	changeUrl(this);
});
</script>
<?php echo $footer; ?>
