require_relative 'lib/tic_tac_toe_board'
include TicTacToeMethods

board = [
  [' ', ' ', ' '],
  [' ', ' ', ' '],
  [' ', ' ', ' ']
]

print_board(board)

is_over = false
current_marker = 'x'

def turn(marker, board)
  puts "#{marker}'s turn. Enter your move."

  loop do
    puts 'What row? (0-2)'
    row = gets.chomp.to_i
    puts 'What column? (0-2)'
    col = gets.chomp.to_i

    if row.between?(0, 2) && col.between?(0, 2) && board[row][col] == ' '
      make_move(board, marker, row, col)
      break
    else
      puts 'Invalid move. Try again.'
    end
  end

  print_board(board)

  if check_if_game_won?(marker, board)
    [true, marker]
  elsif board_full?(board)
    [true, nil]
  else
    [false, nil]
  end
end

until is_over
  is_over, winner = turn(current_marker, board)
  break if is_over

  current_marker = current_marker == 'x' ? 'o' : 'x'
end

if winner
  puts "Game over! #{winner} wins!"
else
  puts "Game over! It's a draw!"
end
