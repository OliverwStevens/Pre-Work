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
end
