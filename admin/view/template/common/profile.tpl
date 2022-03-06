<div id="profile">
  <div>
    <?php if ($image) { ?>
    <img src="<?php echo $image; ?>" alt="<?php echo $firstname; ?> <?php echo $lastname; ?>" title="<?php echo $username; ?>" class="img-circle" />
    <?php } else { ?>
    <!--<img src="view/image/fav-logo.png" alt="admin user" title="admin user" class="img-circle" />-->
    <img src="view/image/profile-placeholder.png" alt="admin user" title="admin user" class="img-circle" />
    <?php } ?>
  </div>
  <div>
    <h4><?php echo $firstname; ?> <?php echo $lastname; ?></h4>
    <small><?php echo $user_group; ?></small>
  </div>
</div>
