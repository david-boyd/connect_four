class Board
  attr_accessor :data

  def initialize(columns, rows)
    @data = columns.times.map {Array.new(rows)}
  end
end