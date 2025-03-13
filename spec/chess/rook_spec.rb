require_relative "../../Ruby/chess/lib/pieces/rook"

RSpec.describe Rook do
  let(:white_rook) { Rook.new("white", [4, 3]) }
  let(:black_pawn) { double("Piece", color: "black", coords: [4, 5]) }
  let(:white_pawn) { double("Piece", color: "white", coords: [4, 1]) }

  let(:pieces) { [white_rook, black_pawn, white_pawn] }

  describe "#generate_valid_moves" do
    it "calculates valid vertical and horizontal moves and excludes blocked moves" do
      valid_moves = white_rook.generate_valid_moves(pieces)

      expected_moves = [
        [4, 2], [4, 4], [4, 5],
        [0, 3], [1, 3], [2, 3], [3, 3], [5, 3], [6, 3], [7, 3]
      ]

      expect(valid_moves).to match_array(expected_moves)
    end

    it "blocks moves when a piece of the same color is in the way" do
      valid_moves = white_rook.generate_valid_moves(pieces)
      expect(valid_moves).not_to include([4, 1])
    end

    it "allows attack on opponent pieces" do
      valid_moves = white_rook.generate_valid_moves(pieces)
      expect(valid_moves).to include([4, 5])
    end
  end
end
