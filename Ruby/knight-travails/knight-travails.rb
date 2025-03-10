def knight_moves(start)
  chess_squares = (0..7).flat_map { |x| (0..7).map { |y| [x, y] } }

  queue = []
  x, y = start

  moves = [
    [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y - 1],
    [x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2]
  ]

  legal_moves = moves.select { |move| chess_squares.include?(move) }

  # for each legal move call the function again
end

p knight_moves([0, 0])
