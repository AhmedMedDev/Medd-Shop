<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-sendNotification" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
<div class="container-fluid">  
  <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
   <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-sendNotification" class="form-horizontal">
		<ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
        </ul>
		<div class="tab-content">
		<div class="tab-pane active in" id="tab-general">
			<ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
					<li>
						<a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
							<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
							<?php echo $language['name']; ?>
						</a>
					</li>
                <?php break;} ?>
              </ul>
			 <div class="tab-content">  
				<?php foreach ($languages as $language) { ?>
				<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
					<div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="notification_description[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($notification_description[$language['language_id']]) ? $notification_description[$language['language_id']]['title'] : ''; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
                      <?php if (isset($error_title[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_title[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>
					  
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>">
							<?php echo $entry_content; ?>
						</label>
						<div class="col-sm-10">
							<textarea name="notification_description[<?php echo $language['language_id']; ?>][content]" rows="10" cols="" placeholder="<?php echo $entry_description; ?>" id="-input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($notification_description[$language['language_id']]) ? $notification_description[$language['language_id']]['content'] : ''; ?></textarea>
						  <?php 
						  if (isset($error_content[$language['language_id']])) { 
							?>
							<div class="text-danger"><?php echo $error_content[$language['language_id']]; ?></div>
							<?php 
						  } 
						  ?>
						</div>
					  </div>					  
                    
                      <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-to"><?php echo $entry_to; ?></label>
                        <div class="col-sm-10">
                          <select name="to" id="input-to" class="form-control">                            
                            <option value="customer_all"><?php echo $text_customer_all; ?></option>                        
                            <option value="customer"><?php echo $text_customer; ?></option>        
                          </select>
                        </div>
                      </div>
          
                   <div class="form-group to" id="to-customer">
                        <label class="col-sm-2 control-label" for="input-customer"><span data-toggle="tooltip" title="<?php echo $help_customer; ?>"><?php echo $entry_customer; ?></span></label>
                        <div class="col-sm-10">
                          <input type="text" name="customers" value="" placeholder="<?php echo $entry_customer; ?>" id="input-customer" class="form-control" />
                          <div class="well well-sm" style="height: 150px; overflow: auto;"></div>
                        </div>
                  </div>
                   <!-- <div class="form-group required">
						<label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_url; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="notification_description[<?php echo $language['language_id']; ?>][launch_url]" value="<?php echo isset($notification_description[$language['language_id']]) ? $notification_description[$language['language_id']]['launch_url'] : ''; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
						  <?php if (isset($error_launch_url[$language['language_id']])) { ?>
						  <div class="text-danger"><?php echo $error_launch_url[$language['language_id']]; ?></div>
						  <?php } ?>
						</div>
					  </div>-->
				  
				</div>
				
                 <?php break;} ?>
                <div class="form-group">
                         <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>">
							<?php echo $notification_icon; ?>
						</label>
                          <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                            <input type="hidden" name="notification_icon_image" value="<?php echo $notification_icon_image; ?>" id="input-image" />
                            <input type="hidden" name="type" value="<?php echo $notification_type;?>" />
                          </div>                        
                </div>
               

			</div>
          </div>
          
        </div>
       
       </div>
      </form>
	  
    </div>
  </div>
</div>
</div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script> 
  <script type="text/javascript"><!--
$('select[name=\'to\']').on('change', function() {
	$('.to').hide();
    
	$('#to-' + this.value.replace('_', '-')).show();
});

$('select[name=\'to\']').trigger('change');
//--></script>
  <script type="text/javascript"><!--
// Customers
$('input[name=\'customers\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			//url: 'index.php?route=customer/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			url: 'index.php?route=customer/customer/app_autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {                    
					return {
						label: item['name'],
						value: item['customer_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'customers\']').val('');

		$('#input-customer' + item['value']).remove();

		$('#input-customer').parent().find('.well').append('<div id="customer' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="customer[]" value="' + item['value'] + '" /></div>');
	}
});

$('#input-customer').parent().find('.well').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
</script>
<?php echo $footer; ?>