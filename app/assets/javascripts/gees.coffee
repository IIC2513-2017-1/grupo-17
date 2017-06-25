# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", () ->

  $("a#expand-matches-button").on "click", () ->
    $(this).after('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
    $(this).attr('style', 'display: none;');
    $.ajax('https://arisalexis-soccer-odds-v1.p.mashape.com/upcoming', {
        headers: {
          'X-Mashape-Key': 'ZL18HPvJJ2mshDsSEYFbEhinpKOHp1ZDTBMjsnI2ZYe09vCsmi',
          'Accept': 'application/json'
        }
    }).done (data) ->
      $('img[src="/assets/ajax-loader.gif"]').remove();

      data.forEach (match) ->
        $card = $('#match-card-container').children('div').clone();
        $('#upcoming-matches-container').append($card);
        $card.children('div').html(match.homeTeam + ' vs ' + match.awayTeam);
        date = new Date(match.tstamp*1000);
        formattedDate = date.getFullYear() + '/' + date.getMonth()+1 + '/' + date.getDate();
        $card.children('p').html(match.leagueName + ' - ' + formattedDate);

      $("div.match.card").on "click", () ->
        splitted = $(this).children('div').html().split(' vs ')
        $('#upcoming-matches-container').empty()
        $('#expand-matches-button').attr('style', '')

        $firstField = $("#numeric-field").last().clone()
        $("div#fields").append($firstField)
        $("div#fields div.gee-field").attr("class", "gee-field")
        $firstField = $firstField.children('div')
        $firstField.children('input[name="field_names[]"]').val(splitted[0] + ' score')
        $firstField.children('input[name="field_min_values[]"]').val('0')
        $firstField.children('input[name="field_max_values[]"]').val('100')

        $secondField = $("#numeric-field").last().clone()
        $("div#fields").append($secondField)
        $("div#fields div.gee-field").attr("class", "gee-field")
        $secondField = $secondField.children('div')
        $secondField.children('input[name="field_names[]"]').val(splitted[1] + ' score')
        $secondField.children('input[name="field_min_values[]"]').val('0')
        $secondField.children('input[name="field_max_values[]"]').val('100')

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
