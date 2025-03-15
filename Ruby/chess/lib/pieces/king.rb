require_relative "piece"
class King < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♚ " : "♔ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces)
    moves = []
    row, col = coords

    king_moves = [
      [0, 1], [0, -1], [1, 0], [-1, 0],  # Horizontal & Vertical
      [1, 1], [1, -1], [-1, 1], [-1, -1] # Diagonal
    ]

    king_moves.each do |dx, dy|
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
