window.AdvancedNewsletter = function(params){
    this.init(params);
};

AdvancedNewsletter.prototype.init = function(params){
    var self = this;
    $(document).ready(function(){
        self.container_box      = $(params.container_id);
        self.input_email        = self.container_box.find(params.input_id);
        self.button_subbmit     = self.container_box.find(params.submit_id);

        self.subscribe();
    });
}

AdvancedNewsletter.prototype.subscribe = function(){
    var self = this;
    this.button_subbmit.bind("click", function(){
        var selfClick = $(this);

        if(!self.input_email.val()){
            alert('Please enter your email!');
            return true;
        }

        selfClick.attr('disabled', true);
        $.ajax({
            type:   "POST",
            url:    "index.php?route=module/newsletter/index",
            data:   "email="+self.input_email.val(),
            dataType: 'json',
            success: function(data){
                alert(data.msg);
                selfClick.attr('disabled', false);
            }
        });
    });
}


new AdvancedNewsletter({
    container_id: '#advanced-newsletter-box',
    input_id: 'input[name=email]',
    submit_id: '.enter-subscribe'
});


