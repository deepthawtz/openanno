// our app js code here, go for it.
$(document).ready(function() {

  // accordion mouseover
  $('.opener').mouseover(function(){
    accordion_used = true
    if (!$(this).hasClass("active")) {
      $('.slide').stop(true, true)
      $('.opener').each(function(){
        $(this).removeClass("active")
        $(this).next().slideUp("fast")
      })
      $(this).addClass("active")
      $(this).next().slideDown("fast")
    }
  });
});