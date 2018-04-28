require 'connect_four/player'
require 'connect_four/board'
require 'connect_four/human'
require 'connect_four/computer'

class ConnectFour

  DEFAULT_COLUMNS = 7
  DEFAULT_ROWS = 6
  DISC_REQUIRED_TO_WIN = 4

  attr_accessor :board, :player1, :player2

  def initialize(board)
    @board = board
  end

  def self.build(columns = DEFAULT_COLUMNS, rows = DEFAULT_ROWS)
    ConnectFour.new(Board.new(columns, rows, DISC_REQUIRED_TO_WIN))
  end

  def add_player(player)
    raise 'Connect Four can only have two players' if has_two_players?
    if @player1.nil?
      @player1 = player
    elsif @player2.nil?
      raise "Connect Four players must have unique disc's" if player.disc == @player1.disc
      @player2 = player
    end
  end

  def start
    if has_two_players?
      current_player = coin_flip

      loop do
        current_player.get_move
        current_player = swap_players(current_player)
        break if finished?
      end
    else
      raise 'Connect Four needs two players to start'
    end
  end

  private

    def has_two_players?
      !@player1.nil? && !@player2.nil?
    end

    def coin_flip
      Random.rand(1) == 0 ? @player1 : @player2
    end

    def swap_players(player)
      player == @player1 ? @player2 : @player1
    end

    def finished?
      !@board.winner.nil?
    end

end