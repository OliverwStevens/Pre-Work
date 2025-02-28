def main_diagonal(board)
  (0...[board.size, board[0].size].min).map { |i| board[i][i] }
end
def anti_diagonal(board)
  (0...[board.size, board[0].size].min).map { |i| board[i][-i-1] }
end

def rotate_90_clockwise(board)
  board.transpose.map(&:reverse)
end

board = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

p main_diagonal(board)
puts "anti"
p anti_diagonal(board)
puts "rotated"
p rotate_90_clockwise(board)