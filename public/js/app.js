// our app js code here, go for it.
$(document).ready(function() {
  // initial accordion slide-down
  accordion_used = false
  $('#dummy').fadeOut(500, function(){
    if (accordion_used == false) {
      $('#create-slide .opener').addClass("active")
      $('#create-slide .slide').slideDown(400)
      $('#work-slide .opener').removeClass("active")
      $('#work-slide .slide').slideUp(400)
    }
  });

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
