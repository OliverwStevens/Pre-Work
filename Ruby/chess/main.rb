require_relative "lib/piece_manager"

# add last move parameter to handle enpassant
def start_game(piece_manager, color = "white")
  loop do
    puts "#{color.capitalize}'s turn. Enter your move (e.g., 'e2 e4') or '/s' to save:"
    piece_manager.show_board
    input = gets.chomp.downcase

    # add more functionality later
    break if input == "/s"

    move = piece_manager.input_handler(color, input)
    next unless move

    # black was first here, I edited this to make testing it faster
    color = color == "white" ? "white" : "white"
  end
end

puts "Hello! Welcome to chess, the best game ever!"
puts "If you would like to play a new game, press enter.\nIf you would like to load a game, enter the name of your game."
game_name = gets.chomp
if game_name == ""
  puts "Starting a new game. To save your game, enter '/s'."
  piece_manager = PieceManager.new
  start_game(piece_manager)
else
  # load the game
end
