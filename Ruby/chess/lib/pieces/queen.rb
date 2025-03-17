require_relative "piece"
class Queen < Piece
  include PieceMovement
  def initialize(color, coords)
    icon = color == "white" ? "♛ " : "♕ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces, _last_move = nil)
    rook_movement(pieces) + bishop_movement(pieces)
  end
end
