<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="Your Page Description" />
<title><?php echo $heading_title; ?></title>
</head>

<body bgcolor="#ececec" style="margin:0 auto; padding:0;">
<table width="600" cellspacing="0" cellpadding="0" border="0"  style="margin:0 auto;font-family:arial;">
  <tr> 
    <!-- header start here-->
    <td><table cellspacing="0" border="0" width="100%" style="padding:5px 0  10px 0;">
        <tr>
          <td align="center">
				<?php 
				if ($logo){ ?>
					<a href="<?php echo $home; ?>"><img style="border: none;" src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>"/></a>
				<?php 
				} else { ?>
					<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
					<?php 
				} 
				?>	
		  </td>
        </tr>
      </table></td>
    <!-- header end here--> 
  </tr>
  
  <tr>
    <td style="background:#fff;vertical-align:top;  border:solid 1px #ccc;"><table width="100%" cellspacing="20" cellpadding="0" border="0">
        <tr>
          <td><table width="100%" cellpadding="0" border="0" style="padding:0;">
              <tr>
                <td style="vertical-align: bottom;">
				<?php echo isset($text_message_title) ? '<h2 style="color:#3a3a3a; font-size:24px; font-weight:bold; margin:00px 0 10px 0;">'.$text_message_title.'</h2>' : ''; ?>
                <?php if(isset($message) && is_array($message)){ ?>  
				  <table style="border-collapse:collapse;width:100%;border-top:1px solid #ddd;border-left:1px solid #ddd;margin-bottom:20px">
                    <thead>
                      <tr>
                        <td colspan="2" style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;background-color:#ddd;font-weight:bold;text-align:left;padding:7px;color:#222222"><?php echo isset($text_details) ? $text_details : ''; ?></td>
                      </tr>
                    </thead>
                    <tbody>
					<?php foreach($message AS $mkey => $msg):?>
					<?php $mkey = explode("_", $mkey);?>
					<?php $mkey = ucwords(join(" ", $mkey));?>
					<?php if(strlen($msg)>60){ ?>
						<tr>
							<td colspan="2" style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5; font-weight:bold;">
							<?php echo html_entity_decode($mkey, ENT_QUOTES, 'UTF-8'); ?>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;">
							<?php echo nl2br(html_entity_decode($msg, ENT_QUOTES, 'UTF-8')); ?>
							</td>
						</tr>
					<?php }else{ ?>
					 <tr>
                        <td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5; font-weight:bold;" width="30%">
						<?php echo html_entity_decode($mkey, ENT_QUOTES, 'UTF-8'); ?>:
						</td>
                        <td style="font-size:12px;border-right:1px solid #ddd;border-bottom:1px solid #ddd;text-align:left;padding:7px; line-height:1.5;">
						<?php echo html_entity_decode($msg, ENT_QUOTES, 'UTF-8'); ?>
						</td>
                     </tr>
					<?php } ?>
					<?php endforeach; ?>
                    </tbody>
                  </table>
				  <?php }else{ ?>
				   <p style="margin-top:0px;margin-bottom:20px; font-size:12px;"><?php echo nl2br(html_entity_decode($message, ENT_QUOTES, 'UTF-8')); ?></p>
				  <?php } ?>
				  </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <!--content start here-->
   
  
  <?php if(isset($text_bottom_top)){ ?>
  <tr>
	<td><p style="font-size:14px; color:#5e5e5e; margin:0px; text-align:center; padding:10px 10px 0 10px; line-height:22px;"><?php echo html_entity_decode($text_bottom_top, ENT_QUOTES, 'UTF-8'); ?></p></td>
  </tr>
  <?php } ?>
  
  <?php if(isset($text_bottom)) { ?>
  <!-- footer start here--->
  <tr>
    <td style="padding:25px 0 0 0;"><p style="font-size:13px; text-align:center; color:#393939; font-weight:600;margin:0px; background:#fff; padding:20px 10px"><?php echo html_entity_decode($text_bottom, ENT_QUOTES, 'UTF-8'); ?></p></td>
  </tr>
  <!-- footer start here--->
  <?php } ?>
</table>
</body>
</html>