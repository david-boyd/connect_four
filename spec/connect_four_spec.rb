RSpec.describe ConnectFour do
  let(:game) {ConnectFour.build}

  it 'create new game' do
    game = ConnectFour.build #default columns
    expect(game.board.grid).to_not be_nil
    expect(game.board.grid.length).to eq(7)
    expect(game.board.grid[0].length).to eq(6)

    game = ConnectFour.build(12,10) # non standard board
    expect(game.board.grid.length).to eq(12)
    expect(game.board.grid[0].length).to eq(10)
  end
end