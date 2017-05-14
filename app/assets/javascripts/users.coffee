# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", () ->

  $("#gees-container-button").on "click", () ->
    $(this).addClass("active")
    $("#bets-container-button").removeClass("active")
    $("#bets-container").hide()
    $("#gees-container").show()

  $("#bets-container-button").on "click", () ->
    $(this).addClass("active")
    $("#gees-container-button").removeClass("active")
    $("#gees-container").hide()
    $("#bets-container").show()
