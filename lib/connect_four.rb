require 'connect_four/player'
require 'connect_four/exceptions/column_full_error'
require 'connect_four/exceptions/invalid_column_error'

class ConnectFour

  EMPTY_CELL = '-'
  DEFAULT_COLUMNS = 7
  DEFAULT_ROWS = 6

  attr_accessor :board, :winner


  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    ConnectFour.new(columns.times.map {Array.new(rows, EMPTY_CELL)})
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

    #verify if there is a winner store who it was
    unless finished?
      check_for_winner(player)
    end
  end

  def finished?
    !winner.nil?
  end

  private

    def check_for_winner(player)
      if has_row_win_condition?(player.disc) || has_column_win_condition?(player.disc)
        @winner = player
      end
    end

    def has_row_win_condition?(disc)
      has_column_win_condition?(disc,@board.transpose)
    end

    def has_column_win_condition?(disc, board = @board)
      winnning_string = disc * 4
      board.transpose.each do |row|
        if row.join.include?(winnning_string)
          return true
        end
      end
      false
    end

    def column_full?(column)
      @board[column][0] != EMPTY_CELL
    end

    def next_free_row(column)
      @board[column].rindex(EMPTY_CELL)
    end

    def valid_column?(column)
      column.between?(1, DEFAULT_COLUMNS)
    end

end