require 'connect_four/board'
class ConnectFour

  DEFAULT_COLUMNS = 6
  DEFAULT_ROWS = 7

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    new(Board.new(columns, rows))
  end

end

