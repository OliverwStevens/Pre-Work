require_relative "piece_manager"
class Game
  def initialize
    @piece_manager = Piece_Manager.new
  end
end
