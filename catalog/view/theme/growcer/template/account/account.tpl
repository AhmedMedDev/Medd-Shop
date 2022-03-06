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
	<?php if (isset($success) && $success!='') { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success">
				<i class="fa fa-check-circle"></i> <?php echo $success; ?>
				<button type="button" class="close"></button>
			</div>
			<div class="alert-after"></div>
		</div>
	  </div>
	  <?php } ?>
	  
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
					<a href="javascript:void(0);" class="toggle-account-nav"><?php echo $text_your_details; ?><span class="tantoo"></span></a>
					<ul>
					  <li class="active"><a data-for="#user_details" href="<?php echo $profile_link; ?>" onclick="changeUrl(this)" class="ripple"><?php echo $text_your_details; ?></a></li>
					  <li><a data-for="#change_password" href="<?php echo $password_link; ?>" onclick="changeUrl(this)" class="ripple"><?php echo $text_change_password; ?></a></li>
					</ul>
				</div>
                <section class="account_content">
                  <!--div class="tab_content" id="user_details"-->
                  <div id="user_details">
                    <?php echo $edit; ?>
                  </div>    
				  <!--div class="tab_content" id="change_password"-->
				  <div id="change_password">
                  </div>                 
                </section>
              
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
		initialTab: 1,								// tab to open initially; start count at 1 not 0
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
