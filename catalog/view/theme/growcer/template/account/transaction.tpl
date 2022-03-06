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
						<a href="javascript:void(0);" class="toggle-account-nav"><?php echo $nav_text_transaction; ?><span class="tantoo"></span></a>
						<ul>
						  <li><a data-for="#order_history" href="<?php echo $order; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_order; ?>"><?php echo $nav_text_order; ?></a></li>
						  <li><a data-for="#download" href="<?php echo $download; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_download; ?>"><?php echo $nav_text_download; ?></a></li>
						  <?php if($reward){ ?>
						  <li><a data-for="#reward" href="<?php echo $reward; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_reward; ?>"><?php echo $nav_text_reward; ?></a></li>
						  <?php } ?>
						  <li><a data-for="#return" href="<?php echo $return; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_return; ?>"><?php echo $nav_text_return; ?></a></li>
						  <li class="active"><a  data-for="#transaction" href="<?php echo $transaction; ?>" onclick="changeUrl(this)" class="ripple" title="<?php echo $help_text_transaction; ?>"><?php echo $nav_text_transaction; ?></a></li>
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
						<!--div class="tab_content" id="return"></div-->
						<div id="return"></div>
						<!--div class="tab_content" id="transaction"-->
						<div id="transaction">
							<div class="heading"><?php echo $heading_title; ?></div>
							<div class="tbl-scroll">
							<table class="tbl-normal tbl-responsive">
							  <thead>
								<tr>
								  <th><?php echo $column_date_added; ?></th>
								  <th><?php echo $column_description; ?></th>
								  <th><?php echo $column_amount; ?></th>
								</tr>
							  </thead>
							  <tbody>
								<?php if ($transactions) { ?>
								<?php foreach ($transactions as $transaction) { ?>
								 <tr>
								  <td><?php echo $transaction['date_added']; ?></td>
								  <td><?php echo $transaction['description']; ?></td>
								  <td><?php echo $transaction['amount']; ?></td>
								</tr>
								<?php } ?>
								<?php } else { ?>
									<tr>
									  <td colspan="3"><?php echo $text_empty; ?></td>
									</tr>
									<?php } ?>
							  </tbody>
							</table>
							</div>
							<div><?php echo $pagination; ?></div>
							
						</div>
						<!--div class="tab_content" id="recurring"></div-->
						<div id="recurring"></div>
					</section>

					<div class="gap"></div>
					<div class="row">
						<div class="col-md-12"></div>
					</div>
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
});
</script>
<?php echo $footer; ?>
