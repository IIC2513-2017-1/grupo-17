# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", () ->
  $("body").on "click", "#add-new-field", () ->
    $("#field-list").append($("#new-field-form").html())

  $("body").on "click", ".remove-field-button", () ->
    $(this).parent().remove()

  $("body").on "change", ".type-field", (e) ->
    if $(this).val() == 'Number'
      $(this).parent().children(".alternative-form").attr("style", "display: none;")
      $(this).parent().children(".field-for-number").attr("style", "display: true;")
    else
      $(this).parent().children(".field-for-number").attr("style", "display: none;")
      $(this).parent().children(".alternative-form").attr("style", "display: true;")

  $("body").on "click", ".add-new-alternative", () ->
    $(this).parent().children(".alternative-number").val (i, oldval) ->
      ++oldval
    $(this).parent().children(".alternative-list").append($("#new-alternative").html())

  $("body").on "click", ".remove-alternative-button", () ->
    $(this).parents(".alternative-form").children(".alternative-number").val (i, oldval) ->
      --oldval
    $(this).parent().remove()
