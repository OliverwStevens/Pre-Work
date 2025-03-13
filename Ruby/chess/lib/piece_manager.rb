require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
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
  # rooks
  pieces.push(Rook.new("white", [0, 0]))
  pieces.push(Rook.new("white", [7, 0]))
  pieces.push(Rook.new("black", [0, 7]))
  pieces.push(Rook.new("black", [7, 7]))

  # knights
  pieces.push(Knight.new("white", [1, 0]))
  pieces.push(Knight.new("white", [1, 0]))
  pieces.push(Knight.new("black", [6, 7]))
  pieces.push(Knight.new("black", [6, 7]))

  # bishops
  pieces.push(Bishop.new("white", [2, 0]))
  pieces.push(Bishop.new("white", [2, 0]))
  pieces.push(Bishop.new("black", [5, 7]))
  pieces.push(Bishop.new("black", [5, 7]))

  pieces.each { |piece| p [piece.color, piece.icon, piece.coords] }
end
