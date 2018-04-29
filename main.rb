require 'tty'
require_relative 'lib/connect_four'
prompt = TTY::Prompt.new

if prompt.yes?('Are you ready to start?')
  prompt.say("Picking who goes first... coin flipping")
  sleep(2) #adding a delay to make it easier to read
  game = ConnectFour.build
  game.add_player(Human.new("0", prompt))
  game.add_player(Computer.new("o", prompt))
  begin
    game.start(prompt)
  rescue => e
    prompt.say(e.message)
  end
end
