$(document).ready(function() {
  $(".info li").hide()

  $(".anno .view").toggle(
    function() { $(this).parent().find(".info li").show();$(this).text("[close]")},
    function() { $(this).parent().find(".info li").hide()}
  )
})