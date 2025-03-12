class Board
  COLUMNS = 7
  ROWS = 6

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLUMNS, ".") }
  end

  def print_board
    @grid.each { |row| puts row.join(" ") }
    puts (0...COLUMNS).to_a.join(" ")
  end

  def play_piece(marker, column)
    (ROWS - 1).downto(0) do |row|
      if @grid[row][column] == "."
        @grid[row][column] = marker
        return true
      end
    end
    false
  end

  def winning_move?(marker)
    # methods for checking horizontal, vertical, diagonal
    horizontal_win?(marker) || vertical_win?(marker) || diagonal_win?(marker)
  end

  def horizontal_win?(marker)
    @grid.any? { |row| row.join.include?(marker * 4) }
  end

  def vertical_win?(marker)
    (0...COLUMNS).any? do |col|
      @grid.map { |row| row[col] }.join.include?(marker * 4)
    end
  end

  def diagonal_win?(marker)
    (0..ROWS - 4).each do |row|
      (0..COLUMNS - 4).each do |col|
        return true if (0..3).all? { |i| @grid[row + i][col + i] == marker }
      end
    end
    (3...ROWS).each do |row|
      (0..COLUMNS - 4).each do |col|
        return true if (0..3).all? { |i| @grid[row - i][col + i] == marker }
      end
    end
    false
  end

  def board_full?
    @grid.all? { |row| row.none?(".") }
  end

  def valid_move?(column)
    column.between?(0, COLUMNS - 1) && @grid[0][column] == "."
  end
end
