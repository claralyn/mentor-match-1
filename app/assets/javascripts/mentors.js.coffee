# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#ranks").sortable
    update: (event, ui) ->
  $("#ranks").disableSelection()

$("#ranks").on "sortupdate", ( event, ui) ->
  ranking = $("ul#ranks li").get()
  new_ranking = {}
  ranking.forEach ( el, i ) ->
    new_ranking[el.id] = i + 1
  $.ajax {
      type: "PUT"
      url: "/rank"
      data: { ranking : JSON.stringify( new_ranking ) },
      dataType: 'json'
      complete: ( jqxhr, status ) ->
        console.log jqxhr.status
  }
