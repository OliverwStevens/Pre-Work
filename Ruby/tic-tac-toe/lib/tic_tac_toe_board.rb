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
    strip.select do |line|
      win = line.all?(marker)
      next unless win == true

      # player_win(marker)
      p line
      puts 'A player won'
      return win
    end
  end

  def check_if_game_won(marker, board)
    # put the ? in the check line to return a bool
    if check_line?(marker,
                   [main_diagonal(board)]) || check_line?(marker,
                                                          [anti_diagonal(board)]) || check_line?(marker,
                                                                                                 rotate_90_clockwise(board)) || check_line?(
                                                                                                   marker, board
                                                                                                 )
      puts "#{marker} has won the game!"
    end
  end

  def print_board(board)
    puts '  0 1 2'
    board.each_with_index do |row, index|
      puts "#{index} #{row.join(' ')}"
    end
  end

  def make_move(board, marker, move_row, move_column)
    board[move_row][move_column] = marker
  end
end
