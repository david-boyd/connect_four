require_relative 'exceptions/column_full_error'
require_relative 'exceptions/invalid_column_error'

class Board

  EMPTY_CELL = '-'

  attr_accessor :grid, :winner, :max_columns, :max_rows, :disc_to_win

  def initialize(columns, rows, discs_to_win)
    @discs_to_win = discs_to_win
    @max_columns = columns
    @max_rows = rows
    @grid = columns.times.map {Array.new(rows, EMPTY_CELL)}
  end

  # column - Valid values between 1 and @max_columns
  # player - player who has taken turn
  def drop_disc(column, player)
    if valid_column?(column)
      column -= 1 #subtract one for array index
      if !column_full?(column)
        next_free_row = @grid[column].rindex(EMPTY_CELL)
        @grid[column][next_free_row] = player.disc
      else
        raise ColumnFullError
      end
    else
      raise InvalidColumnError
    end

    # check for new winner
    if @winner.nil? && check_win?(player.disc)
      @winner = player
    end
  end

  private

    def check_win?(disc)
      has_row_win_condition?(disc) || has_column_win_condition?(disc)
    end

    def has_column_win_condition?(disc, board = @grid)
      winnning_string = disc * @discs_to_win
      board.each do |row|
        if row.join.include?(winnning_string)
          return true
        end
      end
      false
    end

    def has_row_win_condition?(disc)
      has_column_win_condition?(disc, @grid.transpose)
    end

    def column_full?(column)
      @grid[column][0] != EMPTY_CELL
    end

    def valid_column?(column)
      column.between?(1, @max_columns)
    end
end