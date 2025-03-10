CHESS_SQUARES = (0..7).flat_map { |x| (0..7).map { |y| [x, y] } }

def knight_moves(start, stop)
  return [start] if start == stop

  queue = [[start]]
  visited = Set.new([start])

  moves = [
    [2, 1], [2, -1], [-2, 1], [-2, -1],
    [1, 2], [1, -2], [-1, 2], [-1, -2]
  ]

  until queue.empty?
    path = queue.shift
    current = path.last

    return path if current == stop

    x, y = current
    moves.each do |dx, dy|
      next_move = [x + dx, y + dy]

      if next_move.all? { |coordinate| coordinate.between?(0, 7) } && !visited.include?(next_move)
        visited.add(next_move)
        queue.push(path + [next_move])
      end
    end
  end

  nil
end

moves = knight_moves([4, 3], [7, 3])
puts "You made it in #{moves.length - 1} moves! Here is your path: #{moves.inspect}"
