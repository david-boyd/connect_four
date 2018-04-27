RSpec.describe ConnectFour do
  let(:board) {ConnectFour.build.board}

  it "create new game, with 7 columns and 6 rows " do
    expect(board).to_not be_nil
    expect(board.data.length).to eq(6)
    expect(board.data[0].length).to eq(7) 
  end
end