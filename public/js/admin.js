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

  $(".delete-all").click(function(){
    if (confirm("No going back. This will delete all annotations.")) {
      var url = $(this).attr("action")
      $.ajax({type:"POST", url: url,
        success: function() {
          window.location.reload()
        }
      })
    }
  })

  $(".delete").click(function(){
    if (confirm("Delete?")) {
      var url = $(this).attr("action")
      $.ajax({type: "POST", url: url,
        success: function() {
          window.location.reload()
        }
      })
    }
  })
})

