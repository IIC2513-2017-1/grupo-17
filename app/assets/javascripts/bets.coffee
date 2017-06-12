# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'turbolinks:load', () ->

    $('#hidden-data ul li').each (index) ->
      aux = $(this).text().split(' ', 2)
      valueId = aux[0]
      valueName = aux[1]
      $('#bets-charts').append('<div id=chart' + index + '></div>')

      data = []

      $('#hidden-data').find('tbody').children().each (index) ->
        if $(this).children(':nth-child(1)').text() == valueId
          data.push({
            name: $(this).children(':nth-child(2)').text()
            y: parseInt($(this).children(':nth-child(3)').text())
          })

      Highcharts.chart('chart' + index, {
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: null,
              plotShadow: false,
              type: 'pie'
          },
          title: {
              text: valueName
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                      enabled: false
                  },
                  showInLegend: true
              }
          },
          series: [{
              name: 'Values',
              colorByPoint: true,
              data: data
          }]
      });
