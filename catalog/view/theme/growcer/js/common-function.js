(function() {

  "use strict";

  var toggles = document.querySelectorAll(".c-hamburger");

  for (var i = toggles.length - 1; i >= 0; i--) {
    var toggle = toggles[i];
    toggleHandler(toggle);
  };
  
  var toggles = document.querySelectorAll(".c-hamburger2");

  for (var i = toggles.length - 1; i >= 0; i--) {
    var toggle = toggles[i];
    toggleHandler(toggle);
  };

  function toggleHandler(toggle) {
    toggle.addEventListener( "click", function(e) {
      e.preventDefault();
      (this.classList.contains("is-active") === true) ? this.classList.remove("is-active") : this.classList.add("is-active");
    });
  }
  
})();

$(document).ready(function () {
	var _panelWrap = $( '.left-panel .nav-list' );
	if( _panelWrap.length > 0 && _panelWrap.find( 'li' ).length > 0 && _panelWrap.find( 'li' ).hasClass( 'active' ) ) { 
		var _menuText = _panelWrap.find( 'li.active' ).eq(0).text().trim();
		if( _menuText != '' ) { 
			$( '.detail .toggle.c-hamburger2' ).html( _menuText + '<span class="icn-drop"></span>' );
		}
	}
	
	var toggleActive = function( _this, _window, _nav ){
							if( _window.width() <= 767 ) { 
								_this.toggleClass( 'active' );
								if( _this.hasClass( 'active' ) ){
									_nav.addClass( 'active' );
								} else {
									_nav.removeClass( 'active' );
								}
							}
							return false;
						};
	var _window = $( window );
	$(document).on('click','.c-hamburger2',function(){
		var _this = $(this);
		var _nav  = $('.nav-list ul');
		return toggleActive( _this, _window, _nav );
	});
	
	$(document).on('click','.toggle-account-nav',function(){
		var _this = $(this);
		var _nav  = _this.next();
		return toggleActive( _this, _window, _nav );
	});
	$('.nav-list').on('click','.c-hamburger',function(){
		$('.nav-list ul').toggle();
	});

	var ink, d, x, y;
	$(".themeBtn, .ripple, .action").click(function(e){
		if($(this).find(".ink").length === 0){
			$(this).prepend("<span class='ink'></span>");
		}
			 
		ink = $(this).find(".ink");
		ink.removeClass("animate");
		 
		if(!ink.height() && !ink.width()){
			d = Math.max($(this).outerWidth(), $(this).outerHeight());
			ink.css({height: d, width: d});
		}
		 
		x = e.pageX - $(this).offset().left - ink.width()/2;
		y = e.pageY - $(this).offset().top - ink.height()/2;
		 
		ink.css({top: y+'px', left: x+'px'}).addClass("animate");
	});  

	function validateEmail($email) {
		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		return emailReg.test( $email );
	} 
	
	$('#subscribe').click(function(){
		$('#news-subscribe-form').submit();
	});
	
		 $('#news-subscribe-form').submit(function(){
			var email = $('#input-newsletter').val();
					
			if(email == ''){
				var error = 'Please enter email address!';
			}
			
			if( !validateEmail(email)) {
				var error = 'Please enter valid email address!';
			}
			
			if(error != null){
				$('#error-msg').html('');
				$('#error-msg').append('<b style=\"color:red\">' + error + '</b>');
				
				setTimeout(function(){
					$('#error-msg').html('');
				}, 5000);
				return false;
			} else {
			  
				var dataString = 'email='+ email;
				$.ajax({
					url: 'index.php?route=common/footer/addToNewsletter',
					type: 'post',
					data: dataString,
					success: function(html) {
						$('#error-msg').html('');
						$('#error-msg').append('<b style=\"color:green\">' + html + '</b>');
						
						setTimeout(function(){
							$('#error-msg').html('');
						}, 5000);						
						
					}
					
				});
				return false;
			}
			
		}); 
	var show_arabic = false;
	if( arabic_defined=='ar' ){
		show_arabic =  true;
	}
	$('.featured-slider').slick({
	  dots: false,
	  infinite: false,
	  rtl: show_arabic,
	  arrows: true,
	  speed: 300,
	  slidesToShow:5,
	  slidesToScroll:1,
	  responsive: [
		{
		  breakpoint: 1050,
		  settings: {
			slidesToShow:4,
		  }
		},
		  {
		  breakpoint: 1024,
		  settings: {
			slidesToShow: 4,
		  }
		},
		  	{
		  breakpoint:990,
		  settings: {
			slidesToShow: 3,
		  }
		},
		  {
		  breakpoint:800,
		  settings: {
			slidesToShow: 3,
		  }
		},
		  	{
		  breakpoint: 680,
		  settings: {
			slidesToShow: 2,
		  }
		},
	
		{
		  breakpoint: 480,
		  settings: {
			slidesToShow: 1,
		  }
		}
	  ]
	});	
	
	$('.logo_listing').slick({
	  dots: false,
	  rtl: show_arabic,
	  infinite: false,
	  arrows: false,
	  autoplay: true,
	  infinite: true,
	  autoplaySpeed: 2000,
	  speed: 300,
	  slidesToShow:7,
	  slidesToScroll:1,
	  responsive: [
		{
		  breakpoint: 1200,
		  settings: {
			slidesToShow: 6,
		  }
		},
		  {
		  breakpoint: 1024,
		  settings: {
			slidesToShow: 5,
		  }
		},
		  	{
		  breakpoint:990,
		  settings: {
			slidesToShow: 5,
		  }
		},
		  {
		  breakpoint:800,
		  settings: {
			slidesToShow: 4,
		  }
		},
		  	{
		  breakpoint: 680,
		  settings: {
			slidesToShow: 3,
		  }
		},
	
		{
		  breakpoint: 480,
		  settings: {
			slidesToShow: 1,
		  }
		}
	  ]
	});	
	
	
	/* show js button */
	$('.btn-showjs').click(function() {
		var target = $(this).data('target');

		$('div[data-target="'+target+'"]').slideToggle(200);
		return false;
	});
	



	$('.module-sidebar>.panel-heading').click(function(){
		 if($(this).hasClass('expand')){
			$(this).removeClass("expand");
			$(this).addClass("collapse");
		 }else{
			if($(this).hasClass("collapse")){
				$(this).removeClass("collapse");
			}
			$(this).addClass("expand"); 
		 }
		 
		 $(this).parent('.module-sidebar').find('.panel-list').slideToggle("slow", "linear");
		 
	});
	
	$('.footer-link .block-title').click(function () {
		$(this).toggleClass("active");
		if ($(window).width() < 990){	$(this).siblings('.footer-menu,.contact_info').slideToggle();	}
	});

   
	jQuery('.srchTogl').click(function(){	jQuery('.hdr-srch').toggleClass('active');	});
	jQuery('.togal_btn').click(function(){	jQuery('.top-rght-link').toggleClass('active');	});	
	jQuery('#navToggle').click(function(){	jQuery('.menuBar').toggleClass('active');});	
	
});	

