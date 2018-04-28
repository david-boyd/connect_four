RSpec.describe ConnectFour do
  let(:game) {ConnectFour.build}
  let(:human) {Human.new('0')}
  let(:computer) {Computer.new('X')}
  let(:mock_board) {instance_double("Board")}

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

    it 'must have two players to play' do
      two_player_error = 'Connect Four needs two players to start'
      game = ConnectFour.new(mock_board)
      expect(mock_board).to receive(:winner) {human}
      expect {game.start}.to raise_error(two_player_error)
      game.add_player(human)
      expect {game.start}.to raise_error(two_player_error)
      game.add_player(computer)
      game.start
    end

  end

  it 'playing game one turn per player' do
    game = ConnectFour.new(mock_board)
    human = instance_double("Human", disc: 'H')
    computer = instance_double("Computer", disc: 'C')
    game.add_player(human)
    game.add_player(computer)

    expect(human).to receive(:get_move).once {1}
    expect(computer).to receive(:get_move).once {1}
    expect(mock_board).to receive(:winner).and_return(nil, human)
    game.start

  end
end