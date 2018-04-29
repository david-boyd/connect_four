class Player
  attr_accessor :disc, :prompt

  def initialize(disc, prompt = nil)
    @disc = disc
    @prompt = prompt
  end
end