<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="operation_xml" value="<?php echo $xml; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="buttons">
  <div class="gap"></div>
    <div class="pull-right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="btn btn-primary themeBtn" />
    </div>
  </div>
</form>
