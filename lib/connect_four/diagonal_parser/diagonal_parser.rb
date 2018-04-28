# Base strategy to parse diagonals out of a two dimension array
class DiagonalParser

  MESS = "Abstract method: method missing"

  def initialize(grid)
    @grid = grid
  end

  def max_col_index
    @max_col_index ||= @grid.length - 1
  end

  def max_row_index
    @max_row_index ||= @grid[0].length - 1
  end

  def starting_column; raise MESS; end

  def ending_column; raise MESS; end

  def valid_column_to_parse(value); raise MESS; end

  def next_column_index(value); raise MESS; end

  def next_cell_column_index(value) ; raise MESS; end

  def column_out_of_bounds(value); raise MESS; end

  # returns an array of all the diagonals within the grid.
  # This method will only return arrays with at least min_size cells
  def parse(min_size = 0)
    diagonals = []
    column = starting_column
    row = max_row_index
    while valid_column_to_parse(column) && row >= 0
      output = []
      tmp_row = row
      tmp_column = column
      loop do
        output << @grid[tmp_column][tmp_row]
        tmp_column = next_cell_column_index(tmp_column)
        tmp_row -= 1
        if column_out_of_bounds(tmp_column) || tmp_row < 0 #out of bounds
          diagonals << output if output.length >= min_size
          if column != ending_column
            column = next_column_index(column)
          else
            row -= 1
          end
          break
        end
      end
    end
    diagonals
  end
end