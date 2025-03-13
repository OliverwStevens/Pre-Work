require_relative "piece"
class Rook < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♜ " : "♖ "
    super(icon, color, coords)
  end
end
