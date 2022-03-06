<?php echo $header; ?>
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
	<link type="text/css" href="catalog/view/theme/default/stylesheet/chat.css" rel="stylesheet" media="screen" />
	  <?php if ($success) { ?>
	  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?><button type="button" class="close"></button></div><div class="alert-after"></div>
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
			
				<form action="" method="post" enctype="multipart/form-data" class="siteForm form-horizontal">
					<fieldset id="msg">
						<div class="form-group required">
							<div class="col-sm-12">
								<textarea  name="message" placeholder="<?php echo $entry_message; ?>" id="input-message" class="form-control jqte-test"></textarea>
							</div>
						</div>
						<div class="buttons">
							<div class="pull-left">
								<a href="<?php echo $delete; ?>" id="button-delete" data-toggle="tooltip" title="<?php echo $button_clear; ?>" class="btn btn-warning earse_anchor"><i class="fa fa-eraser custom_erase"></i><span class="erase_msgs"> <?php echo $button_clear; ?></span></a>
								
							</div>
							<div class="pull-right">
								<button type="button" id="button-send" class="btn btn-primary" ><?php echo $button_send; ?></button>
							</div>
						</div>
					</fieldset>
					<div id="view-message"></div>
				</form>			
			
			</div>
			</div>
			
		 </div>
		</div> 
	</div>
</div>
<script type="text/javascript"><!--
$('#button-send').on('click', function() {
	var editor_messgae = $('.jqte-test').val().trim();
	$.ajax({
		url: 'index.php?route=account/message/sendMessage',
		dataType: 'json',
		method: 'post',
		data: 'message='+ editor_messgae,
		beforeSend: function() {
			$('#button-send').val('loading');
		},
		complete: function() {
			$('#button-send').val('reset');
		},
		success: function(json) {
			$('.alert').remove();
			
			
			if(json['error_warning']) {
					$('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+ json['error_warning'] +'<button type="button" class="close"></button></div><div class="alert-after"></div>');
			}
			
			if(json['success']) {
					$('.breadcrumb').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+ json['success'] +'<button type="button" class="close"></button></div><div class="alert-after"></div>');
					$('.jqte-test').val('');
					viewMessage();
			}
			$('.jqte-test').focus();
			if(json['redirect']) {
					location = json['redirect'];
			}
		}
	});
});
//--></script> 

<script type="text/javascript"><!--
$(document).ready(function() {
	$('.jqte-test').focus();
	viewMessage();
	setInterval(function(){ 
		viewMessage();
	}, 5000);	
});
function viewMessage(){
$('#view-message').load('index.php?route=account/message/viewMessage');
}
//--></script>
<link type="text/css" rel="stylesheet" href="catalog/view/javascript/jquery/editor/jquery-te-1.4.0.css">


<script type="text/javascript"><!--
$('a[id^=\'button-delete\']').on('click', function(e) {
	e.preventDefault();
	
	if (confirm('<?php echo $text_confirm; ?>')) {
		location = $(this).attr('href');
	}
});
//--></script> 
<style>
.jqte{
	height:200px;
}
.jqte_editor, .jqte_source{
	min-height:100%;
}
.jqte-test{
	height:200px !important;
}
</style>
<?php echo $footer; ?>