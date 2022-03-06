$(function() {

    var owner = $('#owner');
    var cardNumber = $('#cardNumber');
    var cardNumberField = $('#card-number-field');
    var CVV = $("#cvv");
    var mastercard = $("#mastercard");
    var confirmButton = $('#button-confirm');
    var visa = $("#visa");
    var amex = $("#amex");

    // Use the payform library to format and validate
    // the payment fields.

    cardNumber.payform('formatCardNumber');
    CVV.payform('formatCardCVC');


    cardNumber.keyup(function() {

        amex.removeClass('transparent');
        visa.removeClass('transparent');
        mastercard.removeClass('transparent');

        if ($.payform.validateCardNumber(cardNumber.val()) == false) {
            cardNumberField.addClass('has-error');
        } else {
            cardNumberField.removeClass('has-error');
            cardNumberField.addClass('has-success');
        }

        if ($.payform.parseCardType(cardNumber.val()) == 'visa') {
            mastercard.addClass('transparent');
            amex.addClass('transparent');
        } else if ($.payform.parseCardType(cardNumber.val()) == 'amex') {
            mastercard.addClass('transparent');
            visa.addClass('transparent');
        } else if ($.payform.parseCardType(cardNumber.val()) == 'mastercard') {
            amex.addClass('transparent');
            visa.addClass('transparent');
        }
    });

    confirmButton.click(function(e) {

        e.preventDefault();

        var isCardValid = $.payform.validateCardNumber(cardNumber.val());
        var isCvvValid = $.payform.validateCardCVC(CVV.val());
        var expireMonthVal = $('#input-cc-expire-month').val();
        var expireYearVal = $('#input-cc-expire-year').val();

        var errorMsg = '';
        if(owner.val().length < 3){
            errorMsg += 'Invalid Card Owner' + '<br>';
        }

        if (!isCardValid) {
            errorMsg += 'Invalid Card Number' + '<br>';
        }

        if (!isCvvValid) {
            errorMsg += 'Invalid CVV/CVV2' + '<br>';
        }

        if (!expireMonthVal || !expireYearVal) {
            errorMsg += 'Card Expiry Date is empty' + '<br>';
        } else {

            var regex = /^\d*[.]?\d*$/;
            if(!regex.test(expireMonthVal) || !regex.test(expireYearVal) ){
                errorMsg += 'Invalid Card Expiry Date' + '<br>';
            }
        }

        if(errorMsg == '') {
            submitCardDetails();
            return true;
        }

        displayCardDetialsError(errorMsg);
        return false;
    });
});

function displayCardDetialsError(error) {

    $('#collapse-checkout-confirm .checkout-content-body').prepend('<div class="alert alert-warning">' + error + '<button type="button" class="close" data-dismiss="alert"></button></div>');

    setTimeout(function(){
        $('.alert, .text-danger').remove();
    }, 6000);
}
