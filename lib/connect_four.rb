require 'connect_four/player'
require 'connect_four/exceptions/column_full_error'
require 'connect_four/exceptions/invalid_column_error'

class ConnectFour

  DEFAULT_COLUMNS = 7
  DEFAULT_ROWS = 6

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    ConnectFour.new(columns.times.map {Array.new(rows)})
  end

  def drop_disc(column, player)
    raise InvalidColumnError unless column.between?(1, DEFAULT_COLUMNS)
    column = column - 1
    index = next_free_cell(@board[column])
    raise ColumnFullError if index.nil?
    @board[column][index] = player.disc
  end

  private

    def next_free_cell(column)
      column.rindex(nil)
    end

end

