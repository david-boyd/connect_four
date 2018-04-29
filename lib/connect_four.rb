require_relative 'connect_four/player'
require_relative 'connect_four/board'
require_relative 'connect_four/human'
require_relative 'connect_four/computer'
require 'tty-table'

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

  def start(prompt)
    if has_two_players?
      current_player = coin_flip
      prompt.say("#{current_player.class} goes first")
      loop do
        valid_columns = @board.valid_columns
        if valid_columns.empty?
          raise "Game over, stalemate!"
        end
        column = current_player.get_move(valid_columns)
        @board.drop_disc(column, current_player)
        current_player = swap_players(current_player)
        prompt.say(render_board)
        break if finished?
      end
    else
      raise 'Connect Four needs two players to start'
    end
    prompt.say("Game over #{@board.winner.class} won!!") unless @board.winner.nil?
  end

  private

    def render_board
      table_header = (1..@board.max_columns).to_a
      table = TTY::Table.new(table_header, @board.grid.transpose)
      table.render(:ascii)
    end

    def has_two_players?
      !@player1.nil? && !@player2.nil?
    end

    def coin_flip
      Random.rand(2) == 0 ? @player1 : @player2
    end

    def swap_players(player)
      player == @player1 ? @player2 : @player1
    end

    def finished?
      !@board.winner.nil?
    end
end