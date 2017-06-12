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

  modal = $("#profile-modal")
  modalBody = $('#profile-modal-body')

  $("#open-profile-modal").on "click", () ->
    $.get "/users/#{modalBody.attr('data-userid')}/edit", (data) ->
      modalBody.html(data)
    modal.css('display', 'block')

  $("#close-profile-modal").on "click", () ->
    modal.css('display', 'none')
