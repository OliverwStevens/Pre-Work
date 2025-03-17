require_relative "../../Ruby/chess/lib/piece_manager"

RSpec.describe PieceManager do
  let(:manager) { PieceManager.new }

  describe "#input_handler" do
    context "when moving a valid piece" do
      it "returns the correct start and end coordinates" do
        result = manager.input_handler("white", "e2 e4", [])
        expect(result).to eq([[4, 1], [4, 3]])
      end
    end

    context "when trying to move from an empty square" do
      it "returns an error message" do
        expect { manager.input_handler("white", "e5 e6", []) }
          .to output("Invalid move: No white piece at e5\n").to_stdout
      end
    end

    context "when trying to move an opponent's piece" do
      it "returns an error message" do
        expect { manager.input_handler("white", "e7 e6", []) }
          .to output("Invalid move: No white piece at e7\n").to_stdout
      end
    end

    context "when trying to move onto a square occupied by the same color" do
      it "returns an error message" do
        expect { manager.input_handler("white", "e2 e1", []) }
          .to output("Invalid move: white piece already at e1\n").to_stdout
      end
    end

    context "when input is invalid (not in chess notation)" do
      it "returns nil" do
        result = manager.input_handler("white", "z9 x8", [])
        expect(result).to be_nil
      end
    end
  end
end
