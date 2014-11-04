require 'trello'

class TrelloClient
  def initialize token, secret
    @token = token
    @secret = secret
  end

  def get_member uid
    client.find :member, uid
  end

  private

  def client
    @client ||= Trello::Client.new(
      :consumer_key => ENV['TRELLO_KEY'],
      :consumer_secret => ENV['TRELLO_SECRET'],
      :oauth_token => @token,
      :oauth_token_secret => @secret
    )
  end
end
