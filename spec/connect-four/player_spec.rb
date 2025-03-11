require_relative "../../Ruby/connect-four/lib/player"

RSpec.describe Player do
  describe "#initialize" do
    it "sets the player symbol" do
      player = Player.new("x")
      expect(player.marker).to eq("x")
    end
  end
end
