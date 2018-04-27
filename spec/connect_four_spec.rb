RSpec.describe ConnectFour do

  let(:game) {ConnectFour.build}
  let(:player_1) {Player.new('0')}
  let(:player_2) {Player.new('X')}

  it "create new game, with 6 columns and 7 rows" do
    expect(game.board).to_not be_nil
    expect(game.board.length).to eq(7)
    expect(game.board[0].length).to eq(6)
  end

  it 'a player can drop a disc' do
    game.drop_disc(1, player_1)
    verify_disc(game, 1, ConnectFour::DEFAULT_ROWS, player_1.disc)
  end

  it 'prevents invalid column choice' do
    # out of range
    expect {game.drop_disc(0, player_1)}.to raise_error(InvalidColumnError)
    expect {game.drop_disc(ConnectFour::DEFAULT_COLUMNS + 1, player_1)}.to raise_error(InvalidColumnError)

    # column already full
    1..ConnectFour::DEFAULT_ROWS.times do |x|
      game.drop_disc(4,player_1)
    end
    expect{game.drop_disc(4,player_1)}.to raise_error(ColumnFullError)
  end

  def verify_disc(game, column, row, disc)
    column -= 1
    row -= 1
    expect(game.board[column][row]).to eq(disc)
  end
end
