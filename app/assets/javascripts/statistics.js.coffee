$(document).on 'page:change', ->
  return unless $('body')[0].id == 'statistics_index'

  data = $('#graph').data('graph-data')

  width = 1200
  height = 650
  margins = {
    top: 20,
    right: 20,
    bottom: 30,
    left: 50
  }

  graph = d3.select('#graph').append('svg')
  graph
    .attr('width', width)
    .attr('height', height)
    .text('Board Graph')

  x_range = d3
    .time
    .scale()
    .domain([+new Date(data[0].date), +d3.time.day.offset(new Date(data[data.length - 1].date), 1)])
    .range([margins.left, width - margins.right])
  y_range = d3
    .scale
    .linear()
    .range([height - margins.bottom, margins.top])
    .domain([0, d3.max(data, (d) ->
      d.stat.Backlog
    )])
  x_axis = d3.svg.axis()
    .scale(x_range)
    .orient('bottom')
    .tickSize(5, 0)
    .tickSubdivide(true)
    # .ticks(d3.time.days, 1)
    .tickFormat(d3.time.format('%d.%m'))
    # .tickPadding(8)
  y_axis = d3.svg.axis()
    .scale(y_range)
    .tickSize(1)
    .orient('left')
    # .tickSubdivide(true)

  graph
    .append('svg:g')
    .attr('class', 'x axis')
    .attr('transform', 'translate(0,' + (height - margins.bottom) + ')')
    .call(x_axis)
    # .selectAll(".tick text")
    # .style("text-anchor", "start")
    # .attr("x", 9)
    # .attr("y", 0)
    # .attr("transform", "rotate(90)")
    # .attr("dy", ".05em")

  graph
    .append('svg:g')
    .attr('class', 'y axis')
    .attr('transform', 'translate(' + (margins.left) + ',0)')
    .call(y_axis)

  line_func = d3.svg.line()
    .x((d) ->
      x_range(new Date(d.date))
    )
    .y((d) ->
      y_range(d.stat.Backlog)
    )
    .interpolate('linear')

  graph
    .append('svg:path')
    .attr('d', line_func(data))
    .attr('stroke', 'blue')
    .attr('stroke-width', 2)
    .attr('fill', 'none');