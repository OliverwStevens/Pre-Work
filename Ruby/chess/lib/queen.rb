require_relative "piece"
class Queen < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♛" : "♕"
    super(icon, color, coords)
  end
end
