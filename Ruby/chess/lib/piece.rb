class Piece
  attr_accessor :icon, :color, :coords

  def initialize(icon, color, coords)
    @icon = icon
    @color = color
    @coords = coords
  end

  # def legal_moves
end
