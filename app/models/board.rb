class Board < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :statistics

  validate :trello_id, presence: true, uniqueness: true

  scope :active, -> { where(is_active: true) }
end
