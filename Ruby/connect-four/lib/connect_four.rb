require_relative "board"
require_relative "player"
class Connect_Four
  def initialize
    @board = Board.new
    @player_1 = Player.new("x")
    @player_2 = Player.new("o")

    @current_player = @player_1
  end

  def play_game
    until @board.board_full?
      @board.print_board
      puts "Player #{@current_player.marker}'s turn"

      column = nil
      loop do
        print "Enter a column (0-#{Board::COLUMNS - 1}): "
        input = gets.chomp
        if input.match?(/^\d+$/)
          column = input.to_i
          break if @board.valid_move?(column)
        end

        puts "Invalid move! Please choose a different column."
      end

      @board.play_piece(@current_player.marker, column)

      if @board.winning_move?(@current_player.marker)
        @board.print_board
        puts "Player #{@current_player.marker} wins!"
        return
      end

      swap_player
    end

    @board.print_board
    puts "It's a draw!"
  end

  def swap_player
    @current_player = @current_player == @player_1 ? @player_2 : @player_1
  end
end
