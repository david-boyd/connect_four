RSpec.describe Board do

  let(:max_row) {6}
  let(:max_column) {7}
  let(:disc_to_win) {4}
  let(:board) {new_board}
  let(:player_1) {Player.new('0')}
  let(:player_2) {Player.new('X')}

  it 'a player can drop a disc' do
    board.drop_disc(1, player_1)
    verify_disc(board, 1, ConnectFour::DEFAULT_ROWS, player_1.disc)
  end

  it 'a player can drop a disc' do
    board.drop_disc(1, player_1)
    verify_disc(board, 1, ConnectFour::DEFAULT_ROWS, player_1.disc)
  end

  it 'prevents invalid column choice' do
    #out of range
    expect {board.drop_disc(0, player_1)}.to raise_error(InvalidColumnError)
    expect {board.drop_disc(ConnectFour::DEFAULT_COLUMNS + 1, player_1)}.to raise_error(InvalidColumnError)

    #column already full
    1..ConnectFour::DEFAULT_ROWS.times do
      board.drop_disc(4, player_1)
    end
    expect {board.drop_disc(4, player_1)}.to raise_error(ColumnFullError)
  end

  context 'verifies row win conditions' do

    it 'single player' do
      expect(board.winner).to be_nil
      #drop first three discs
      (1..3).each do |column|
        board.drop_disc(column, player_1)
      end
      #drop final disc
      expect(board.winner).to be_nil
      board.drop_disc(4, player_1)
      expect(board.winner).to eq(player_1)

      #test other column
      board = new_board
      expect(board.winner).to be_nil
      (2..5).each {|column| board.drop_disc(column, player_1)}
      expect(board.winner).to eq(player_1)

      board = new_board
      (3..6).each {|column| board.drop_disc(column, player_1)}
      expect(board.winner).to eq(player_1)

      #test four must be in a row
      board = new_board
      board.drop_disc(1, player_1)
      board.drop_disc(3, player_1)
      board.drop_disc(4, player_1)
      board.drop_disc(5, player_1)
      expect(board.winner).to be_nil
    end

    it 'two players' do
      board.drop_disc(1, player_1)
      board.drop_disc(2, player_2)
      board.drop_disc(3, player_1)
      board.drop_disc(4, player_1)
      expect(board.winner).to be_nil
      board.drop_disc(5, player_1)
      board.drop_disc(6, player_1)
      expect(board.winner).to eq(player_1)
    end
  end

  context 'verifies column win conditions' do

    it 'single player' do
      expect(board.winner).to be_nil
      #drop first three discs
      3.times {board.drop_disc(3, player_1)}
      #drop final disc
      expect(board.winner).to be_nil
      board.drop_disc(3, player_1)
      expect(board.winner).to eq(player_1)
    end

    it 'two players' do
      board.drop_disc(1, player_2)
      board.drop_disc(1, player_1)
      board.drop_disc(1, player_2)
      board.drop_disc(1, player_2)
      expect(board.winner).to be_nil
      board.drop_disc(1, player_2)
      board.drop_disc(1, player_2)
      expect(board.winner).to eq(player_2)
    end
  end

  context 'verifies diagonal win conditions' do

    it 'left to right diagonal' do
      #fill in non winning disc's
      3.times {board.drop_disc(1, player_1)}
      2.times {board.drop_disc(2, player_1)}
      board.drop_disc(3, player_1)
      expect(board.winner).to be_nil
      board.drop_disc(1, player_2)
      board.drop_disc(2, player_2)
      board.drop_disc(3, player_2)
      board.drop_disc(4, player_2)
      expect(board.winner).to eq(player_2)
    end

    it 'right to left diagonal' do
      #fill in non winning disc's
      3.times {board.drop_disc(2, player_1)}
      board.drop_disc(2, player_2)
      3.times {board.drop_disc(3, player_2)}
      2.times {board.drop_disc(4, player_1)}
      board.drop_disc(4, player_1)
      expect(board.winner).to be_nil
      board.drop_disc(2, player_1)
      board.drop_disc(3, player_1)
      board.drop_disc(4, player_1)
      board.drop_disc(4, player_1)
      expect(board.winner).to eq(player_1)
    end
  end

  def verify_disc(board, column, row, disc)
    column -= 1
    row -= 1
    expect(board.grid[column][row]).to eq(disc)
  end

  def new_board
    Board.new(max_column, max_row, disc_to_win)
  end

end