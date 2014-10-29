class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :omniauthable, :omniauth_providers => [:trello]

  def self.from_omniauth(auth)
    where(trello_uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.trello_token = auth.credentials.token
      user.trello_secret = auth.credentials.secret
    end
  end
end
