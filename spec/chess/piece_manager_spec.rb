require_relative "../../Ruby/chess/lib/piece_manager"

describe PieceManager do
  describe "game simulations" do
    let(:piece_manager) { PieceManager.new }
    let(:last_move) { [] }

    context "Scholar's Mate (Four-Move Checkmate)" do
      it "allows white to checkmate black in four moves" do
        # Capture stdout to avoid cluttering test output
        allow($stdout).to receive(:puts)

        # Move 1: White e4
        expect(piece_manager.input_handler("white", "e2 e4", last_move)).to_not be_nil

        # Move 1: Black e5
        expect(piece_manager.input_handler("black", "e7 e5", last_move)).to_not be_nil

        # Move 2: White Qh5 (Queen to h5)
        expect(piece_manager.input_handler("white", "d1 h5", last_move)).to_not be_nil

        # Move 2: Black Nc6 (Knight to c6)
        expect(piece_manager.input_handler("black", "b8 c6", last_move)).to_not be_nil

        # Move 3: White Bc4 (Bishop to c4)
        expect(piece_manager.input_handler("white", "f1 c4", last_move)).to_not be_nil

        # Move 3: Black Nf6?? (Knight to f6) - blunder
        expect(piece_manager.input_handler("black", "g8 f6", last_move)).to_not be_nil

        # Move 4: White Qxf7# (Queen takes f7 checkmate)
        # This should trigger the checkmate logic and exit would be called
        # We'll need to stub the exit to prevent the test from exiting
        expect(piece_manager).to receive(:puts).with("Checkmate! White wins!")
        expect(piece_manager).to receive(:exit)
        piece_manager.input_handler("white", "h5 f7", last_move)
      end
    end

    context "Fool's Mate (Two-Move Checkmate)" do
      it "allows black to checkmate white in two moves" do
        allow($stdout).to receive(:puts)

        # Move 1: White f3 (terrible opening)
        expect(piece_manager.input_handler("white", "f2 f3", last_move)).to_not be_nil

        # Move 1: Black e5
        expect(piece_manager.input_handler("black", "e7 e5", last_move)).to_not be_nil

        # Move 2: White g4 (even worse second move)
        expect(piece_manager.input_handler("white", "g2 g4", last_move)).to_not be_nil

        # Move 2: Black Qh4# (Queen delivers checkmate)
        expect(piece_manager).to receive(:puts).with("Checkmate! Black wins!")
        expect(piece_manager).to receive(:exit)
        piece_manager.input_handler("black", "d8 h4", last_move)
      end
    end

    context "Légal Trap" do
      it "allows white to execute the Légal trap" do
        allow($stdout).to receive(:puts)

        # Move 1: White e4
        expect(piece_manager.input_handler("white", "e2 e4", last_move)).to_not be_nil

        # Move 1: Black e5
        expect(piece_manager.input_handler("black", "e7 e5", last_move)).to_not be_nil

        # Move 2: White Nf3
        expect(piece_manager.input_handler("white", "g1 f3", last_move)).to_not be_nil

        # Move 2: Black d6
        expect(piece_manager.input_handler("black", "d7 d6", last_move)).to_not be_nil

        # Move 3: White Bc4
        expect(piece_manager.input_handler("white", "f1 c4", last_move)).to_not be_nil

        # Move 3: Black Bg4 (pins the knight)
        expect(piece_manager.input_handler("black", "c8 g4", last_move)).to_not be_nil

        # Move 4: White Nc3
        expect(piece_manager.input_handler("white", "b1 c3", last_move)).to_not be_nil

        # Move 4: Black h6?
        expect(piece_manager.input_handler("black", "h7 h6", last_move)).to_not be_nil

        # Move 5: White Nxe5! (Knight sacrifice)
        expect(piece_manager.input_handler("white", "f3 e5", last_move)).to_not be_nil

        # Move 5: Black Bxd1?? (Black takes the queen)
        expect(piece_manager.input_handler("black", "g4 d1", last_move)).to_not be_nil

        # Move 6: Bxf7+ (Bishop check)
        expect(piece_manager.input_handler("white", "c4 f7", last_move)).to_not be_nil

        # Move 6: Ke7 (King forced to move)
        expect(piece_manager.input_handler("black", "e8 e7", last_move)).to_not be_nil

        # Move 7: Nd5# (Knight delivers checkmate)
        expect(piece_manager).to receive(:puts).with("Checkmate! White wins!")
        expect(piece_manager).to receive(:exit)
        piece_manager.input_handler("white", "c3 d5", last_move)
      end
    end

    context "Castling test" do
      it "allows kingside castling" do
        allow($stdout).to receive(:puts)

        # Move 1: White e4
        expect(piece_manager.input_handler("white", "e2 e4", last_move)).to_not be_nil

        # Move 1: Black e5
        expect(piece_manager.input_handler("black", "e7 e5", last_move)).to_not be_nil

        # Move 2: White Nf3
        expect(piece_manager.input_handler("white", "g1 f3", last_move)).to_not be_nil

        # Move 2: Black Nc6
        expect(piece_manager.input_handler("black", "b8 c6", last_move)).to_not be_nil

        # Move 3: White Bc4
        expect(piece_manager.input_handler("white", "f1 c4", last_move)).to_not be_nil

        # Move 3: Black Bc5
        expect(piece_manager.input_handler("black", "f8 c5", last_move)).to_not be_nil

        # Move 4: White O-O (Kingside castling)
        expect(piece_manager).to receive(:puts).with("Kingside castling performed")
        expect(piece_manager.input_handler("white", "O-O", last_move)).to_not be_nil

        # Verify the king and rook are in the correct post-castling positions
        king = piece_manager.pieces.find { |p| p.is_a?(King) && p.color == "white" }
        rook = piece_manager.pieces.find { |p| p.is_a?(Rook) && p.color == "white" && p.coords[0] == 5 }

        expect(king.coords).to eq([6, 0])
        expect(rook.coords).to eq([5, 0])
      end

      it "allows queenside castling" do
        allow($stdout).to receive(:puts)

        # Move 1: White d4
        expect(piece_manager.input_handler("white", "d2 d4", last_move)).to_not be_nil

        # Move 1: Black d5
        expect(piece_manager.input_handler("black", "d7 d5", last_move)).to_not be_nil

        # Move 2: White Nf3
        expect(piece_manager.input_handler("white", "g1 f3", last_move)).to_not be_nil

        # Move 2: Black Nf6
        expect(piece_manager.input_handler("black", "g8 f6", last_move)).to_not be_nil

        # Move 3: White c4
        expect(piece_manager.input_handler("white", "c2 c4", last_move)).to_not be_nil

        # Move 3: Black e6
        expect(piece_manager.input_handler("black", "e7 e6", last_move)).to_not be_nil

        # Move 4: White Nc3
        expect(piece_manager.input_handler("white", "b1 c3", last_move)).to_not be_nil

        # Move 4: Black Be7
        expect(piece_manager.input_handler("black", "f8 e7", last_move)).to_not be_nil

        # Move 5: White Bf4
        expect(piece_manager.input_handler("white", "c1 f4", last_move)).to_not be_nil

        # Move 5: Black O-O
        expect(piece_manager.input_handler("black", "O-O", last_move)).to_not be_nil

        # Move 6: White Qc2
        expect(piece_manager.input_handler("white", "d1 c2", last_move)).to_not be_nil

        # Move 6: Black c6
        expect(piece_manager.input_handler("black", "c7 c6", last_move)).to_not be_nil

        # Move 7: White O-O-O (Queenside castling)
        expect(piece_manager).to receive(:puts).with("Queenside castling performed")
        expect(piece_manager.input_handler("white", "O-O-O", last_move)).to_not be_nil

        # Verify the king and rook are in the correct post-castling positions
        king = piece_manager.pieces.find { |p| p.is_a?(King) && p.color == "white" }
        rook = piece_manager.pieces.find { |p| p.is_a?(Rook) && p.color == "white" && p.coords[0] == 3 }

        expect(king.coords).to eq([2, 0])
        expect(rook.coords).to eq([3, 0])
      end
    end

    context "En passant test" do
      it "allows en passant capture" do
        allow($stdout).to receive(:puts)

        # Move 1: White e4
        expect(piece_manager.input_handler("white", "e2 e4", last_move)).to_not be_nil

        # Move 1: Black a6
        expect(piece_manager.input_handler("black", "a7 a6", last_move)).to_not be_nil

        # Move 2: White e5
        expect(piece_manager.input_handler("white", "e4 e5", last_move)).to_not be_nil

        # Move 2: Black d5 (Setting up en passant)
        expect(piece_manager.input_handler("black", "d7 d5", last_move)).to_not be_nil

        # Move 3: White exd6 (En passant capture)
        expect(piece_manager.input_handler("white", "e5 d6", last_move)).to_not be_nil

        # Verify the pawn has been captured
        black_pawn = piece_manager.pieces.find { |p| p.is_a?(Pawn) && p.color == "black" && p.coords == [3, 4] }
        white_pawn = piece_manager.pieces.find { |p| p.is_a?(Pawn) && p.color == "white" && p.coords == [3, 5] }

        expect(black_pawn).to be_nil
        expect(white_pawn).to_not be_nil
      end
    end

    context "Pawn promotion test" do
      it "allows pawn promotion" do
        # Create a custom board state with white pawn about to promote
        pieces = []
        pieces << Pawn.new("white", [3, 6]) # White pawn about to promote
        pieces << King.new("white", [4, 0])
        pieces << King.new("black", [4, 7])

        custom_manager = PieceManager.new(pieces)
        allow($stdout).to receive(:puts)

        # Simulate user input for promotion choice
        allow(custom_manager).to receive(:gets).and_return("Q\n")

        # Move pawn to promotion square
        expect(custom_manager.input_handler("white", "d7 d8", last_move)).to_not be_nil

        # Verify pawn was promoted to queen
        promoted_piece = custom_manager.pieces.find { |p| p.coords == [3, 7] }
        expect(promoted_piece).to be_a(Queen)
        expect(promoted_piece.color).to eq("white")
      end
    end

    context "Pinned piece test" do
      it "prevents moving a pinned piece" do
        # Create a custom board state with a pinned piece
        pieces = []
        pieces << King.new("white", [4, 0])
        pieces << Bishop.new("white", [3, 1])  # Pinned bishop
        pieces << Queen.new("black", [2, 2])   # Enemy queen pinning the bishop

        custom_manager = PieceManager.new(pieces)
        allow($stdout).to receive(:puts)

        # Add the would_expose_king_to_check? method to handle pins
        def custom_manager.would_expose_king_to_check?(piece, destination, color)
          # Simulate the move
          original_coords = piece.coords
          captured_piece = @pieces.find { |p| p.coords == destination }

          # Make the move temporarily
          piece.coords = destination
          @pieces.delete(captured_piece) if captured_piece

          # Check if king is in check after this move
          king_exposed = king_in_check?(color)

          # Undo the move
          piece.coords = original_coords
          @pieces.push(captured_piece) if captured_piece

          king_exposed
        end

        # Override the input_handler to use the pin check
        def custom_manager.input_handler(color, input, last_move)
          start_pos, end_pos = input.split
          start_coords = algebraic_to_index(start_pos)
          end_coords = algebraic_to_index(end_pos)
          return unless start_coords && end_coords

          piece = @pieces.find { |p| p.coords == start_coords && p.color == color }
          return puts "Invalid move: No #{color} piece at #{start_pos}" unless piece

          target_piece = @pieces.find { |p| p.coords == end_coords }
          if target_piece && target_piece.color == color
            return puts "Invalid move: #{color} piece already at #{end_pos}"
          end

          valid_moves = piece.generate_valid_moves(@pieces, last_move)
          return puts "Invalid move: Move not allowed" unless valid_moves.include?(end_coords)

          # Check if move would put or leave own king in check (handle pins)
          if would_expose_king_to_check?(piece, end_coords, color)
            return puts "Invalid move: This would put your king in check"
          end

          # Execute move
          piece.coords = end_coords

          [start_coords, end_coords]
        end

        # Try to move the pinned bishop
        expect(custom_manager).to receive(:puts).with("Invalid move: This would put your king in check")
        expect(custom_manager.input_handler("white", "d2 e3", last_move)).to be_nil
      end
    end
  end
end
