require 'connect_four/player'

class ConnectFour

  DEFAULT_COLUMNS = 6
  DEFAULT_ROWS = 7

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    ConnectFour.new(columns.times.map {Array.new(rows)})
  end

  def drop_disc(column, player)
    column = column - 1
    index = next_free_cell(@board[column])
    @board[column][index] = player.disc
  end

  private

    def next_free_cell(column)
      column.rindex(nil)
    end
end

