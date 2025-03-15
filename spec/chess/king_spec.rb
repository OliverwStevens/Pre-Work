require_relative "../../Ruby/chess/lib/pieces/king"
require_relative "../../Ruby/chess/lib/pieces/rook"

RSpec.describe King do
  describe "#initialize" do
    it "creates a white king with correct icon" do
      king = King.new("white", [4, 0])
      expect(king.color).to eq("white")
      expect(king.icon).to eq("♚ ")
      expect(king.coords).to eq([4, 0])
      expect(king.has_moved).to be false
    end

    it "creates a black king with correct icon" do
      king = King.new("black", [4, 7])
      expect(king.color).to eq("black")
      expect(king.icon).to eq("♔ ")
      expect(king.coords).to eq([4, 7])
      expect(king.has_moved).to be false
    end
  end

  describe "#generate_valid_moves" do
    let(:white_king) { King.new("white", [4, 4]) }
    let(:black_king) { King.new("black", [0, 0]) }

    context "on an empty board" do
      it "returns all eight possible moves for a king in the center" do
        # Mock empty board
        pieces = [white_king]

        expected_moves = [
          [4, 5], [4, 3], [5, 4], [3, 4],  # Horizontal & Vertical
          [5, 5], [5, 3], [3, 5], [3, 3]   # Diagonal
        ]

        # Stub the danger squares method to return empty array (no threats)
        allow(white_king).to receive(:get_danger_squares).and_return([])

        valid_moves = white_king.generate_valid_moves(pieces)
        expect(valid_moves).to match_array(expected_moves)
      end

      it "returns fewer moves for a king in the corner" do
        pieces = [black_king]

        expected_moves = [
          [0, 1], [1, 0], [1, 1] # Only three moves possible from corner
        ]

        allow(black_king).to receive(:get_danger_squares).and_return([])

        valid_moves = black_king.generate_valid_moves(pieces)
        expect(valid_moves).to match_array(expected_moves)
      end
    end

    context "with friendly pieces" do
      it "cannot move to squares occupied by friendly pieces" do
        white_pawn1 = double("Piece", color: "white", coords: [4, 5])
        white_pawn2 = double("Piece", color: "white", coords: [5, 4])

        pieces = [white_king, white_pawn1, white_pawn2]

        expected_moves = [
          [4, 3], [3, 4], # Horizontal & Vertical (minus blocked)
          [5, 5], [5, 3], [3, 5], [3, 3] # Diagonal (all available)
        ]

        # Stub find_piece_at_position to simulate pieces on the board
        allow(white_king).to receive(:find_piece_at_position) do |_, position|
          pieces.find { |p| p.coords == position }
        end

        allow(white_king).to receive(:get_danger_squares).and_return([])

        valid_moves = white_king.generate_valid_moves(pieces)
        expect(valid_moves).to match_array(expected_moves)
      end
    end

    context "with enemy pieces" do
      it "can capture enemy pieces" do
        black_pawn = double("Piece", color: "black", coords: [5, 5])

        pieces = [white_king, black_pawn]

        # Stub find_piece_at_position to simulate pieces on the board
        allow(white_king).to receive(:find_piece_at_position) do |_, position|
          pieces.find { |p| p.coords == position }
        end

        allow(white_king).to receive(:get_danger_squares).and_return([])

        valid_moves = white_king.generate_valid_moves(pieces)
        expect(valid_moves).to include([5, 5]) # Should be able to capture the black pawn
      end
    end

    context "with danger squares (check avoidance)" do
      it "cannot move to squares that are under attack" do
        pieces = [white_king]

        # Simulate these squares being under attack
        danger_squares = [[4, 5], [5, 4], [5, 5]]
        allow(white_king).to receive(:get_danger_squares).and_return(danger_squares)

        expected_safe_moves = [
          [4, 3], [3, 4], # Safe horizontal & vertical
          [5, 3], [3, 5], [3, 3] # Safe diagonal
        ]

        valid_moves = white_king.generate_valid_moves(pieces)
        expect(valid_moves).to match_array(expected_safe_moves)
        expect(valid_moves).not_to include(*danger_squares)
      end
    end
  end

  describe "#in_check?" do
    let(:white_king) { King.new("white", [4, 0]) }

    it "returns true when king is under attack" do
      # Stub the danger squares to include king's position
      allow(white_king).to receive(:get_danger_squares).and_return([[4, 0], [3, 0]])

      expect(white_king.in_check?([])).to be true
    end

    it "returns false when king is not under attack" do
      # Stub the danger squares to not include king's position
      allow(white_king).to receive(:get_danger_squares).and_return([[3, 0], [5, 0]])

      expect(white_king.in_check?([])).to be false
    end
  end

  describe "castling" do
    let(:white_king) { King.new("white", [4, 0]) }
    let(:white_kingside_rook) { Rook.new("white", [7, 0]) }
    let(:white_queenside_rook) { Rook.new("white", [0, 0]) }
    let(:pieces) { [white_king, white_kingside_rook, white_queenside_rook] }

    context "#get_castling_moves" do
      before do
        # Stub methods for castling checks
        allow(white_king).to receive(:in_check?).and_return(false)
        allow(white_king).to receive(:find_piece_at_position) do |_, position|
          pieces.find { |p| p.coords == position }
        end
      end

      it "returns both castling moves when conditions are met" do
        # Empty path and no check
        allow(white_king).to receive(:can_castle_kingside?).and_return(true)
        allow(white_king).to receive(:can_castle_queenside?).and_return(true)

        castling_moves = white_king.get_castling_moves(pieces)
        expect(castling_moves).to match_array([[0, 6], [0, 2]])
      end

      it "returns no castling moves if king has moved" do
        white_king.has_moved = true
        castling_moves = white_king.get_castling_moves(pieces)
        expect(castling_moves).to be_empty
      end

      it "returns no castling moves if king is in check" do
        allow(white_king).to receive(:in_check?).and_return(true)
        castling_moves = white_king.get_castling_moves(pieces)
        expect(castling_moves).to be_empty
      end
    end

    context "#can_castle_kingside?" do
      before do
        allow(white_king).to receive(:find_piece_at_position) do |_, position|
          pieces.find { |p| p.coords == position }
        end
        allow(white_king).to receive(:get_danger_squares).and_return([])
      end

      it "returns true when all conditions are met" do
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 5]).and_return(nil)
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 6]).and_return(nil)

        expect(white_king.can_castle_kingside?(pieces, white_kingside_rook)).to be true
      end

      it "returns false if the rook has moved" do
        white_kingside_rook.has_moved = true
        expect(white_king.can_castle_kingside?(pieces, white_kingside_rook)).to be false
      end

      it "returns false if there are pieces between king and rook" do
        blocking_piece = double("Piece", color: "white", coords: [0, 5])
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 5]).and_return(blocking_piece)
        expect(white_king.can_castle_kingside?(pieces, white_kingside_rook)).to be false
      end

      it "returns false if king would move through check" do
        allow(white_king).to receive(:get_danger_squares).and_return([[0, 5]])
        expect(white_king.can_castle_kingside?(pieces, white_kingside_rook)).to be false
      end
    end

    context "#can_castle_queenside?" do
      before do
        allow(white_king).to receive(:find_piece_at_position) do |_, position|
          pieces.find { |p| p.coords == position }
        end
        allow(white_king).to receive(:get_danger_squares).and_return([])
      end

      it "returns true when all conditions are met" do
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 1]).and_return(nil)
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 2]).and_return(nil)
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 3]).and_return(nil)

        expect(white_king.can_castle_queenside?(pieces, white_queenside_rook)).to be true
      end

      it "returns false if the rook has moved" do
        white_queenside_rook.has_moved = true
        expect(white_king.can_castle_queenside?(pieces, white_queenside_rook)).to be false
      end

      it "returns false if there are pieces between king and rook" do
        blocking_piece = double("Piece", color: "white", coords: [0, 3])
        allow(white_king).to receive(:find_piece_at_position).with(pieces, [0, 3]).and_return(blocking_piece)

        expect(white_king.can_castle_queenside?(pieces, white_queenside_rook)).to be false
      end

      it "returns false if king would move through check" do
        allow(white_king).to receive(:get_danger_squares).and_return([[0, 3]])
        expect(white_king.can_castle_queenside?(pieces, white_queenside_rook)).to be false
      end
    end

    context "#perform_castling" do
      it "correctly moves the king and rook for kingside castling" do
        white_king.perform_castling([0, 6], pieces)

        expect(white_king.coords).to eq([0, 6])
        expect(white_king.has_moved).to be true
        expect(white_kingside_rook.coords).to eq([0, 5])
        expect(white_kingside_rook.has_moved).to be true
      end

      it "correctly moves the king and rook for queenside castling" do
        white_king.perform_castling([0, 2], pieces)

        expect(white_king.coords).to eq([0, 2])
        expect(white_king.has_moved).to be true
        expect(white_queenside_rook.coords).to eq([0, 3])
        expect(white_queenside_rook.has_moved).to be true
      end
    end
  end

  describe "#get_danger_squares" do
    let(:white_king) { King.new("white", [4, 4]) }
    let(:black_king) { King.new("black", [0, 0]) }

    it "collects all squares threatened by enemy pieces" do
      black_rook = double("Rook", color: "black", is_a?: false)
      black_bishop = double("Bishop", color: "black", is_a?: false)
      white_pawn = double("Pawn", color: "white", is_a?: false)

      # Simulate moves from enemy pieces
      allow(black_rook).to receive(:generate_valid_moves).and_return([[4, 0], [4, 1]])
      allow(black_bishop).to receive(:generate_valid_moves).and_return([[2, 2], [3, 3]])
      allow(white_pawn).to receive(:generate_valid_moves).and_return([[1, 1], [2, 1]])

      pieces = [white_king, black_king, black_rook, black_bishop, white_pawn]

      # We expect danger squares from black pieces only
      expected_danger = [[4, 0], [4, 1], [2, 2], [3, 3]]

      # For the black king, we use a special method to prevent recursion
      allow(black_king).to receive(:is_a?).with(King).and_return(true)
      allow(black_king).to receive(:generate_king_danger_squares).and_return([[1, 0], [1, 1], [0, 1]])

      danger_squares = white_king.get_danger_squares(pieces, "white")

      # Check that all expected squares are included and each appears only once
      expect(danger_squares).to match_array(expected_danger + [[1, 0], [1, 1], [0, 1]])
    end
  end

  describe "#generate_king_danger_squares" do
    it "returns all adjacent squares for a king" do
      king = King.new("black", [4, 4])

      expected_squares = [
        [4, 5], [4, 3], [5, 4], [3, 4],  # Horizontal & Vertical
        [5, 5], [5, 3], [3, 5], [3, 3]   # Diagonal
      ]

      danger_squares = king.generate_king_danger_squares
      expect(danger_squares).to match_array(expected_squares)
    end

    it "only returns valid board squares for a king at the edge" do
      king = King.new("black", [0, 0])

      expected_squares = [
        [0, 1], [1, 0], [1, 1] # Only three valid moves from corner
      ]

      danger_squares = king.generate_king_danger_squares
      expect(danger_squares).to match_array(expected_squares)
    end
  end
end
