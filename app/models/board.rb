class Board < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :statistics

  validates :trello_id, presence: true, uniqueness: true

  scope :active, -> { where(is_active: true) }

  def last_statistics
    statistics.order(created_at: :desc).take(60).sort_by { |s| s.created_at }
  end
end
