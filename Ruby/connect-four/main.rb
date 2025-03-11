require_relative "lib/board"

board = Board.new

board.play_piece("o", 1)
board.play_piece("x", 1)
board.play_piece("o", 2)
board.play_piece("o", 2)
board.play_piece("x", 2)
board.play_piece("o", 3)
board.play_piece("o", 3)
board.play_piece("o", 3)
board.play_piece("x", 3)
board.play_piece("o", 4)

board.play_piece("o", 4)
board.play_piece("o", 4)
board.play_piece("o", 4)
board.play_piece("x", 4)

board.print_board
puts board.diagonal_win?("x")
