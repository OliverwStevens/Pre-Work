require_relative "piece"
class Bishop < Piece
  def initialize(color, coords)
    icon = color == "white" ? "♝ " : "♗ "
    super(icon, color, coords)
  end

  def generate_valid_moves(pieces)
    moves = []
    row = coords[1]
    col = coords[0]

    # Define a helper lambda to process moves
    process_move = lambda do |col_step, row_step|
      c = col + col_step
      r = row + row_step

      while c.between?(0, 7) && r.between?(0, 7)
        move = [c, r]
        piece_at_move = find_piece_at_position(pieces, move)

        if piece_at_move.nil?
          moves.push(move)
        elsif piece_at_move.color != color
          moves.push(move) # Capture opponent's piece
          break # Stop after capturing
        else
          break # Stop at friendly piece
        end

        c += col_step
        r += row_step
      end
    end

    process_move.call(-1, -1)  # Top-left
    process_move.call(1, -1)   # Top-right
    process_move.call(-1, 1)   # Bottom-left
    process_move.call(1, 1)    # Bottom-right

    moves
  end
end
