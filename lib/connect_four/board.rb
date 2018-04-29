require_relative 'exceptions/column_full_error'
require_relative 'exceptions/invalid_column_error'
require_relative 'diagonal_parser/backward_diagonal_parser'
require_relative 'diagonal_parser/forward_diagonal_parser'

class Board

  EMPTY_CELL = '-'

  attr_accessor :grid, :winner, :max_columns, :max_rows, :disc_to_win

  def initialize(columns, rows, discs_to_win)
    @discs_to_win = discs_to_win
    @max_columns = columns
    @max_rows = rows
    # creating grid with columns then rows, this makes it easier to when adding disc
    # simply need to traverse down the 'column'
    @grid = columns.times.map {Array.new(rows, EMPTY_CELL)}
  end

  # column - Valid values between 1 and @max_columns
  # player - player who has taken turn
  def drop_disc(column, player)
    column = column.to_i
    if valid_column?(column)
      if !column_full?(column)
        column -= 1 #subtract one for array index
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


  def valid_columns
    non_full_columns = []
    (1..max_columns).each do |x|
      unless column_full?(x)
        non_full_columns << x
      end
    end
    non_full_columns
  end

  private

    def check_win?(disc)
      has_row_win_condition?(disc) || has_column_win_condition?(disc) || has_diagonal_win_condition?(disc)
    end

    def has_column_win_condition?(disc, board = @grid)
      winning_string = disc * @discs_to_win
      board.each do |row|
        if row.join.include?(winning_string)
          return true
        end
      end
      false
    end

    def has_row_win_condition?(disc)
      has_column_win_condition?(disc, @grid.transpose)
    end

    def has_diagonal_win_condition?(disc)
      diagonal_columns = ForwardDiagonalParser.new(@grid).parse(@discs_to_win) + BackwardDiagonalParser.new(@grid).parse(@discs_to_win)
      has_column_win_condition?(disc, diagonal_columns)
    end

    def column_full?(column)
      @grid[(column - 1)][0] != EMPTY_CELL
    end

    def valid_column?(column)
      column.between?(1, @max_columns)
    end
end