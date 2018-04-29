require_relative 'player'
require 'tty-spinner'

class Computer < Player

  def get_move(valid_columns)
    valid_columns = Array(valid_columns)

    #Pick a random column
    column_choice = valid_columns[Random.rand(valid_columns.length)]

    #show computer is thinking to user if there is a prompt
    unless prompt.nil?
      simulate_computer_thinking
      prompt.say("Computer picks column: #{column_choice}")
    end
    column_choice
  end

  #Nice little method to make it seem the computer is thinking
  def simulate_computer_thinking
    spinner = TTY::Spinner.new("[:spinner] Computer Thinking ...", format: :pulse_2)
    spinner.auto_spin # Automatic animation with default interval
    sleep(2) # Perform task
    spinner.stop('Done!') # Stop animation
  end

  def name
    "The Computer"
  end
end