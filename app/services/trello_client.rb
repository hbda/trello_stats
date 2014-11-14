require 'trello'

class TrelloClient
  def initialize user
    @user = user
  end

  def member
    client.find :member, @user.trello_uid
  end

  def get_board id
    client.find :board, id
  end

  private

  def client
    @client ||= Trello::Client.new(
      :consumer_key => ENV['TRELLO_KEY'],
      :consumer_secret => ENV['TRELLO_SECRET'],
      :oauth_token => @user.trello_token,
      :oauth_token_secret => @user.trello_secret
    )
  end
end
