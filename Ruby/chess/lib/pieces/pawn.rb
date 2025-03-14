require_relative "piece"
class Pawn < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♟ " : "♙ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces)
    moves = []
    row = coords[1]
    col = coords[0]

    direction = color == "white" ? 1 : -1
    start_row = color == "white" ? 1 : 6

    # Move forward one square if empty
    forward_one = [col, row + direction]
    if find_piece_at_position(pieces, forward_one).nil?
      puts "Hey"
      moves.push(forward_one)

      # Move forward two squares if at starting position and both squares are empty
      if row == start_row
        forward_two = [col, row + (2 * direction)]
        moves.push(forward_two) if find_piece_at_position(pieces, forward_two).nil?
      end
    end

    # Capture diagonally (left)
    diagonal_left = [col - 1, row + direction]
    piece_left = find_piece_at_position(pieces, diagonal_left)
    moves.push(diagonal_left) if piece_left && piece_left.color != color

    # Capture diagonally (right)
    diagonal_right = [col + 1, row + direction]
    piece_right = find_piece_at_position(pieces, diagonal_right)
    moves.push(diagonal_right) if piece_right && piece_right.color != color

    moves
  end
end
