module Mastermind

  class Peg 

    attr_accessor :colour, :key

    def initialize
      @colour = " "
      @key = " "
    end
  end

  class Board
    attr_reader :code_pegs, :print_board 
    attr_accessor :game, :hidden_code
    
    def initialize
      @code_pegs = []
      @key_pegs = []
      @code_peg_num = 0
      @key_peg_num = 0
      @hidden_code = ["H", "H", "H", "H"]
    end

    def change_code_peg(colour)
      @code_pegs[@code_peg_num].colour = colour
      @code_peg_num += 1
    end
    
    def change_key_peg(key)
      @key_pegs[@key_peg_num].key = key
      @key_peg_num += 1
    end

    def add_key_peg(peg)
      @key_pegs << peg
    end

    def fill_board
      48.times { @code_pegs << Mastermind::Peg.new }
      48.times { @key_pegs << Mastermind::Peg.new }
    end

    def print_board()
      "      | #{@hidden_code[0]} | #{@hidden_code[1]} | #{@hidden_code[2]} | #{@hidden_code[3]} | Hidden Code
      |---------------|
      | #{@code_pegs[44].colour} | #{@code_pegs[45].colour} | #{@code_pegs[46].colour} | #{@code_pegs[47].colour} | #{@key_pegs[44].key}#{@key_pegs[45].key}#{@key_pegs[46].key}#{@key_pegs[47].key}
      |---------------|
      | #{@code_pegs[40].colour} | #{@code_pegs[41].colour} | #{@code_pegs[42].colour} | #{@code_pegs[43].colour} | #{@key_pegs[40].key}#{@key_pegs[41].key}#{@key_pegs[42].key}#{@key_pegs[43].key}
      |---------------|
      | #{@code_pegs[36].colour} | #{@code_pegs[37].colour} | #{@code_pegs[38].colour} | #{@code_pegs[39].colour} | #{@key_pegs[36].key}#{@key_pegs[37].key}#{@key_pegs[38].key}#{@key_pegs[39].key}
      |---------------|
      | #{@code_pegs[32].colour} | #{@code_pegs[33].colour} | #{@code_pegs[34].colour} | #{@code_pegs[35].colour} | #{@key_pegs[32].key}#{@key_pegs[33].key}#{@key_pegs[34].key}#{@key_pegs[35].key}
      |---------------|
      | #{@code_pegs[28].colour} | #{@code_pegs[29].colour} | #{@code_pegs[30].colour} | #{@code_pegs[31].colour} | #{@key_pegs[28].key}#{@key_pegs[29].key}#{@key_pegs[30].key}#{@key_pegs[31].key}
      |---------------|
      | #{@code_pegs[24].colour} | #{@code_pegs[25].colour} | #{@code_pegs[26].colour} | #{@code_pegs[27].colour} | #{@key_pegs[24].key}#{@key_pegs[25].key}#{@key_pegs[26].key}#{@key_pegs[27].key}
      |---------------|
      | #{@code_pegs[20].colour} | #{@code_pegs[21].colour} | #{@code_pegs[22].colour} | #{@code_pegs[23].colour} | #{@key_pegs[20].key}#{@key_pegs[21].key}#{@key_pegs[22].key}#{@key_pegs[23].key}
      |---------------|
      | #{@code_pegs[16].colour} | #{@code_pegs[17].colour} | #{@code_pegs[18].colour} | #{@code_pegs[19].colour} | #{@key_pegs[16].key}#{@key_pegs[17].key}#{@key_pegs[18].key}#{@key_pegs[19].key}
      |---------------|
      | #{@code_pegs[12].colour} | #{@code_pegs[13].colour} | #{@code_pegs[14].colour} | #{@code_pegs[15].colour} | #{@key_pegs[12].key}#{@key_pegs[13].key}#{@key_pegs[14].key}#{@key_pegs[15].key}
      |---------------|
      | #{@code_pegs[8].colour} | #{@code_pegs[9].colour} | #{@code_pegs[10].colour} | #{@code_pegs[11].colour} | #{@key_pegs[8].key}#{@key_pegs[9].key}#{@key_pegs[10].key}#{@key_pegs[11].key}
      |---------------|
      | #{@code_pegs[4].colour} | #{@code_pegs[5].colour} | #{@code_pegs[6].colour} | #{@code_pegs[7].colour} | #{@key_pegs[4].key}#{@key_pegs[5].key}#{@key_pegs[6].key}#{@key_pegs[7].key}
      |---------------|
      | #{@code_pegs[0].colour} | #{@code_pegs[1].colour} | #{@code_pegs[2].colour} | #{@code_pegs[3].colour} | #{@key_pegs[0].key}#{@key_pegs[1].key}#{@key_pegs[2].key}#{@key_pegs[3].key}"
    end
  end

  class Player
    attr_reader :move
    COLOURS = ["r", "b", "g", "y", "w", "o"]

    def get_guess
      input = gets.chomp
      input_array = input.split("")
      return input_array
    end
    
    def choose_role
      puts "Would you like to be the Code Maker or Code Breaker? Type m for Maker and b for Breaker"
      player_choice = gets.chomp.downcase
      return player_choice
    end
  
    def get_player_code
      player_code = ""
      player_code_array = []
      puts "Enter the first letter for each colour of your code in the style of 'rgby'."
      puts "The colours you can choose from are Red(r), Green(g), Blue(b), Yellow(y), Orange(o) and White(w)"
      player_code = gets.chomp.downcase
      if player_code.length == 4
        player_code_array = player_code.split("")
        re_enter_code = false
        player_code_array.each do |i| 
          if COLOURS.include?(i) == false 
            re_enter_code = true
          end
        end
        if re_enter_code == true
          puts "Please enter a usable code"
          self.get_player_code
        elsif re_enter_code == false
          p player_code_array
          return player_code_array
        end
      else
        puts "Please enter a usable code"
          self.get_player_code
      end
    end
  end

  class Game
    attr_accessor :hidden_code, :correct_colour, :correct_position, :board, 
                  :game_over, :ai, :player, :player_role
    @@key_number

    def initialize
      @game_over = false
      @hidden_code = []
      @correct_colour = 0
      @correct_position = 0
      @@key_number = 0
      @player_role = ""
    end

    def self.key_number
      @@key_number
    end

    def get_code
      player_role = player.choose_role
      if player_role == "m"
        @player_role = player_role
        @hidden_code = player.get_player_code
      elsif player_role == "b"
        @player_role = player_role
        @hidden_code = ai.code
      else
        puts "Please re-input your desired role."
        self.get_code
      end
    end

    def player_turn
      code_guess = player.get_guess
      self.turn(code_guess)
    end

    def ai_turn
      code_guess = ai.code
      self.turn(code_guess)
    end

    def turn(code_guess)
      @correct_colour = 0
      @correct_position = 0
      code_guess_dup = code_guess.dup
      hidden_code_copy = @hidden_code.dup
      self.scan_for_position(code_guess, hidden_code_copy)
      self.scan_for_colour(code_guess, hidden_code_copy)
      self.interpret_guess(code_guess_dup)
    end
    
    def interpret_guess(code_guess)
      4.times do
        if @correct_colour > 0 
          board.change_key_peg("C")
          @correct_colour -= 1
        elsif @correct_position > 0
          board.change_key_peg("P")
          @correct_position -= 1
        else
          board.change_key_peg("M")
        end
        if code_guess == @hidden_code
          @game_over = true
          board.hidden_code = @hidden_code
        end
      end
    end
    
    def scan_for_position(code_guess, hidden_code)
      correct_positions_hash = {}
      0.upto(3) do |index|
        board.change_code_peg(code_guess[index])
        if hidden_code[index] == code_guess[index]
          correct_positions_hash[index] = hidden_code[index]
          @correct_position += 1
          hidden_code[hidden_code.index(code_guess[index])] = "used"
          code_guess[index] = "matched"
        end
      end
      ai.correct_positions = correct_positions_hash
    end
    
    def scan_for_colour(code_guess, hidden_code)
      correct_colours_hash = {}
      0.upto(3) do |index|
        if hidden_code.include?(code_guess[index])
          correct_colours_hash[index] = code_guess[index]
          @correct_colour += 1
          hidden_code[hidden_code.index(code_guess[index])] = "used"
        end
      end
      ai.correct_colours = correct_colours_hash
    end
  end

  class Computer
    attr_accessor :code, :correct_positions, :correct_colours
    COLOURS = ["r", "b", "g", "y", "w", "o"]
    INDEXES = [0, 1, 2, 3]

    def initialize
      @code = []
      @correct_positions = {}
      @correct_colours = []
    end

    def code
      self.generate_code
      used_indexes = []
      if @correct_positions.length > 0
        correct_positions.each do |key, value| 
          @code[key] = value 
          used_indexes << key
        end
      end
      if @correct_colours.length > 0
        correct_colours.each do |key, value|
          used_indexes << key
          available_indexes = INDEXES.difference(used_indexes)
          @code[available_indexes[rand(available_indexes.length)]] = value
        end
      end
      @code
    end

    def generate_code
      @code = []
      4.times do
        @code << COLOURS[rand(6)]
      end
    end
  end
end


mastermind_board = Mastermind::Board.new
mastermind = Mastermind::Game.new
human = Mastermind::Player.new
computer = Mastermind::Computer.new
mastermind_board.game = mastermind
mastermind.board = mastermind_board
mastermind.ai = computer
mastermind.player = human

mastermind_board.fill_board
puts "welcome to mastermind"
i = 0
mastermind.get_code
until mastermind.game_over == true
  if mastermind.player_role == "b"
    puts mastermind_board.print_board
    mastermind.player_turn
    if mastermind.game_over == true
      puts mastermind_board.print_board
      puts "YOU WIN!"
    end
    i += 1
    if i == 12
      mastermind.game_over = true
      puts mastermind_board.print_board
      puts "Game Over the hidden code was..."
      print mastermind.hidden_code
    end
  elsif mastermind.player_role == "m"
    puts mastermind_board.print_board
    mastermind.ai_turn
    sleep(1)
    if mastermind.game_over == true
      puts mastermind_board.print_board
      puts "THE AI WINS!"
    end
    i += 1
    if i == 12
      mastermind.game_over = true
      puts mastermind_board.print_board
      puts "You win the AI couldn't guess your code!"
    end
  end
end