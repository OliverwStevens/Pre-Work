require_relative "../../Ruby/connect-four/lib/board"

describe Board do
  describe "#play_piece" do
    it "places a piece in the correct column and returns true" do
      board = Board.new
      expect(board.play_piece("x", 0)).to eql(true)
      expect(board.instance_variable_get(:@grid)[5][0]).to eql("x")
    end

    it "returns false if column is full" do
      board = Board.new
      6.times { board.play_piece("x", 0) }
      expect(board.play_piece("x", 0)).to eql(false)
    end
  end

  describe "#horizontal_win?" do
    it "returns false when the board is empty" do
      board = Board.new
      expect(board.horizontal_win?("x")).to eql(false)
    end

    it "returns false if pieces are placed but not forming a line" do
      board = Board.new
      board.play_piece("x", 0)
      board.play_piece("x", 2)
      board.play_piece("x", 3)

      expect(board.horizontal_win?("x")).to eql(false)
    end

    it "returns true when there are 4 in a row horizontally in any row" do
      board = Board.new
      board.play_piece("x", 0)
      board.play_piece("x", 1)
      board.play_piece("x", 2)
      board.play_piece("x", 3)

      expect(board.horizontal_win?("x")).to eql(true)
    end

    it "detects horizontal win at the middle of the board" do
      board = Board.new
      board.play_piece("x", 2)
      board.play_piece("x", 3)
      board.play_piece("x", 4)
      board.play_piece("x", 5)

      expect(board.horizontal_win?("x")).to eql(true)
    end
  end
end
