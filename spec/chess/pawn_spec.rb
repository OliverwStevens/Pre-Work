require_relative "../../Ruby/chess/lib/pieces/pawn"
RSpec.describe Pawn do
  let(:white_pawn) { Pawn.new("white", [4, 1]) }
  let(:black_pawn) { Pawn.new("black", [3, 6]) }

  describe "#initialize" do
    it "assigns the correct icon for a white pawn" do
      expect(white_pawn.icon).to eq("♟ ")
    end

    it "assigns the correct icon for a black pawn" do
      expect(black_pawn.icon).to eq("♙ ")
    end
  end

  describe "#generate_valid_moves" do
    let(:pieces) { [] }

    context "when the path is clear" do
      it "allows a white pawn to move forward one space" do
        expect(white_pawn.generate_valid_moves(pieces)).to include([4, 2])
      end

      it "allows a black pawn to move forward one space" do
        expect(black_pawn.generate_valid_moves(pieces)).to include([3, 5])
      end

      it "allows a white pawn to move forward two spaces from the starting position" do
        expect(white_pawn.generate_valid_moves(pieces)).to include([4, 3])
      end

      it "allows a black pawn to move forward two spaces from the starting position" do
        expect(black_pawn.generate_valid_moves(pieces)).to include([3, 4])
      end
    end

    context "when a piece is blocking the forward move" do
      let(:blocking_piece) { double("Piece", color: "white", coords: [4, 2]) } # Enemy piece directly in front

      it "prevents a white pawn from moving forward" do
        pieces << blocking_piece
        expect(white_pawn.generate_valid_moves(pieces)).not_to include([4, 2])
      end
    end

    context "when an enemy piece is diagonally in front" do
      let(:enemy_piece_left) { double("Piece", color: "black", coords: [3, 2]) }
      let(:enemy_piece_right) { double("Piece", color: "black", coords: [5, 2]) }

      it "allows white pawn to capture diagonally left" do
        pieces << enemy_piece_left
        expect(white_pawn.generate_valid_moves(pieces)).to include([3, 2])
      end

      it "allows white pawn to capture diagonally right" do
        pieces << enemy_piece_right
        expect(white_pawn.generate_valid_moves(pieces)).to include([5, 2])
      end
    end

    context "when an ally piece is diagonally in front" do
      let(:ally_piece) { double("Piece", color: "white", coords: [3, 2]) }

      it "prevents capturing an ally piece" do
        pieces << ally_piece
        expect(white_pawn.generate_valid_moves(pieces)).not_to include([3, 2])
      end
    end
  end
end
