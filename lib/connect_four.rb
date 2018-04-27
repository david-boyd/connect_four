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

  # column - Valid values between 1 and DEFAULT_COLUMNS
  # player - player who has taken turn
  def drop_disc(column, player)
    if valid_column?(column)
      column -= 1 #subtract one for array index
      unless column_full?(column)
        @board[column][next_free_row(column)] = player.disc
      else
        raise ColumnFullError
      end
    else
      raise InvalidColumnError
    end
  end

  private

    def column_full?(column)
      !@board[column][0].nil?
    end

    def next_free_row(column)
      @board[column].rindex(nil)
    end

    def valid_column?(column)
      column.between?(1, DEFAULT_COLUMNS)
    end


end

