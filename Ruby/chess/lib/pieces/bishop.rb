require_relative "piece"
class Bishop < Piece
  include PieceMovement

  def initialize(color, coords)
    icon = color == "white" ? "♝ " : "♗ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces)
    bishop_movement(pieces)
  end
end
