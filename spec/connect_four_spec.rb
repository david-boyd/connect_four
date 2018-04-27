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
    #out of range
    expect {game.drop_disc(0, player_1)}.to raise_error(InvalidColumnError)
    expect {game.drop_disc(ConnectFour::DEFAULT_COLUMNS + 1, player_1)}.to raise_error(InvalidColumnError)

    #column already full
    1..ConnectFour::DEFAULT_ROWS.times do
      game.drop_disc(4, player_1)
    end
    expect {game.drop_disc(4, player_1)}.to raise_error(ColumnFullError)
  end

  it 'verifies row win conditions' do
    expect(game.finished?).to be_falsey
    #drop first three discs
    (1..3).each do |column|
      game.drop_disc(column, player_1)
    end
    #drop final disc
    expect(game.finished?).to be_falsey
    game.drop_disc(4, player_1)
    expect(game.finished?).to be_truthy
    #expect winner recorded
    expect(game.winner).to eq(player_1)

    #test other column
    game = ConnectFour.build
    expect(game.finished?).to be_falsey
    (2..5).each {|column| game.drop_disc(column, player_1)}
    expect(game.finished?).to be_truthy

    game = ConnectFour.build
    (3..6).each {|column| game.drop_disc(column, player_1)}
    expect(game.finished?).to be_truthy

    #test four must be in a row
    game = ConnectFour.build
    game.drop_disc(1, player_1)
    game.drop_disc(3, player_1)
    game.drop_disc(4, player_1)
    game.drop_disc(5, player_1)
    expect(game.finished?).to be_falsey
  end

  it 'verifies column win conditions' do
    expect(game.finished?).to be_falsey
    #drop first three discs
    3.times {game.drop_disc(3, player_1)}
    #drop final disc
    expect(game.finished?).to be_falsey
    game.drop_disc(3, player_1)
    expect(game.finished?).to be_truthy
    #expect winner recorded
    expect(game.winner).to eq(player_1)
  end

  def verify_disc(game, column, row, disc)
    column -= 1
    row -= 1
    expect(game.board[column][row]).to eq(disc)
  end
end
