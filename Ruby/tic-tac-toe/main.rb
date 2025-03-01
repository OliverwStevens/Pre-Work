board = [
  ['x', ' ', 'x'],
  [' ', 'x', 'o'],
  ['o', ' ', 'x']
]

# p main_diagonal(board)

# p [anti_diagonal(board)]

# p rotate_90_clockwise(board)

# p check_line("x", [main_diagonal(board)])

print_board(board)
make_move(board, 'x', 0, 1)
p check_if_game_won('x', board)

print_board(board)
