class StatisticsController < ApplicationController
  def collect
    StatisticsCollector.collect_for_all
    render nothing: true
  end

  def index
  end
end
