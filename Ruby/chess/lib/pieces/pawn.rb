require_relative "piece"

class Pawn < Piece
  attr_accessor :just_moved_two

  def initialize(color, coords)
    icon = color == "white" ? "♟ " : "♙ "
    super(icon, color, coords)
    @just_moved_two = false
  end

  def generate_valid_moves(pieces, last_move = nil)
    moves = []
    row = coords[1]
    col = coords[0]

    direction = color == "white" ? 1 : -1
    start_row = color == "white" ? 1 : 6

    # Forward one step
    forward_one = [col, row + direction]
    if find_piece_at_position(pieces, forward_one).nil?
      moves.push(forward_one)

      # Forward two steps on first move
      if row == start_row
        forward_two = [col, row + (2 * direction)]
        moves.push(forward_two) if find_piece_at_position(pieces, forward_two).nil?
      end
    end

    # Capture diagonally
    diagonal_left = [col - 1, row + direction]
    diagonal_right = [col + 1, row + direction]

    piece_left = find_piece_at_position(pieces, diagonal_left)
    piece_right = find_piece_at_position(pieces, diagonal_right)

    moves.push(diagonal_left) if piece_left && piece_left.color != color
    moves.push(diagonal_right) if piece_right && piece_right.color != color

    # Handle en passant
    if last_move
      enemy_pawn, from, to = last_move
      if enemy_pawn.is_a?(Pawn) && enemy_pawn.color != color && (to[1] - from[1]).abs == (2) && (to[1] == row && (to[0] - col).abs == 1) # Must be adjacent
        en_passant_target = [to[0], row + direction]
        moves.push(en_passant_target)
      end
    end

    moves
  end
end
