class BoardsController < ApplicationController
  before_action :fetch_board, only: [:update]

  def index
    @boards = get_boards
  end

  def update
    current_user.add_board @board
    @board.update! board_params
    redirect_to boards_url
  end

  private

  def board_params
    params.require(:board).permit(:active)
  end

  def client
    @client ||= TrelloClient.new current_user.trello_token, current_user.trello_secret
  end

  def get_boards
    saved_boards = current_user.boards.each_with_object({}) { |b, m| m[b.trello_id] = b }
    client.get_member(current_user.trello_uid).boards.map do |b|
      {
        name: b.name,
        id: b.id,
        active: saved_boards.has_key?(b.id) ? saved_boards[b.id].active? : false
      }
    end
  end

  def fetch_board
    @board = Board.find_or_create_by trello_id: params[:id]
  end
end
