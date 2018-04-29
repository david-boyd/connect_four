require_relative 'player'

class Human < Player

  def get_move(valid_columns)
    valid_columns = Array(valid_columns)
    prompt.ask("Please pick a column (#{valid_columns.join(', ')}):") do |q|
      q.validate(Regexp.new(valid_columns.join("|")), 'Invalid column number')
    end
  end
end