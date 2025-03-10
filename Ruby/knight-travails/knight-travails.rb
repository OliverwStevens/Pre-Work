CHESS_SQUARES = (0..7).flat_map { |x| (0..7).map { |y| [x, y] } }

def knight_moves(start, stop)
  return [start] if start == stop

  queue = [[start]]
  visited = Set.new([start])

  x, y = start
  moves = [
    [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y - 1],
    [x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2]
  ]

  until queue.empty?
    path = queue.shift
    current = path.last

    return path if current == stop

    x, y = current
    moves.each do |dx, dy|
      next_move = [x + dx, y + dy]

      if CHESS_SQUARES.include?(next_move) && !visited.include?(next_move)
        visited.add(next_move)
        queue.push(path + [next_move])
      end
    end
  end

  nil
end

p knight_moves([0, 0], [0, 1])
