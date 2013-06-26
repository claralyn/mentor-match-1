# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("a.mentors").on "click", ->
    $("a.mentors").removeClass("mentorSelected")
    $("a.mentorSelected").addClass("mentors")
    $(@).removeClass("mentors").addClass("mentorSelected")

  if ("#filter")
    $("#filterShow").on "click", (event)->
      event.preventDefault()
      $("#filterMentorsCompany").slideToggle()

  if ("a.filterMentors")
    $("a.filterMentors").on "click", ->
      $("a.filterMentors").removeClass("filterMentorsSelected")
      $("a.filterMentorsSelected").addClass("filterMentors")
      $(@).removeClass("filterMentors").addClass("filterMentorsSelected")
      $("#filterMentorsCompany").slideUp(200)
