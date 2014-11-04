class Board < ActiveRecord::Base
  has_and_belongs_to_many :users

  validate :trello_id, presence: true, uniqueness: true
end
