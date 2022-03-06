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
	<?php if (isset($success)) { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close"></button></div>
			<div class="alert-after"></div>
		</div>
	  </div>
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
					<a href="javascript:void(0);" class="toggle-account-nav"><?php echo $heading_title; ?><span class="tantoo"></span></a>
					<ul>
						<li><a data-for="#user_details" onclick="changeUrl(this)" href="<?php echo $profile_link;?>" class="ripple"><?php echo $text_your_details; ?></a></li>
						<li class="active"><a data-for="#change_password" onclick="changeUrl(this)" href="<?php echo $password_link; ?>" class="ripple"><?php echo $heading_title; ?></a></li>
					</ul>
				</div>
                <section class="account_content">
                  <!--div class="tab_content" id="user_details"></div-->                   
                  <div id="user_details"></div>                   
				  <!--div class="tab_content" id="change_password"-->
				  <div id="change_password">
                    <div class="heading"><?php echo $text_password; ?></div>
					<form class="form-horizontal siteForm" enctype="multipart/form-data" method="post" action="<?php echo $action; ?>">
					  <fieldset>
						<div class="form-group required">
						  <label for="input-password" class="col-md-3 control-label"><?php echo $entry_password; ?></label>
						  <div class="col-md-9">
								<input required type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
								<?php if ($error_password) { ?>
								<div class="text-danger"><?php echo $error_password; ?></div>
								<?php } ?>
						  </div>
						</div>
						<div class="form-group required">
						  <label for="input-confirm" class="col-md-3 control-label"><?php echo $entry_confirm; ?></label>
						  <div class="col-md-9">
								<input required type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" />
								<?php if ($error_confirm) { ?>
								<div class="text-danger"><?php echo $error_confirm; ?></div>
								<?php } ?>
						  </div>
						</div>
					  </fieldset>
						<div class="buttons clearfix">
						  <div class="pull-right">
							<a href="<?php echo $back; ?>" class="themeBtn graybtn"><?php echo $button_back; ?></a>
							<input type="submit" value="<?php echo $button_submit; ?>" class="btn btn-primary" />
						  </div>
						</div>
					</form>
                  </div>
                </section>

              <div class="gap"></div>
              <div class="row">
                <div class="col-md-12"></div>
              </div>
              <div class="gap"></div>
            </div>
            <div class="gap"></div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
		  &nbsp;
		  <?php echo $content_bottom; ?>
		  </div>
        </div>
      </div>
    </div>
  </div>
  <!--body end here--> 
<script type="text/javascript">
// initializing jQueryTab plugin 
$(document).ready(function () {
	jQuery.jQueryTab({
		useCookie: false,							// remember last active tab using cookie
		initialTab: 2,								// tab to open initially; start count at 1 not 0
		collapsible: false
	});
	$('.dashboard-tabs a.accordion_tabs').each(function(index, element) {
		var href = $(element).attr('href');
		href = $('.dashboard-tabs ul.tabs li').find('a[data-for='+href+']').attr('href');
		$(element).attr('href', href);
	});
	$('.dashboard-tabs a.accordion_tabs').click(function(){
		changeUrl(this);
	});
});
</script>
<?php echo $footer; ?>
