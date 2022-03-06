<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="catalog/view/theme/growcer/css/credit_cards.css">

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="catalog/view/theme/growcer/js/jquery.payform.min.js" charset="utf-8"></script>
<script src="catalog/view/theme/growcer/js/credit_cards.js"></script>


<div class="creditCardForm" id="creditCardForm">
    <div class="heading">
        <h1><?php echo $text_credit_card; ?></h1>
    </div>
    <div class="payment">
        <form id="payment-pay">
            <div class="form-group owner">
                <label for="owner"><?php echo $entry_cc_owner; ?></label>
                <input type="text" name="cc_owner" class="form-control" id="owner" autocomplete="off" placeholder="<?php echo $entry_cc_owner; ?>">
            </div>
            <div class="form-group CVV">
                <label for="cvv"><?php echo $entry_cc_cvv2; ?></label>
                <input type="text" name="cc_cvv2" class="form-control" id="cvv" autocomplete="off" placeholder="<?php echo $entry_cc_cvv2; ?>">
            </div>
            <div class="form-group" id="card-number-field">
                <label for="cardNumber"><?php echo $entry_cc_number; ?></label>
                <input type="text" name="cc_number" class="form-control" id="cardNumber" placeholder="XXXXXX********XXXX" autocomplete="off">
            </div>
            <div class="form-group" id="expiration-date">
                <label><?php echo $entry_cc_expire_date; ?></label>
                <div class="col-sm-3 datemonth">
                    <select name="cc_expire_date_month" id="input-cc-expire-month" class="form-control">
                        <?php foreach ($months as $month) { ?>
                        <option value="<?php echo $month['value']; ?>"><?php echo $month['text']; ?></option>
                        <?php } ?>
                    </select>
                </div>
                <div class="col-sm-3 dateyear">
                    <select name="cc_expire_date_year" id="input-cc-expire-year" class="form-control">
                        <?php foreach ($year_expire as $year) { ?>
                        <option value="<?php echo $year['value']; ?>"><?php echo $year['text']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>
            <div class="form-group" id="credit_cards">
                <img src="catalog/view/theme/growcer/images/visa.jpg" id="visa">
                <img src="catalog/view/theme/growcer/images/mastercard.jpg" id="mastercard">
                <img src="catalog/view/theme/growcer/images/amex.jpg" id="amex">
            </div>
            <div class="form-group" id="pay-now">
                <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" name="button_confirm" class="btn btn-primary themeBtn" />
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var elmnt = document.getElementById("creditCardForm");
    elmnt.scrollIntoView();
</script>
<script type="text/javascript">
    <!--
    function submitCardDetails() {

        $.ajax({
            url: 'index.php?route=payment/authorizenet_aim/send',
            type: 'post',
            data: $('#payment :input'),
            dataType: 'json',
            cache: false,
            beforeSend: function() {
                $('#button-confirm').val('<?php echo $text_loading; ?>');
            },
            complete: function() {
                $('#button-confirm').val('<?php echo $button_confirm; ?>');
            },
            success: function(json) {
                if (json['error']) {
                    alert(json['error']);
                }

                if (json['redirect']) {
                    location = json['redirect'];
                }
            }
        });
    }
    //-->
</script>