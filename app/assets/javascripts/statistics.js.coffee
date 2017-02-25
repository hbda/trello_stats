$(document).on 'page:change', ->
  return if $('body')[0].id != 'statistics_index' && $('body')[0].id != 'statistics_example'

  $('#graph').stat_graph()
