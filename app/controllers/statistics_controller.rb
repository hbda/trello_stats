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
    @board.statistics.order(:created_at).map { |s| { date: s.created_at.to_date, stat: s.data} }
  end
end
