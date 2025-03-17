require_relative "piece"
class Rook < Piece
  attr_accessor :has_moved

  include PieceMovement

  def initialize(color, coords)
    icon = color == "white" ? "♜ " : "♖ "
    super(icon, color, coords)
    @has_moved = false
  end

  # rook moves
  def generate_valid_moves(pieces, _last_move = nil)
    rook_movement(pieces)
  end

  def find_piece_at_position(pieces, position)
    pieces.find { |piece| piece.coords == position }
  end
end
