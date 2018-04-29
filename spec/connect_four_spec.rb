RSpec.describe ConnectFour do
  let(:mock_prompt) {double("Prompt").as_null_object}
  let(:game) {ConnectFour.build}
  let(:human) {Human.new('0', mock_prompt)}
  let(:computer) {Computer.new('X')}
  let(:mock_board) {instance_double("Board", :grid => [[]]).as_null_object}

  it 'create new game' do
    game = ConnectFour.build #default columns
    expect(game.board.grid).to_not be_nil
    expect(game.board.grid.length).to eq(7)
    expect(game.board.grid[0].length).to eq(6)

    game = ConnectFour.build(12, 10) # non standard board
    expect(game.board.grid.length).to eq(12)
    expect(game.board.grid[0].length).to eq(10)
  end

  context 'adding players' do
    it 'players must have unique disc' do
      game.add_player(Player.new('0'))
      expect {game.add_player(Player.new('0'))}.to raise_error("Connect Four players must have unique disc's")
    end

    it 'can only have two players' do
      game.add_player(Player.new('0'))
      game.add_player(Player.new('X'))
      expect {game.add_player(Player.new('Y'))}.to raise_error('Connect Four can only have two players')
    end

  end

  context 'playing a game' do
    before do
      @game = ConnectFour.new(mock_board)
      allow(mock_board).to receive(:max_columns) {7}
    end

    it 'must have two players to play' do
      two_player_error = 'Connect Four needs two players to start'
      allow(mock_board).to receive(:winner) {human}
      allow(mock_board).to receive_message_chain(:valid_columns,:empty?) {false}

      expect {@game.start(mock_prompt)}.to raise_error(two_player_error)
      @game.add_player(human)
      expect {@game.start(mock_prompt)}.to raise_error(two_player_error)
      @game.add_player(computer)
      @game.start(mock_prompt)
    end

    it 'playing game one turn per player' do
      human = instance_double("Human", disc: 'H')
      computer = instance_double("Computer", disc: 'C')
      @game.add_player(human)
      @game.add_player(computer)

      allow(mock_board).to receive_message_chain(:valid_columns,:empty?) {false}
      expect(human).to receive(:get_move).once {1}
      expect(computer).to receive(:get_move).once {1}
      #final winner is the human which will end the game
      allow(mock_board).to receive_message_chain(:winner,:name) {"You"}
      expect(mock_board).to receive(:winner).and_return(nil, human)
      @game.start(mock_prompt)
    end
  end

  context "stalemate" do
    it 'checks for stalemate condition' do
      game = ConnectFour.build(2, 1)
      game.add_player(FirstColumnPickingComputer.new('0'))
      game.add_player(SecondColumnPickingComputer.new('X'))
      expect {game.start(mock_prompt)}.to raise_error("Game over, stalemate!")
    end

    class FirstColumnPickingComputer < Player
      def get_move(valid_columns)
        1
      end
    end
    class SecondColumnPickingComputer < Player
      def get_move(valid_columns)
        2
      end
    end
  end
end