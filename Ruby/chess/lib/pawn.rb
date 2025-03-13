require_relative "piece"
class Pawn < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♙" : "♟"
    super(icon, color, coords)
  end
end
