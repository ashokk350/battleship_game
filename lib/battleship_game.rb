require 'pry'
require './lib/player'

class BattleshipGame
  attr_reader :players

  def initialize
    @players = { player1: nil, player2: nil }
  end

  def initialize_game(file_path)
    File.foreach(file_path).with_index do |line, index|
      case index
      when 0
        # This is initializing the new playes with grid.
        grid_size = line.to_i
        @players[:player1] = Player.new(grid_size)
        @players[:player2] = Player.new(grid_size)
      when 2
        # This is deploying ships to grid for player 1 and converting input to array of cordinates.
        # Ex. [[1, 1], [2, 0], [2, 3], [3, 4], [4, 3]]
        @players[:player1].deploy_ships(split_input(line))
      when 3
        # This is deploying ships to grid for player 2.
        @players[:player2].deploy_ships(split_input(line))
      when 5
        # It is reading the moves from file and conveting them into array of moves for playes 1.
        @players[:player1].moves = split_input(line)
      when 6
        # It is reading the moves from file and conveting them into array of moves for playes 2.
        @players[:player2].moves = split_input(line)
      end
    end
  end

  def play
    # Here, Players will attack each other based on moves.
    @players.each_with_index do |(key, player), index|
      key = index == 0 ? :player2 : :player1
      attack(@players[key], player.moves)
    end
  end

  # Here, moves are from attacking players and opponent will be the attacked player.
  def attack(opponent, moves)
    moves.each do |x, y|
      opponent.attack(x, y)
    end
  end

  def split_input(line)
    line.chomp.split(":").map { |move| move.split(",").map(&:to_i) }
  end

  def output(file_path)
    File.open(file_path, "w") do |file|
      @players.each_with_index do |(key, player), index|
        file.puts "Player #{index + 1}"
        file.puts ""
        # It is printing the output based on players final grid after the attacks.
        player.grid.each { |row| file.puts row.join(" ") }
        file.puts ""
      end

      # Player1 hits will be counted from player2 grid.
      # Player2 hits will be counted from player1 grid.
      p1_hits = @players[:player2].hits_count
      p2_hits = @players[:player1].hits_count
      file.puts "P1:#{p1_hits}"
      file.puts ""
      file.puts "P2:#{p2_hits}"
      file.puts ""

      if p1_hits > p2_hits
        file.puts "Player 1 wins"
      elsif p1_hits < p2_hits
        file.puts "Player 2 wins"
      else
        file.puts "It is a draw"
      end
    end
  end
end

base_dir = File.dirname(__dir__)
# This is the input file you can find it in root directory of the project.
file_path = File.join(base_dir, "input.txt")

game = BattleshipGame.new
game.initialize_game(file_path)
game.play

# This is the output file you can find it in root directory of the project.
file_path = File.join(base_dir, "output.txt")
game.output(file_path)

