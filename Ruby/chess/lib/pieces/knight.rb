require_relative "piece"
class Knight < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♞ " : "♘ "
    super(icon, color, coords)
  end
end
