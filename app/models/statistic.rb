class Statistic < ActiveRecord::Base
  belongs_to :board

  serialize :data


  validate :board_id, :data, presence: true
end
