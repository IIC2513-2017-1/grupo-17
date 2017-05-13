# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", () ->

  $("a#add-alternative-field").on "click", () ->
    $("div#fields").append($("#alternative-field").last().clone() )
    $("div#fields div.gee-field").attr("class", "gee-field")

  $("a#add-numeric-field").on "click", () ->
    $("div#fields").append($("#numeric-field").last().clone())
    $("div#fields div.gee-field").attr("class", "gee-field")

  $("div#fields").on "click", "a.remove-field" , () ->
    $(this).parent().remove()

  $("div#fields").on "click", "a.add-alternative", () ->
    $(this).parent().children(".alternative-number").val (i, oldval) ->
      ++oldval
    $(this).parent().children(".alternatives").append($(".alternative").last().clone() )

  $("div#fields").on "click", "a.remove-alternative", () ->
    $(this).parents("#alternative-field").children(".alternative-number").val (i, oldval) ->
      --oldval
    $(this).parent().remove()
