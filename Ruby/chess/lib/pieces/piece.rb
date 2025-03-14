class Piece
  attr_accessor :icon, :color, :coords

  def initialize(icon, color, coords)
    @icon = icon
    @color = color
    @coords = coords
  end

  # def legal_moves
  def generate_valid_moves(pieces)
    puts "Hello, your legal moves would appear here"
    nil
  end

  def find_piece_at_position(pieces, position)
    pieces.find { |piece| piece.coords == position }
  end
end