function changeUrl(e){
	var url = $(e).attr('href');
	window.location = url;
}

$(document).ready(function(){
	$('.hdr_checkout').on('click', '.cart-button',function() {		$('.dropdown-box').toggle();	});
        
        var products_count = products_price = products_items_txt = '';
        
        function runAjax() {
           $('#dropdown-box').load('index.php?route=common/cart/info #load_dropdown_data ',updateCartData);
			console.clear();		
        }
        
        if(current_user_logged){
            setInterval(runAjax, 5000);
        }
	
        
        
});

function updateCartData(){
    products_count = $('#dropdown-box .total_products_count').html();
    products_price = $('#dropdown-box .total_products_price').html();
    products_items_txt = $('#dropdown-box .total_products_items_txt').html();    
    $('#cart-total').html(products_count+' '+products_items_txt+' - '+products_price);    
}


function getProductQuote(product_id, type){
	var count = document.getElementsByClassName('productQuoteRequest').length;
	if(count){
		$('#productQuoteRequest').addClass('md-show');
	}
	else{
		var button_text = $('#request_quote').text();
		if(product_id==''){
			product_id = 0;
		}
		$.ajax({
			url: 'index.php?route=product/product_quote&product_id='+product_id+'&type='+type,
			type: 'get',
			beforeSend: function() {
				$('#request_quote').text(button_text+'...');
			},
			complete: function(){
				$('#request_quote').text(button_text);
			},
			success: function(res) {
				$('#request_quote').text(button_text);
				$('body').append(res);
			}
		});
		return ;
	}
}
var lock = false;
function submitProductQuote(e){
	e.preventDefault();
	if(lock){
		return false;
	}
	var button_text = $('#submitQBtn').val();
	$.ajax({
		url: 'index.php?route=product/product_quote/add',
		type: 'post',
		dataType: 'json',
		data: $('#productQuoteRequestFrm').serialize(),
		beforeSend: function() {
			lock = true;
			$('#submitQBtn').val(button_text+'...');
		},
		complete: function() {
			lock = false;
			$('#submitQBtn').val(button_text);
		},
		success: function(json) {
			$('#submitQBtn').val(button_text);
			lock = false;
			if (json['error']) {
				$('span.text-danger').html('');
				var jsonerrobject = jQuery.parseJSON(json['error']);
				var keys = [], vals = []
				for (var key in jsonerrobject) {
					/* keys.push(key)
					vals.push(jsonerrobject[key]) */
					$('.error_'+key).html(jsonerrobject[key])
					
				}
			}
			if (json['success']) {
				$('span.text-danger').html('');
				$('form#productQuoteRequestFrm')[0].reset();
				$('#result').html(json['success']);
				setTimeout(function () {
					location = json['referrer'];
				}, 2000);
			}
		}
	});
	return false;
}
$(document).mouseup(function(e) 
{
    //var container = $("#dropdown-box");  
    var container = $(".hdr_checkout");  
    // if the target of the click isn't the container nor a descendant of the container
    if (!container.is(e.target) && container.has(e.target).length === 0) 
    {
        $('#cart').removeClass('open');
        $('.cart-button').prop('aria-expanded','false');
        $('#dropdown-box').css('display','none');
        //container.hide();
    }
});