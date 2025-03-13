require_relative "piece_manager"
class Game
  def initialize
    @piece_manager = PieceManager.new
  end
end
