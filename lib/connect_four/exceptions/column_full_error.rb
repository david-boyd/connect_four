class ColumnFullError < StandardError

  def initialize(msg = "Column is already full")
    super
  end
end