class Statistic < ActiveRecord::Base
  belongs_to :board

  serialize :data

  validates :board_id, :data, presence: true
end
