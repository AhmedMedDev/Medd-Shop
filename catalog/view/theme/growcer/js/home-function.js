$(document).ready(function () {
	var show_arabic = false;
	if( arabic_defined=='ar' ){
		show_arabic =  true;
	}
	
	$('.home-slide').slick({
	  dots: true,
	  rtl: show_arabic,
	  infinite: true,
	  arrows: false,
	  fade: true,
	  slidesToShow:1,
	  autoplay: true,
	  autoplaySpeed: 5000,
	  slidesToScroll:1,
	  
	});
	$('.vertical-slider').slick({
		infinite: true,
		 dots: false,
		 arrows: true,
		slidesToShow: 4,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 5000,		
		vertical: true,
		verticalScrolling: true,
		
		responsive: [
			{
				breakpoint: 1050,
				settings: {
					slidesToShow: 4,
					slidesToScroll: 1,
					infinite: true,
				}
		},
		
			{
				breakpoint: 800,
				settings: {
					slidesToShow: 4,
					slidesToScroll: 1
				}
		},
		   
			{
				breakpoint:767,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					vertical: false,
					verticalScrolling: false,
				}
			 }
			,
			{
				breakpoint: 600,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					vertical: false,
					verticalScrolling: false,
				}
			}
		  ]

	});
		
	$('.offer-slider').slick({
	  dots: false,
	  rtl: show_arabic,
	  infinite: false,
	  arrows: true,
	  speed: 300,
	  slidesToShow:3,
	  slidesToScroll:1,
	  responsive: [
		
		  {
		  breakpoint: 1024,
		  settings: {
			slidesToShow: 2,
		  }
		},
		  	{
		  breakpoint:990,
		  settings: {
			slidesToShow: 2,
		  }
		},
		  {
		  breakpoint:800,
		  settings: {
			slidesToShow: 2,
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
});