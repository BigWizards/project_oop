require "./lib/tic_tac_toe"

describe "Game" do
  describe "#win?" do
    before(:each) do
      @tic_tac_toe = TicTacToe::Game.new
      @player = TicTacToe::Player.new(1)
    end
    
    context "player fills row" do
      it "returns game_over = true" do
        @tic_tac_toe.win?(@player, ["a1", "a2", "a3"])
        expect(@tic_tac_toe.game_over).to eql(true)
      end
    end
    context "without win condition" do
      it "returns game_over = false" do
        @tic_tac_toe.win?(@player, ["a1", "a2", "b3"])
        expect(@tic_tac_toe.game_over).to eql(false)
      end
    end
    context "filled the grid" do
      it "returns 'it's a draw'" do
        TicTacToe::Player.used_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        expect(@tic_tac_toe.win?(@player, ["a1", "a2", "b3"])).to eql("It's a Draw.")
        TicTacToe::Player.used_moves = []
      end
    end
  end
end

describe "Board" do 
  describe "#fill_cell" do
    context "fills the appropriate cell" do
      board = TicTacToe::Board.new
      board.fill_cell("a1", 1)
      it "returns a1 in filled_cells" do
        expect(board.filled_cells).to eql(["a1"])
      end
      it "returns X in in a1 cell" do
        expect(board.cells[0].value).to eql("X")
      end
    end
  end
end

describe "Player" do 
  describe "#get_move" do
    player_test = TicTacToe::Player.new(1)
    context "recieves valid move input" do
      it "adds a1 to @moves" do
        allow(player_test).to receive(:gets).and_return("a1")
        player_test.get_move
        expect(player.move).to eql("a1")
      end
      it "adds a1 to @cells_owned" do
        expect(player_test.cells_owned).to eql(["a1"])
      end
      it "adds a1 to @@used_moves" do
        expect(TicTacToe::Player.used_moves).to eql(["a1"])
      end
    end
  end
end
  
