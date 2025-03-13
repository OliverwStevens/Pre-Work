require_relative "piece"
class Rook < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♜ " : "♖ "
    super(icon, color, coords)
  end

  # rook moves
  def generate_valid_moves(pieces)
    moves = []
    row = coords[1]
    col = coords[0]

    # Check upward moves (decreasing row)
    (row - 1).downto(0) do |r|
      move = [col, r]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check downward moves (increasing row)
    (row + 1).upto(7) do |r|
      move = [col, r]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check leftward moves (decreasing column)
    (col - 1).downto(0) do |c|
      move = [c, row]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check rightward moves (increasing column)
    (col + 1).upto(7) do |c|
      move = [c, row]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    moves
  end

  def find_piece_at_position(pieces, position)
    pieces.find { |piece| piece.coords == position }
  end
end
