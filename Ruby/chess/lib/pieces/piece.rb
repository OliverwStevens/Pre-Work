module PieceMovement
  def rook_movement(pieces)
    moves = []
    row = coords[1]
    col = coords[0]

    # Check upward moves (decreasing row)
    (row - 1).downto(0) do |r|
      move = [col, r]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check downward moves (increasing row)
    (row + 1).upto(7) do |r|
      move = [col, r]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check leftward moves (decreasing column)
    (col - 1).downto(0) do |c|
      move = [c, row]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    # Check rightward moves (increasing column)
    (col + 1).upto(7) do |c|
      move = [c, row]
      piece_at_move = find_piece_at_position(pieces, move)

      if piece_at_move.nil?
        moves.push(move)
      elsif piece_at_move.color != color
        moves.push(move) # Capture opponent's piece
        break # Stop after capturing
      else
        break # Stop at friendly piece
      end
    end

    moves
  end

  def bishop_movement(pieces)
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

class Piece
  attr_accessor :icon, :color, :coords

  def initialize(icon, color, coords)
    @icon = icon
    @color = color
    @coords = coords
  end

  # def legal_moves
  def generate_valid_moves(pieces)
    puts "Hello, your legal moves would appear here"
    nil
  end

  def find_piece_at_position(pieces, position)
    pieces.find { |piece| piece.coords == position }
  end
end
