require_relative "pawn"
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
  pieces.each { |piece| p [piece.color, piece.coords] }
end
