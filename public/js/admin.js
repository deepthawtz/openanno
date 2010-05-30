$(document).ready(function() {
  $(".info li").hide()
  
  $("li.anno:odd").css("background-color", "#ddd")
  $("li.anno:even").css("background-color", "#eee")

  $(".anno .view").toggle(
    function() { $(this).parent().find(".info li").show();$(this).text("[[ close ]]")},
    function() { $(this).parent().find(".info li").hide();$(this).text("[[ open ]]")}
  )
  $(".view-all").toggle(
    function() { $(this).parent().find(".info li").show();$(this).text("[[ close all ]]")},
    function() { $(this).parent().find(".info li").hide();$(this).text("[[ inspect all ]]")}    
  )
  
  $(".delete").click(function(){
    var uid = $(this).attr("uid")
    $.ajax({
      type: "POST",
      url: "/delete" + uid,
      data: $(this).attr("uid").serialize(),
      success: function(data) {
        console.log("receiving data: " + data)
      }
    })
  })
})

