$(document).ready(function(){
  $("#rankSubmit").remove();
  $("#ranking_rank").hide();
  $(".rankingNumber").show();
  $("#rank1").on("click", function(){
    $("#ranking_rank").val(1);
    $("#new_ranking").submit();
  })
  $("#rank2").on("click", function(){
    $("#ranking_rank").val(2);
    $("#new_ranking").submit();
  })
  $("#rank3").on("click", function(){
    $("#ranking_rank").val(3);
    $("#new_ranking").submit();
  })
  $("#rank4").on("click", function(){
    $("#ranking_rank").val(4);
    $("#new_ranking").submit();
  })
  $("#rank5").on("click", function(){
    $("#ranking_rank").val(5);
    $("#new_ranking").submit();
  })
})
