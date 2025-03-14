require_relative "../../Ruby/chess/lib/pieces/bishop"
RSpec.describe Bishop do
  let(:bishop) { Bishop.new("white", [3, 3]) }
  let(:pieces) { [] }

  context "when the board is empty" do
    it "moves diagonally in all four directions" do
      expected_moves = [
        [2, 2], [1, 1], [0, 0], # Top-left
        [4, 2], [5, 1], [6, 0], # Top-right
        [2, 4], [1, 5], [0, 6], # Bottom-left
        [4, 4], [5, 5], [6, 6], [7, 7] # Bottom-right
      ]
      expect(bishop.generate_valid_moves(pieces)).to match_array(expected_moves)
    end
  end

  context "when there are friendly pieces blocking" do
    let(:pieces) { [double("Piece", color: "white", coords: [1, 5]), double("Piece", color: "white", coords: [5, 1])] }

    it "stops before friendly pieces" do
      expected_moves = [
        [2, 2], [1, 1], [0, 0], # Top-left
        [4, 2], # Stops before (5,1)
        [2, 4], # Stops before (1,5)
        [4, 4], [5, 5], [6, 6], [7, 7] # Bottom-right
      ]
      expect(bishop.generate_valid_moves(pieces)).to match_array(expected_moves)
    end
  end

  context "when there are opponent pieces" do
    let(:pieces) { [double("Piece", color: "black", coords: [2, 4]), double("Piece", color: "black", coords: [5, 1])] }

    it "captures opponent pieces but does not move past them" do
      expected_moves = [
        [2, 2], [1, 1], [0, 0], # Top-left
        [4, 2], [5, 1], # Captures (5,1) and stops
        [2, 4], # Captures (2,4) and stops
        [4, 4], [5, 5], [6, 6], [7, 7] # Bottom-right
      ]
      expect(bishop.generate_valid_moves(pieces)).to match_array(expected_moves)
    end
  end
end
