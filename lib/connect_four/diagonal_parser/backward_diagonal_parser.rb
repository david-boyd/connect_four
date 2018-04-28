require_relative 'diagonal_parser'

# Implementation of DiagonalParser that pulls out diagonals of direction '\'
class BackwardDiagonalParser < DiagonalParser

  def starting_column
    0
  end

  def ending_column
    max_col_index
  end

  def valid_column_to_parse(value)
    value <= ending_column
  end

  def next_column_index(value)
    value + 1
  end

  def next_cell_column_index(value)
    value - 1
  end

  def column_out_of_bounds(value)
    value < starting_column
  end


end