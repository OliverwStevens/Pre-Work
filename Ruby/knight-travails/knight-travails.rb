CHESS_SQUARES = (0..7).flat_map { |x| (0..7).map { |y| [x, y] } }

def knight_moves(start)
  x, y = start

  moves = [
    [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y - 1],
    [x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2]
  ]

  legal_moves = moves.select { |move| CHESS_SQUARES.include?(move) }
end

p knight_moves([0, 0])
