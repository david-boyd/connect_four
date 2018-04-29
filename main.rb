require 'tty'
require_relative 'lib/connect_four'
prompt = TTY::Prompt.new

if prompt.yes?('Are you ready to start?')
  prompt.say("Your disc is '0', the computers is 'X'")
  prompt.say("Picking who goes first... coin flipping")
  sleep(2) #adding a delay to make game play nicer
  game = ConnectFour.build
  game.add_player(Human.new("0", prompt))
  game.add_player(Computer.new("X", prompt))
  begin
    game.start(prompt)
  rescue => e
    prompt.say(e.message)
  end
end
