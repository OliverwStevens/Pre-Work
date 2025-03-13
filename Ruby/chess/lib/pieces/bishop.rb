require_relative "piece"
class Bishop < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♝ " : "♗ "
    super(icon, color, coords)
  end
end
