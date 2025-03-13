require_relative "pieces/pawn"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"
class PieceManager
  def initialize
    @pieces = []
    8.times do |num|
      pawn = Pawn.new("white", [num, 1])
      @pieces.push(pawn)
    end
    8.times do |num|
      pawn = Pawn.new("black", [num, 6])
      @pieces.push(pawn)
    end
    # rooks
    @pieces.push(Rook.new("white", [0, 0]))
    @pieces.push(Rook.new("white", [7, 0]))
    @pieces.push(Rook.new("black", [0, 7]))
    @pieces.push(Rook.new("black", [7, 7]))

    # knights
    @pieces.push(Knight.new("white", [1, 0]))
    @pieces.push(Knight.new("white", [6, 0]))
    @pieces.push(Knight.new("black", [1, 7]))
    @pieces.push(Knight.new("black", [6, 7]))

    # bishops
    @pieces.push(Bishop.new("white", [2, 0]))
    @pieces.push(Bishop.new("white", [5, 0]))
    @pieces.push(Bishop.new("black", [2, 7]))
    @pieces.push(Bishop.new("black", [5, 7]))

    # queens
    @pieces.push(Queen.new("white", [3, 0]))
    @pieces.push(Queen.new("black", [3, 7]))

    # kings
    @pieces.push(King.new("white", [4, 0]))
    @pieces.push(King.new("black", [4, 7]))
  end

  def show_board
    board = Array.new(8) { Array.new(8, ". ") }

    @pieces.each do |piece|
      x, y = piece.coords
      board[y][x] = piece.icon
    end

    puts "  a b c d e f g h"
    board.reverse.each_with_index do |row, index|
      puts "#{8 - index} #{row.join}"
    end
  end

  def input_handler(color, input)
    start_pos, end_pos = input.split

    start_coords = algebraic_to_index(start_pos)
    end_coords = algebraic_to_index(end_pos)

    return unless start_coords && end_coords

    piece = @pieces.find { |p| p.coords == start_coords && p.color == color }

    return puts "Invalid move: No #{color} piece at #{start_pos}" unless piece

    target_piece = @pieces.find { |p| p.coords == end_coords }
    return puts "Invalid move: #{color} piece already at #{end_pos}" if target_piece && target_piece.color == color

    # Validate legal moves and checks here
    puts "Move from #{start_coords} to #{end_coords}"
    [start_coords, end_coords]
  end

  def algebraic_to_index(pos)
    return nil if pos.nil?
    return nil unless pos.match?(/^[a-h][1-8]$/)

    file = pos[0].ord - "a".ord
    rank = pos[1].to_i - 1

    [file, rank]
  end

  # utility methods
  def show_current_pieces
    @pieces.each { |piece| p [piece.color, piece.icon, piece.coords] }
  end

  def piece_count
    puts @pieces.length
  end
end

# piece_manager = PieceManager.new
# piece_manager.show_board
# piece_manager.input_handler("white", gets.chomp)
