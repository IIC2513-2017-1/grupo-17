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

  modal = $("#bet-modal")
  modalBody = $('#bet-modal-body')

  $("#open-bet-modal").on "click", () ->
    $.get "/gees/#{modalBody.attr('data-geeid')}/bets/new", (data) ->
      modalBody.html(data)
    modal.css('display', 'block')

  $("#close-bet-modal").on "click", () ->
    modal.css('display', 'none')

  if $('#infinite-scrolling').size() > 0
    setInterval () ->
      more_posts_url = $('.pagination .next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_posts_url
      return
    , 1000
    return
