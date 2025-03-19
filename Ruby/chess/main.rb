require "json"
require_relative "lib/piece_manager"
require_relative "lib/pieces/pawn"
require_relative "lib/pieces/rook"
require_relative "lib/pieces/knight"
require_relative "lib/pieces/bishop"
require_relative "lib/pieces/queen"
require_relative "lib/pieces/king"

def save_game(pieces, color, last_move, move_counter, halfmove_clock, position_history)
  puts "Name your game:"
  file_name = "./Ruby/chess/lib/games/#{gets.chomp}.json"

  game_state = {
    pieces: pieces.map { |piece| { type: piece.class.name, color: piece.color, coords: piece.coords } },
    color: color,
    last_move: last_move,
    move_counter: move_counter,
    halfmove_clock: halfmove_clock,
    position_history: position_history
  }

  File.write(file_name, JSON.pretty_generate(game_state))
  puts "Game saved to #{file_name}."
end

def load_game(file_name)
  file_path = "./Ruby/chess/lib/games/#{file_name}.json"

  unless File.exist?(file_path)
    puts "File not found!"
    return
  end

  game_state = JSON.parse(File.read(file_path))

  pieces = game_state["pieces"].map do |piece_data|
    Object.const_get(piece_data["type"]).new(piece_data["color"], piece_data["coords"])
  end

  piece_manager = PieceManager.new(pieces)
  piece_manager.move_counter = game_state["move_counter"]
  piece_manager.halfmove_clock = game_state["halfmove_clock"]
  piece_manager.position_history = game_state["position_history"]
  start_game(piece_manager, game_state["color"], game_state["last_move"])
end

def start_game(piece_manager, color = "white", last_move = [])
  loop do
    puts "#{color.capitalize}'s turn. Enter your move (e.g., 'e2 e4') or '/s' to save:"
    piece_manager.show_board
    input = gets.chomp.downcase

    if input == "/s"
      save_game(piece_manager.pieces, color, last_move, piece_manager.move_counter, piece_manager.halfmove_clock,
                piece_manager.position_history)
      break
    end

    move_made = piece_manager.input_handler(color, input, last_move)
    color = (color == "white" ? "black" : "white") if move_made
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
  puts "Loading #{game_name}. To save your game, enter '/s'."
  load_game(game_name)
end
