$(document).ready(function() {
  $(".info li").hide()

  $(".anno .view").toggle(
    function() { $(this).parent().find(".info li").show();$(this).text("[[ close ]]")},
    function() { $(this).parent().find(".info li").hide();$(this).text("[[ open ]]")}
  )
  $(".view-all").toggle(
    function() { $(this).parent().find(".info li").show();$(this).text("[[ close all ]]")},
    function() { $(this).parent().find(".info li").hide();$(this).text("[[ inspect all ]]")}    
  )
  
  $(".delete").click(function(){
    $.ajax({
      type: "POST",
      url: "/delete/" + $(this).data("uid"),
      success: function(data) {
        console.log(data)
      }
    })
  })
})