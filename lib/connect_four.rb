require 'connect_four/player'
require 'connect_four/board'

class ConnectFour

  DEFAULT_COLUMNS = 7
  DEFAULT_ROWS = 6
  DISC_REQUIRED_TO_WIN = 4

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    ConnectFour.new(Board.new(columns, rows, DISC_REQUIRED_TO_WIN))
  end

end