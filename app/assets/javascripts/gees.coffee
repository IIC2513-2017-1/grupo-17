# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#add-new-field").on "click", (e) ->
    $("#field_list").append($("#new_field_form").html())

  $("body").on "click", ".remove-field-button", () ->
    $(this).parent().remove()
