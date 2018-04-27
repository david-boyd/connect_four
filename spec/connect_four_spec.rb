RSpec.describe ConnectFour do
  let(:game) {ConnectFour.build}
  let(:player_1) {Player.new('0')}
  let(:player_2) {Player.new('X')}

  it "create new game, with 7 columns and 6 rows " do
    expect(game.board).to_not be_nil
    expect(game.board.length).to eq(6)
    expect(game.board[0].length).to eq(7)
  end

  it 'a player can drop a disc' do
    game.drop_disc(1, player_1)
    verify_disc(game, 1, 7, player_1.disc)
  end

  def verify_disc(game, column, row, disc)
    column -= 1
    row -= 1
    expect(game.board[column][row]).to eq(disc)
  end
end
