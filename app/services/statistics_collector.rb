class StatisticsCollector
  def initialize board
    @board = board
  end

  def self.collect_for_all
    boards_to_collect.each { |board| StatisticsCollector.new(board).collect }
  end

  def collect
    Statistic.create! board: @board, data: board_stat
  rescue StandardError => ex
    puts ex
  end

  private

  def self.boards_to_collect
    @boards ||= Board.active.joins(:users)
  end

  def board_stat
    data = trello_board.lists.each_with_object({}) do |l, memo|
      memo[l.name] = l.cards.count
    end
    data['Archive'] = trello_board.cards(filter: :closed).count
    data
  end

  def trello_board
    @trello_board ||= client.get_board @board.trello_id
  end

  def client
    @client ||= TrelloClient.new(@board.users.first)
  end

end
