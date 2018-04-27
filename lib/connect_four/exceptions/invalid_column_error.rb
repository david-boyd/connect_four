class InvalidColumnError < StandardError

  def initialize(msg = "Invalid column choice")
    super
  end
end