require_relative "../../Ruby/connect-four/lib/board" # Adjust path as needed

describe Board do
  describe "#play_piece" do
    it "plays a piece, return true if it can be played or false if not" do
      board = Board.new
      expect(board.play_piece("x", 0)).to eql(true)
    end
  end
end
