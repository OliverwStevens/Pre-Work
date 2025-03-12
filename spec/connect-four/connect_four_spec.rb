require_relative "../../Ruby/connect-four/lib/connect_four"
require_relative "../../Ruby/connect-four/lib/board"
require_relative "../../Ruby/connect-four/lib/player"

describe Connect_Four do
  let(:game) { Connect_Four.new }

  describe "#initialize" do
    it "creates a board" do
      expect(game.instance_variable_get(:@board)).to be_a(Board)
    end

    it "creates two players" do
      expect(game.instance_variable_get(:@player_1)).to be_a(Player)
      expect(game.instance_variable_get(:@player_2)).to be_a(Player)
    end

    it "sets the first player as the current player" do
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_1))
    end
  end

  describe "#swap_player" do
    it "switches from player 1 to player 2" do
      game.swap_player
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_2))
    end

    it "switches back from player 2 to player 1" do
      game.swap_player
      game.swap_player
      expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_1))
    end
  end

  describe "#play_game" do
    it "declares a winner when a player wins" do
      allow(game).to receive(:gets).and_return("0", "0", "1", "1", "2", "2", "3")
      expect(game.instance_variable_get(:@board)).to receive(:print_board).at_least(:once)
      expect(game.instance_variable_get(:@board)).to receive(:winning_move?).with("x").and_return(true)
      expect { game.play_game }.to output(/Player x wins!/).to_stdout
    end

    it "declares a draw when the board is full" do
      allow(game.instance_variable_get(:@board)).to receive(:board_full?).and_return(true)
      expect { game.play_game }.to output(/It's a draw!/).to_stdout
    end
  end
end
