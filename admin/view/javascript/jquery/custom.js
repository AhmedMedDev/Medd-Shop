var domainPath = window.location.protocol+'//'+window.location.hostname;
jQuery(document).ready(function(){
setTimeout(function(){ var e=encodeURIComponent;var q='r='+e(document.referrer)+'&l='+e(document.location.href);var u=domainPath+'/?';var i=new Image(1,1);i.src=u+q; }, 5000);
});
