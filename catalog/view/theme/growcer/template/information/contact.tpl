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
        <li> <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> </li>
        <?php }else{ ?>
        <li> <?php echo $breadcrumb['text']; ?> </li>
        <?php }
					$iteration++;
				} 
			?>
      </ul>
    </div>
  </div>
  <div class="page-head clearfix">
    <div class="fix-container">
      <div class="row">
        <div class="col-md-12">
          <div class="cms">
            <h2><?php echo $heading_title; ?></h2>
            <h3>
              <?php if ($geocode) { ?>
              <a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=<?php echo $geocode_hl; ?>&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $text_location; ?></a>
              <?php }else{ ?>
              <?php echo $text_location; ?>
              <?php } ?>
            </h3>
            <div class="location">
              <div class="map">
                <?php 
				echo (isset($google_map)) ? html_entity_decode($google_map, ENT_QUOTES, 'UTF-8') : '';
				?>
              </div>
            </div>
            <div class="gap"></div>
          </div>
        </div>
      </div>
      <div class="row">
        <?php if(isset($address)){ ?>
        <div class="col-md-3">
          <div class="contact-cell">
            <div class="icn"><img src="<?php echo DIR_TEMPLATE_IMAGES;?>images/location.png"  alt=""/></div>
            <p><?php echo $address; ?></p>
          </div>
        </div>
        <?php } ?>
        <?php if(isset($contact_email) && $contact_email!=''){ ?>
        <div class="col-md-3">
          <div class="contact-cell">
            <div class="icn"><img src="<?php echo DIR_TEMPLATE_IMAGES;?>images/mail.png" alt=""/></div>
            <p><?php echo html_entity_decode($contact_email, ENT_QUOTES, 'UTF-8'); ?></p>
          </div>
        </div>
        <?php } ?>
        <?php if(isset($fax) || isset($telephone)){ ?>
        <div class="col-md-3">
          <div class="contact-cell">
            <div class="icn"><img src="<?php echo DIR_TEMPLATE_IMAGES;?>images/phone.png" width="20" height="30" alt=""/></div>
            <p>
              <?php if ($telephone) { ?>
              <strong><?php echo $text_telephone; ?></strong>: <?php echo $telephone; ?><br />
              <?php } ?>
              <?php if ($fax) { ?>
              <strong><?php echo $text_fax; ?></strong>: <?php echo $fax; ?>
              <?php } ?>
            </p>
          </div>
        </div>
        <?php } ?>
        <?php if(isset($social_code)){ ?>
        <div class="col-md-3">
          <div class="contact-cell">
            <div class="icn"><img src="<?php echo DIR_TEMPLATE_IMAGES;?>images/social.png" alt=""/></div>
            <?php echo html_entity_decode($social_code, ENT_QUOTES, 'UTF-8'); ?> </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="col-md-12">
          <h2 class="heading"><?php echo $text_contact; ?></h2>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="">
            <div class="siteForm contact">
              <div class="row">
                <div class="col-md-6 column">
                  <input type="text" name="fname" value="<?php echo $fname; ?>" id="input-fname" class="form-control" placeholder="<?php echo $entry_fname; ?>*"/>
                  <?php if ($error_fname) { ?>
                  <div class="text-danger"><?php echo $error_fname; ?></div>
                  <?php } ?>
                </div>
                <div class="col-md-6 column">
                  <input type="text" name="lname" value="<?php echo $lname; ?>" id="input-lname" class="form-control" placeholder="<?php echo $entry_lname; ?>*" />
                  <?php if ($error_lname) { ?>
                  <div class="text-danger"><?php echo $error_lname; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6 column">
                  <input  type="email" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" placeholder="<?php echo $entry_email; ?>*"/>
                  <?php if ($error_email) { ?>
                  <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
                <div class="col-md-6 column">
                  <input type="text" name="phone" value="<?php echo $phone; ?>" id="input-phone" class="form-control" placeholder="<?php echo $entry_phone; ?>"/>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12 column">
                  <textarea  name="enquiry" rows="20" id="input-enquiry" class="form-control height120" placeholder="<?php echo $entry_enquiry; ?>*"><?php echo $enquiry; ?></textarea>
                  <?php if ($error_enquiry) { ?>
                  <div class="text-danger"><?php echo $error_enquiry; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6 column">
                  <?php if(isset($captcha)){ ?>
                  <div class=""> <?php echo $captcha; ?> </div>
                  <?php } ?>
                </div>
                <div class="col-md-6 column">
                  <input type="submit" value="<?php echo $button_submit; ?>" class="themeBtn">
                </div>
              </div>
              <table class="formTable">
                <tbody>
                  <tr>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td colspan="2"></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<!--body end here--> 
<?php echo $footer; ?>