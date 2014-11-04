class BoardsController < ApplicationController
  before_action :fetch_board, only: [:activate, :deactivate]
  def index
    @boards = get_boards
  end

  def activate
    @board.active = true
    @board.save!
    redirect_to boards_url
  end

  def deactivate
    @board.active = false
    @board.save!
    redirect_to boards_url
  end

  private

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
    @board = Board.find_or_create_by trello_id: params[:id] do |board|
      board.users << current_user
    end
  end
end
