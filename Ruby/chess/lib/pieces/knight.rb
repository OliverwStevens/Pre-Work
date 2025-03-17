require_relative "piece"
class Knight < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♞ " : "♘ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces, _last_move = nil)
    moves = []
    row, col = coords

    knight_moves = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ]

    knight_moves.each do |dx, dy|
      new_col = col + dx
      new_row = row + dy
      new_position = [new_row, new_col]

      next unless new_col.between?(0, 7) && new_row.between?(0, 7)

      piece_at_new_position = find_piece_at_position(pieces, new_position)

      moves.push(new_position) if piece_at_new_position.nil? || piece_at_new_position.color != color
    end
    moves
  end
end
