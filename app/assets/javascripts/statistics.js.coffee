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

  max_value = (d) ->
    max = 0
    for key, value of d
      if max < value
        max = value
    max

  min_value = (d) ->
    min = 1000000000
    for key, value of d
      if min > value
        min = value
    min

  zoomed = () ->
    graph.select(".x.axis").call(x_axis)
    graph.select(".y.axis").call(y_axis)
    Object.keys(data[data.length - 1].stat).forEach (key, i) ->
      graph
        .select("path#line_" + i)
        .attr("d", line_func(key)(data))

  x_range = d3
    .time
    .scale()
    .domain([new Date(data[0].date), d3.time.day.offset(new Date(data[data.length - 1].date), 1)])
    .range([margins.left, width - margins.right])
  y_range = d3
    .scale
    .linear()
    .range([height - margins.bottom, margins.top])
    .domain([d3.min(data, (d) ->
        min_value(d.stat)
      ), d3.max(data, (d) ->
        max_value(d.stat)
      )])
  x_axis = d3.svg.axis()
    .scale(x_range)
    .orient('bottom')
    .tickSize(-height + margins.top + margins.bottom, 0)
    .tickSubdivide(true)
    .tickFormat(d3.time.format('%d.%m'))
    .tickPadding(8)
  y_axis = d3.svg.axis()
    .scale(y_range)
    .tickSize(1)
    .orient('left')
    .tickSize(-width + margins.left + margins.right, 0)
    .tickFormat(d3.format('d'))
    # .tickSubdivide(true)

  zoom = d3.behavior.zoom()
    .x(x_range)
    .y(y_range)
    .scaleExtent([1, 10])
    .size([
      width - margins.left - margins.right,
      height - margins.top - margins.bottom
    ])
    .on("zoom", zoomed)

  graph = d3.select('#graph').append('svg')
  graph
    .attr('width', width)
    .attr('height', height)
    .text('Board Graph')
    .append("svg:g")
    .attr("transform", "translate(" + margins.left + "," + margins.top + ")")
    .call(zoom)

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

  graph.append("rect")
    .attr("class", "pane")
    .attr("width", width - margins.left - margins.right)
    .attr("height", height - margins.top - margins.bottom)
    .attr("x", margins.left)
    .attr("y", margins.top)
    .call(zoom)

  graph.append("clipPath")
    .attr("id", "clip")
    .append("rect")
    .attr("width", width - margins.left - margins.right)
    .attr("height", height - margins.top - margins.bottom)
    .attr("x", margins.left)
    .attr("y", margins.top)

  line_func = (key) ->
    d3.svg.line()
      .x((d) ->
        x_range(new Date(d.date))
      )
      .y((d) ->
        y_range(d.stat[key])
      )
      .interpolate('linear')

  palette = d3.scale.category20()
  Object.keys(data[data.length - 1].stat).forEach (key, i) ->
    graph
      .append('path')
      .attr('id', "line_" + i)
      .attr('d',line_func(key)(data))
      .attr('stroke', palette(i))
      .attr('stroke-width', 2)
      .attr('fill', 'none')
      .attr("clip-path", "url(#clip)")

