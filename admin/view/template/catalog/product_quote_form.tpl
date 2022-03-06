<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-download" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-product-quote" class="form-horizontal">
		<input type="hidden" value="3" name="type"/>
		<?php if(!empty($product_quote_info) && isset($product_quote_info['added'])){ ?>
		  <div class="form-group">
		    <div class="col-sm-2"></div>
			<div class="col-sm-4">
				<div class="text-left">
				<?php echo $column_added; ?>: <?php echo isset($product_quote_info['added']) ? $product_quote_info['added'] : ''; ?><br/>
				<?php echo $column_modified; ?>: <?php echo isset($product_quote_info['modified']) ? $product_quote_info['modified'] : ''; ?>
				</div>
			</div>
			
			<div class="col-sm-6">
				<div class="text-left">
				<?php 
				$referrer = isset($product_quote_info['referrer']) ? $product_quote_info['referrer'] : ''; 
				$referrer = json_decode($referrer, true);
				$html_content = '';
				foreach($referrer AS $rfrkey=>$rfrval){
						if($rfrkey=='ip'){
							$html_content .= strtoupper(str_replace("_", " ", $rfrkey)).': '.'<a href="http://www.ip2location.com/'.$rfrval.'" target="_blank">'.$rfrval.'</a><br/>';
							continue;
						}
						$html_content .=ucwords(str_replace("_", " ", $rfrkey)).': '.$rfrval.'<br/>';
				}
				echo $html_content;
				?>
				</div>
			</div>
		  </div>
		<?php } ?>
          <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
                <input required type="text" name="name" value="<?php echo isset($product_quote_info['name']) ? $product_quote_info['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
              <?php if (isset($error_name) && !empty($error_name)) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
		  <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
                <input required type="text" name="email" value="<?php echo isset($product_quote_info['email']) ? $product_quote_info['email'] : ''; ?>" placeholder="<?php echo $entry_email; ?>" class="form-control" />
              <?php if (isset($error_email) && !empty($error_email)) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
          </div>
		  <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_phone; ?></label>
            <div class="col-sm-10">
                <input required type="text" name="phone" value="<?php echo isset($product_quote_info['phone']) ? $product_quote_info['phone'] : ''; ?>" placeholder="xxxx-xxx-xxxx" title="xxxx-xxx-xxxx" class="form-control" />
              <?php if (isset($error_phone) && !empty($error_phone)) { ?>
              <div class="text-danger"><?php echo $error_phone; ?></div>
              <?php } ?>
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_comments; ?></label>
            <div class="col-sm-10">
                <textarea required style="height: 200px;" name="comments" placeholder="<?php echo $entry_comments; ?>" class="form-control"><?php echo isset($product_quote_info['comments']) ? $product_quote_info['comments'] : ''; ?></textarea>

              <?php if (isset($error_comments) && !empty($error_comments)) { ?>
              <div class="text-danger"><?php echo $error_comments; ?></div>
              <?php } ?>
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_remarks; ?></label>
            <div class="col-sm-10">
               <textarea required style="height: 200px;" name="remarks" placeholder="<?php echo $entry_remarks; ?>" class="form-control"><?php echo isset($product_quote_info['remarks']) ? $product_quote_info['remarks'] : ''; ?></textarea>
              <?php if (isset($error_remarks) && !empty($error_remarks)) { ?>
              <div class="text-danger"><?php echo $error_remarks; ?></div>
              <?php } ?>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div> 
<?php echo $footer; ?>