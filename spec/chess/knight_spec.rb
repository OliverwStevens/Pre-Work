require_relative "../../Ruby/chess/lib/pieces/knight"

RSpec.describe Knight do
  let(:white_knight) { Knight.new("white", [3, 3]) } # White knight in the center
  let(:black_knight) { Knight.new("black", [4, 4]) } # Black knight in the center

  describe "#initialize" do
    it "assigns the correct icon for a white knight" do
      expect(white_knight.icon).to eq("♞ ")
    end

    it "assigns the correct icon for a black knight" do
      expect(black_knight.icon).to eq("♘ ")
    end
  end

  describe "#generate_valid_moves" do
    let(:pieces) { [] } # Empty board

    context "when the board is empty" do
      it "allows the knight to move in all valid L-shapes" do
        expected_moves = [
          [1, 2], [1, 4], [2, 1], [2, 5],
          [4, 1], [4, 5], [5, 2], [5, 4]
        ]
        expect(white_knight.generate_valid_moves(pieces)).to match_array(expected_moves)
      end
    end

    context "when the knight is near the edge of the board" do
      let(:edge_knight) { Knight.new("white", [7, 7]) } # Placed in top-right corner

      it "does not generate moves that go off the board" do
        expected_moves = [[5, 6], [6, 5]]
        expect(edge_knight.generate_valid_moves(pieces)).to match_array(expected_moves)
      end
    end

    context "when an enemy piece is in a valid move position" do
      let(:enemy_piece) { double("Piece", color: "black", coords: [5, 4]) }

      it "allows capturing the enemy piece" do
        pieces << enemy_piece
        expect(white_knight.generate_valid_moves(pieces)).to include([5, 4])
      end
    end

    context "when an ally piece is in a valid move position" do
      let(:ally_piece) { double("Piece", color: "white", coords: [5, 4]) }

      it "does not allow moving onto an ally piece" do
        pieces << ally_piece
        expect(white_knight.generate_valid_moves(pieces)).not_to include([5, 4])
      end
    end
  end
end
