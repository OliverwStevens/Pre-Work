require_relative "piece"
class King < Piece
  attr_accessor :has_moved

  def initialize(color, coords)
    icon = color == "white" ? "♚ " : "♔ "
    super(icon, color, coords)
    @has_moved = false # Track if the king has moved (needed for castling)
  end

  def generate_valid_moves(pieces, _last_move = nil)
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

    # Add castling moves if eligible
    castling_moves = get_castling_moves(pieces)
    moves += castling_moves if castling_moves.any?

    # Remove moves that would put the king in check
    moves - get_danger_squares(pieces, color)
  end

  def generate_king_danger_squares
    moves = []
    row, col = coords

    king_moves = [
      [0, 1], [0, -1], [1, 0], [-1, 0],  # Horizontal & Vertical
      [1, 1], [1, -1], [-1, 1], [-1, -1] # Diagonal
    ]

    king_moves.each do |dx, dy|
      new_col = col + dx
      new_row = row + dy
      moves.push([new_row, new_col]) if new_col.between?(0, 7) && new_row.between?(0, 7)
    end

    moves
  end

  def get_danger_squares(pieces, color)
    danger_squares = []
    enemy_pieces = pieces.reject { |piece| piece.color == color }

    enemy_pieces.each do |piece|
      danger_squares += if piece.is_a?(King)
                          # King moves should be handled differently to prevent infinite recursion
                          piece.generate_king_danger_squares
                        else
                          piece.generate_valid_moves(pieces)
                        end
    end

    danger_squares.uniq
  end

  def get_castling_moves(pieces)
    return [] if has_moved || in_check?(pieces)

    castling_moves = []
    row = color == "white" ? 0 : 7 # Starting row for the king based on color

    # Check kingside castling
    kingside_rook = find_piece_at_position(pieces, [row, 7])
    if can_castle_kingside?(pieces, kingside_rook)
      castling_moves << [row, 6] # King's position after kingside castling
    end

    # Check queenside castling
    queenside_rook = find_piece_at_position(pieces, [row, 0])
    if can_castle_queenside?(pieces, queenside_rook)
      castling_moves << [row, 2] # King's position after queenside castling
    end

    castling_moves
  end

  def can_castle_kingside?(pieces, rook)
    return false unless rook && rook.is_a?(Rook) && rook.color == color && !rook.has_moved

    row = coords[0]

    # Check if squares between king and rook are empty
    return false unless find_piece_at_position(pieces, [row, 5]).nil?
    return false unless find_piece_at_position(pieces, [row, 6]).nil?

    # Check if king would move through or into check
    danger_squares = get_danger_squares(pieces, color)
    return false if danger_squares.include?([row, 5]) || danger_squares.include?([row, 6])

    true
  end

  def can_castle_queenside?(pieces, rook)
    return false unless rook && rook.is_a?(Rook) && rook.color == color && !rook.has_moved

    row = coords[0]

    # Check if squares between king and rook are empty
    return false unless find_piece_at_position(pieces, [row, 1]).nil?
    return false unless find_piece_at_position(pieces, [row, 2]).nil?
    return false unless find_piece_at_position(pieces, [row, 3]).nil?

    # Check if king would move through or into check
    danger_squares = get_danger_squares(pieces, color)
    return false if danger_squares.include?([row, 2]) || danger_squares.include?([row, 3])

    true
  end

  def in_check?(pieces)
    danger_squares = get_danger_squares(pieces, color)
    danger_squares.include?(coords)
  end

  def move_to(new_coords, pieces)
    # Check if this is a castling move
    if !has_moved && (new_coords[1] == coords[1] + 2 || new_coords[1] == coords[1] - 2)
      perform_castling(new_coords, pieces)
    else
      # Regular move
      self.coords = new_coords
      @has_moved = true
    end
  end

  def perform_castling(new_coords, pieces)
    row = new_coords[0]
    col = new_coords[1]

    # Kingside castling
    if col == 6
      rook = find_piece_at_position(pieces, [row, 7])
      rook.coords = [row, 5] if rook
    # Queenside castling
    elsif col == 2
      rook = find_piece_at_position(pieces, [row, 0])
      rook.coords = [row, 3] if rook
    end

    # Move the king
    self.coords = new_coords
    @has_moved = true
  end
end
