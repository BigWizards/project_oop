module TicTacToe
  class Cell
    attr_accessor :value
    
    def initialize
      @value = " "
    end

    def change_value(player)
      if player == 1
        @value = "X"
      else
        @value = "O"
      end
    end
  end

  class Board
    attr_reader :board, :filled_cells, :print_board, :cells
    
    @@move_index = {
      "a1" => 0,
      "a2" => 1,
      "a3" => 2,
      "b1" => 3,
      "b2" => 4,
      "b3" => 5,
      "c1" => 6,
      "c2" => 7,
      "c3" => 8,    
    }

    def initialize
      @board = ["a1", "a2", "a3", 
                "b1", "b2" ,"b3", 
                "c1", "c2", "c3"
              ]
      @filled_cells = []
      @cells = []
      self.build_board
    end

    def build_board
      9.times {  @cells << Cell.new } 
    end

    def fill_cell(move, player)
        @filled_cells << @board.slice!(@@move_index[move])
        @cells[@@move_index[move]].change_value(player)
    end

    def print_board()
      "       3 #{@cells[2].value} | #{@cells[5].value} | #{@cells[8].value} 
        -----------
       2 #{@cells[1].value} | #{@cells[4].value} | #{@cells[7].value} 
        -----------
       1 #{@cells[0].value} | #{@cells[3].value} | #{@cells[6].value} 
         a   b   c"
    end
  end

  class Player
    attr_reader :identity, :move, :cells_owned
    @@used_moves = []
    @@posible_moves = [ "a1", "a2", "a3", 
                        "b1", "b2" ,"b3", 
                        "c1", "c2", "c3"
                      ]
    def initialize(identity)
      @identity = identity
      @cells_owned = []
      @@used_moves = []
    end

    def self.used_moves
      @@used_moves
    end

    def self.used_moves=(value)
      @@used_moves = value
    end

    def get_move
      input = gets.chomp
      if @@used_moves.include?(input)
        puts "That move has already been taken. Please input a different move."
        self.get_move
      elsif @@posible_moves.include?(input) == false
        puts "Please enter a coordinate for your move, such as a1, b2, c3, etc."
        self.get_move
      else
        @move = input
        @cells_owned << input
        @@used_moves << input
      end
    end
  end

  class Game
    attr_accessor :game_over, :board
    WIN_CONDITION = [ ["a1", "a2", "a3"], ["a1", "b2", "c3"],
                      ["a1", "b1", "c1"], ["a2", "b2", "c2"],
                      ["a3", "b3", "c3"], ["b1", "b2", "b3"],
                      ["c1", "c2", "c3"], ["c1", "b2", "a3"]
                      ]
    def initialize
      @game_over = false
      @players = []
      self.board = Board.new
    end

    def turn(player)
      player.get_move
      board.fill_cell(player.move, player.identity)
      puts board.print_board
      puts win?(player, player.cells_owned)
    end

    def win?(player, cells_owned)
      moves_array = cells_owned.permutation(3).to_a
      if moves_array.any? { |moves| WIN_CONDITION.include?(moves) }
        @game_over = true
        "player #{player.identity} Wins!"
      elsif (Player.used_moves).length == 9
        @game_over = true
        "It's a Draw."
      end
    end
  end
end

tic_tac_toe = TicTacToe::Game.new
player_one = TicTacToe::Player.new(1)
player_two = TicTacToe::Player.new(2)

# puts "Welcome to Tic-Tac-Toe"
# puts "Player 1 please put in your first move"
# puts tic_tac_toe.board.print_board

# until tic_tac_toe.game_over == true
#   tic_tac_toe.turn(player_one)
#   if tic_tac_toe.game_over == false
#     tic_tac_toe.turn(player_two)
#   end
# end
