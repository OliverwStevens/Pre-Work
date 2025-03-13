require_relative "piece"
class King < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♚" : "♔"
    super(icon, color, coords)
  end
end
