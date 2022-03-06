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
						<a href="javascript:void(0);" class="toggle-account-nav"><?php echo $nav_text_order; ?><span class="tantoo"></span></a>
						<ul>
						  <li class="active"><a data-for="#order_history" href="<?php echo $order; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_order; ?>"><?php echo $nav_text_order; ?></a></li>
						  <li><a data-for="#download" href="<?php echo $download; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_download; ?>"><?php echo $nav_text_download; ?></a></li>
						  <?php if($reward){ ?>
						  <li><a data-for="#reward" href="<?php echo $reward; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_reward; ?>"><?php echo $nav_text_reward; ?></a></li>
						  <?php } ?>
						  <li><a data-for="#return" href="<?php echo $return; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_return; ?>"><?php echo $nav_text_return; ?></a></li>
						  <li><a  data-for="#transaction" href="<?php echo $transaction; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_transaction; ?>"><?php echo $nav_text_transaction; ?></a></li>
						  <li><a  data-for="#recurring" href="<?php echo $recurring; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_recurring; ?>"><?php echo $nav_text_recurring; ?></a></li>
						</ul>
					</div>
					<section class="account_content">
						 <!--div class="tab_content" id="order_history"-->
						 <div id="order_history">
							<div class="heading"><?php echo $heading_title; ?></div>
						
							<div class="tbl-scroll">
							<table class="tbl-normal tbl-responsive">
							  <thead>
								<tr>
								  <th><?php echo $column_order_id; ?></th>
								  <th><?php echo $column_status; ?></th>
								  <th><?php echo $column_date_added; ?></th>
								  <th><?php echo $column_product; ?></th>
								  <th><?php echo $column_customer; ?></th>
								  <th><?php echo $column_total; ?></th>
								  <th><?php echo $column_action; ?></th>
								</tr>
							  </thead>
							  <tbody>
							  <?php if($orders){ ?>
								<?php foreach ($orders as $order) { ?>
								<tr>
								  <td><span class="cellcaption"><?php echo $column_order_id; ?></span>#<?php echo $order['order_id']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_status; ?></span><span class="dot <?php echo strtolower(str_replace(" ", "_", $order['status'])); ?>"></span><?php echo $order['status']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_date_added; ?></span><?php echo $order['date_added']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_product; ?></span><?php echo $order['products']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_customer; ?></span><?php echo $order['name']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_total; ?></span><?php echo $order['total']; ?></td>
								  <td><span class="cellcaption"><?php echo $column_action; ?></span>					  
								  
								    <div class="btn-action"> 
										<a href="<?php echo $order['href']; ?>" class="action" title="<?php echo $button_view; ?>">
										  <i class="icon">
												<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					 width="932.15px" height="932.15px" viewBox="0 0 932.15 932.15" style="enable-background:new 0 0 932.15 932.15;"
					 xml:space="preserve">
												  <g>
													<path d="M466.075,161.525c-205.6,0-382.8,121.2-464.2,296.1c-2.5,5.3-2.5,11.5,0,16.9c81.4,174.899,258.601,296.1,464.2,296.1
						s382.8-121.2,464.2-296.1c2.5-5.3,2.5-11.5,0-16.9C848.875,282.725,671.675,161.525,466.075,161.525z M466.075,676.226
						c-116.1,0-210.1-94.101-210.1-210.101c0-116.1,94.1-210.1,210.1-210.1c116.1,0,210.1,94.1,210.1,210.1
						S582.075,676.226,466.075,676.226z"/>
													<circle cx="466.075" cy="466.025" r="134.5"/>
												  </g>
												</svg>
											</i> 
										</a> 
									</div>
								  
								  
								  </td>
								</tr>
								<?php } ?>
							  <?php }else{ ?>
							  <tr>
								  <td class="text-center" colspan="7"><?php echo $text_empty; ?></td>
								</tr>
							  <?php } ?>
							  </tbody>
							</table>
							</div>
							<div class="text-right">
							<div class="gap"></div>
							<?php echo $pagination; ?>
							</div>
							
						 </div>
						 <!--div class="tab_content" id="download"></div-->
						 <div id="download"></div>
						 <!--div class="tab_content" id="reward"></div-->
						 <div id="reward"></div>
						 <!--div class="tab_content" id="return"></div-->
						 <div id="return"></div>
						 <!--div class="tab_content" id="transaction"></div-->
						 <div id="transaction"></div>
						 <!--div class="tab_content" id="recurring"></div-->
						 <div id="recurring"></div>
					</section>
					
					<div class="gap"></div>
					</div>
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
	$('html, body').animate({ scrollTop: 0 }, 'slow');
});
</script>
<?php echo $footer; ?>
