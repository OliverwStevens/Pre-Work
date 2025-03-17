require_relative "pieces/pawn"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"

class PieceManager
  def initialize(state = nil)
    @pieces = []

    if state.nil?
      add_pieces_to_board
    else

    end
  end

  def add_pieces_to_board
    8.times do |num|
      pawn = Pawn.new("white", [num, 1])
      @pieces.push(pawn)
    end
    8.times do |num|
      pawn = Pawn.new("black", [num, 6])
      @pieces.push(pawn)
    end
    # rooks
    @pieces.push(Rook.new("white", [0, 0]))
    @pieces.push(Rook.new("white", [7, 0]))
    @pieces.push(Rook.new("black", [0, 7]))
    @pieces.push(Rook.new("black", [7, 7]))

    # knights
    @pieces.push(Knight.new("white", [1, 0]))
    @pieces.push(Knight.new("white", [6, 0]))
    @pieces.push(Knight.new("black", [1, 7]))
    @pieces.push(Knight.new("black", [6, 7]))
    # bishops
    @pieces.push(Bishop.new("white", [2, 0]))
    @pieces.push(Bishop.new("white", [5, 0]))
    @pieces.push(Bishop.new("black", [2, 7]))
    @pieces.push(Bishop.new("black", [5, 7]))

    # queens
    @pieces.push(Queen.new("white", [3, 0]))
    @pieces.push(Queen.new("black", [3, 7]))

    # kings
    @pieces.push(King.new("white", [4, 0]))
    @pieces.push(King.new("black", [4, 7]))
  end

  def show_board
    board = Array.new(8) { Array.new(8, ". ") }

    @pieces.each do |piece|
      x, y = piece.coords
      board[y][x] = piece.icon
    end

    puts "  a b c d e f g h"
    board.reverse.each_with_index do |row, index|
      puts "#{8 - index} #{row.join}"
    end
  end

  def input_handler(color, input, last_move)
    # Handle special castling notation
    if %w[O-O 0-0].include?(input)
      return handle_castling(color, "kingside")
    elsif ["O-O-O", "0-0-0"].include?(input)
      return handle_castling(color, "queenside")
    end

    start_pos, end_pos = input.split
    start_coords = algebraic_to_index(start_pos)
    end_coords = algebraic_to_index(end_pos)
    return unless start_coords && end_coords

    piece = @pieces.find { |p| p.coords == start_coords && p.color == color }
    return puts "Invalid move: No #{color} piece at #{start_pos}" unless piece

    target_piece = @pieces.find { |p| p.coords == end_coords }
    return puts "Invalid move: #{color} piece already at #{end_pos}" if target_piece && target_piece.color == color

    valid_moves = piece.generate_valid_moves(@pieces, last_move)
    return puts "Invalid move: Move not allowed" unless valid_moves.include?(end_coords)

    # Handle en passant
    if piece.is_a?(Pawn) && last_move && last_move[0].is_a?(Pawn) && (last_move[1][0] == end_coords[0] && last_move[2][1] == start_coords[1])
      captured_pawn = @pieces.find { |p| p.coords == last_move[2] }
      @pieces.delete(captured_pawn) if captured_pawn
    end

    # Execute move
    piece.coords = end_coords
    piece.has_moved = true if piece.respond_to?(:has_moved=)

    # Track pawns that just moved two squares
    piece.just_moved_two = (start_coords[1] - end_coords[1]).abs == 2 if piece.is_a?(Pawn)

    # Update last move
    last_move.replace([piece, start_coords, end_coords]) # Modify in-place

    # Handle pawn promotion
    if piece.is_a?(Pawn) && [0, 7].include?(end_coords[1])
      puts "Pawn promotion! Choose a piece (Q for Queen, R for Rook, B for Bishop, N for Knight):"
      choice = gets.chomp.upcase

      @pieces.delete(piece)

      new_piece = case choice
                  when "Q" then Queen.new(color, end_coords)
                  when "R" then Rook.new(color, end_coords)
                  when "B" then Bishop.new(color, end_coords)
                  when "N" then Knight.new(color, end_coords)
                  else
                    puts "Invalid choice, defaulting to Queen."
                    Queen.new(color, end_coords)
                  end

      @pieces.push(new_piece)
    end

    # Check for check and checkmate
    opponent_color = color == "white" ? "black" : "white"
    if king_in_check?(opponent_color)
      if checkmate?(opponent_color)
        puts "Checkmate! #{color.capitalize} wins!"
        exit
      else
        puts "#{opponent_color.capitalize} is in check!"
      end
    end

    [start_coords, end_coords]
  end

  def handle_castling(color, side)
    # Find the king
    king = @pieces.find { |p| p.is_a?(King) && p.color == color }
    return puts "Invalid move: King not found" unless king

    # Determine the king's starting and ending position
    row = color == "white" ? 0 : 7
    start_coords = [4, row]

    return puts "Invalid move: King not in starting position" unless king.coords == start_coords
    return puts "Invalid move: King has already moved" if king.has_moved

    return puts "Invalid move: Cannot castle while in check" if king.in_check?(@pieces)

    if side == "kingside"
      # Find the kingside rook
      rook = @pieces.find { |p| p.is_a?(Rook) && p.color == color && p.coords == [7, row] }
      return puts "Invalid move: Kingside rook not found or has moved" unless rook && !rook.has_moved

      return puts "Invalid move: Path not clear for castling" if @pieces.any? do |p|
        [[5, row], [6, row]].include?(p.coords)
      end

      danger_squares = king.get_danger_squares(@pieces, color)
      return puts "Invalid move: Cannot castle through or into check" if danger_squares.include?([5,
                                                                                                  row]) || danger_squares.include?([
                                                                                                                                     6, row
                                                                                                                                   ])

      king.coords = [6, row]
      king.has_moved = true
      rook.coords = [5, row]
      rook.has_moved = true

      puts "Kingside castling performed"
    else
      rook = @pieces.find { |p| p.is_a?(Rook) && p.color == color && p.coords == [0, row] }
      return puts "Invalid move: Queenside rook not found or has moved" unless rook && !rook.has_moved

      return puts "Invalid move: Path not clear for castling" if @pieces.any? do |p|
        [[1, row], [2, row], [3, row]].include?(p.coords)
      end

      danger_squares = king.get_danger_squares(@pieces, color)
      return puts "Invalid move: Cannot castle through or into check" if danger_squares.include?([2,
                                                                                                  row]) || danger_squares.include?([
                                                                                                                                     3, row
                                                                                                                                   ])

      king.coords = [2, row]
      king.has_moved = true
      rook.coords = [3, row]
      rook.has_moved = true

      puts "Queenside castling performed"
    end

    [king.coords, rook.coords]
  end

  def perform_castling(king, end_coords)
    row = end_coords[1]

    if end_coords[0] == 6
      rook = @pieces.find { |p| p.is_a?(Rook) && p.color == king.color && p.coords == [7, row] }
      rook.coords = [5, row]
      rook.has_moved = true
    elsif end_coords[0] == 2
      rook = @pieces.find { |p| p.is_a?(Rook) && p.color == king.color && p.coords == [0, row] }
      rook.coords = [3, row]
      rook.has_moved = true
    end

    king.coords = end_coords
    king.has_moved = true
  end

  def algebraic_to_index(pos)
    return nil if pos.nil?
    return nil unless pos.match?(/^[a-h][1-8]$/)

    file = pos[0].ord - "a".ord
    rank = pos[1].to_i - 1

    [file, rank]
  end

  # utility methods
  def show_current_pieces
    @pieces.each { |piece| p [piece.color, piece.icon, piece.coords] }
  end

  def piece_count
    puts @pieces.length
  end

  def king_in_check?(color)
    king = @pieces.find { |p| p.is_a?(King) && p.color == color }
    return false unless king

    @pieces.any? { |p| p.color != color && p.generate_valid_moves(@pieces).include?(king.coords) }
  end

  def checkmate?(color)
    king = @pieces.find { |p| p.is_a?(King) && p.color == color }
    return false unless king

    # If the king has no legal moves and is in check, it's checkmate
    return true if king_in_check?(color) && no_legal_moves?(color)

    false
  end

  def no_legal_moves?(color)
    @pieces.select { |p| p.color == color }.all? do |piece|
      piece.generate_valid_moves(@pieces).all? do |move|
        # Simulate each move and check if it gets the king out of check
        original_coords = piece.coords
        captured_piece = @pieces.find { |p| p.coords == move }

        piece.coords = move
        @pieces.delete(captured_piece) if captured_piece

        still_in_check = king_in_check?(color)

        # Undo move
        piece.coords = original_coords
        @pieces.push(captured_piece) if captured_piece

        still_in_check
      end
    end
  end
end
