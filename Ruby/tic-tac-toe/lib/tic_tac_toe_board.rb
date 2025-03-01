module TicTacToeMethods
  def main_diagonal(board)
    (0...[board.size, board[0].size].min).map { |i| board[i][i] }
  end

  def anti_diagonal(board)
    (0...[board.size, board[0].size].min).map { |i| board[i][-i - 1] }
  end

  def rotate_90_clockwise(board)
    board.transpose.map(&:reverse)
  end

  def check_line?(marker, strip)
    strip.any? do |line|
      line.all?(marker)
    end
  end

  def check_if_game_won?(marker, board)
    if check_line?(marker, [main_diagonal(board)]) ||
       check_line?(marker, [anti_diagonal(board)]) ||
       check_line?(marker, rotate_90_clockwise(board)) ||
       check_line?(marker, board)
      puts "#{marker} has won the game!"
      return true
    end
    false
  end

  def print_board(board)
    puts "  0 1 2"
    board.each_with_index do |row, index|
      puts "#{index} #{row.join(' ')}"
    end
  end

  def make_move(board, marker, move_row, move_column)
    board[move_row][move_column] = marker
  end

  def board_full?(board)
    board.flatten.none? { |cell| cell == " " }
  end
end
