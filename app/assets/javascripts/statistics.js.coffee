$(document).on 'page:change', ->
  return unless $('body')[0].id == 'statistics_index'

  $('#graph').stat_graph()

