class StatisticsController < ApplicationController
  before_action :fetch_board, only: [:index]

  def collect
    StatisticsCollector.collect_for_all
    render nothing: true
  end

  def index
    @graph_data = get_graph_data
  end

  private

  def fetch_board
    @board = Board.find_by trello_id: params[:board_id]
  end

  def get_graph_data
    @board.last_statistics.map do |s|
      { date: s.created_at.to_date, stat: prepared_data(@board.last_statistics.last.data.keys, s.data) }
    end
  end

  def prepared_data keys, data
    keys.each_with_object({}) do |k, obj|
      obj[k] = (data[k] || 0) + data['Archive'] if k != 'Archive'
    end
  end
end
