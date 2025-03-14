require_relative "piece"
class Rook < Piece
  include PieceMovement

  def initialize(color, coords)
    icon = color == "white" ? "♜ " : "♖ "
    super(icon, color, coords)
  end

  # rook moves
  def generate_valid_moves(pieces)
    rook_movement(pieces)
  end

  def find_piece_at_position(pieces, position)
    pieces.find { |piece| piece.coords == position }
  end
end
