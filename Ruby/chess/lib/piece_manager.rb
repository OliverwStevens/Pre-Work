require_relative "pawn"
require_relative "rook"
class Piece_Manager
  pieces = []
  8.times do |num|
    pawn = Pawn.new("white", [num, 1])
    pieces.push(pawn)
  end
  8.times do |num|
    pawn = Pawn.new("black", [num, 6])
    pieces.push(pawn)
  end
  pieces.push(Rook.new("white", [0, 0]))
  pieces.push(Rook.new("white", [0, 7]))
  pieces.push(Rook.new("black", [7, 0]))
  pieces.push(Rook.new("black", [7, 7]))

  pieces.each { |piece| p [piece.color, piece.icon, piece.coords] }
end
