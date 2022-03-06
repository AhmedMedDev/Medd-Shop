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

    <td>

		<table cellspacing="0" border="0" width="100%" style="padding:5px 0  10px 0;">

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

		</table>

	</td>

    <!-- header end here--> 

  </tr>

  

  <!-- nav end here--> 

  

  <!--content start here-->

  <tr>

    <td style="background:#fff;vertical-align:top;  border:solid 1px #ccc;"><table width="100%" cellspacing="20" cellpadding="0" border="0">

        <tr>

          <td><table width="100%" cellpadding="0" border="0" style="padding:0;">

              <tr>

                <td style="vertical-align: bottom; text-align: center;">

				<h2 style="color:#3a3a3a; font-size:36px; font-weight: 300; margin:00px 0 10px 0;"><?php echo isset($text_message_title) ? $text_message_title: ''; ?></h2>

                  <p style="color:#5e5e5e; font-size: 16px; margin: 0px; line-height:25px; padding:0 30px;">

					<?php if(isset($message1)) echo html_entity_decode($message1, ENT_QUOTES, 'UTF-8'); ?><br/>

					<?php if(isset($message2)) echo html_entity_decode($message2, ENT_QUOTES, 'UTF-8'); ?>

				  </p>

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