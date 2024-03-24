require './lib/battleship_game'

RSpec.describe BattleshipGame do
  let(:game) { BattleshipGame.new }
  let(:file_path) { 'spec/fixtures/sample_input.txt' }

  describe '#initialize' do
    it 'initializes players hash with nil values' do
      expect(game.players).to eq({ player1: nil, player2: nil })
    end
  end

  describe '#initialize_game' do
    it 'initializes game with correct players and grid size' do
      game.initialize_game(file_path)
      expect(game.players[:player1]).to be_instance_of(Player)
      expect(game.players[:player2]).to be_instance_of(Player)
      expect(game.players[:player1].grid.size).to eq(5)
      expect(game.players[:player2].grid.size).to eq(5)
    end

    it 'deploys ships correctly for both players' do
      game.initialize_game(file_path)
      expect(game.players[:player1].grid.flatten.count('B')).to eq(5)
      expect(game.players[:player2].grid.flatten.count('B')).to eq(5)
    end

    it 'sets player moves correctly' do
      game.initialize_game(file_path)
      expect(game.players[:player1].moves).to eq([[0, 1], [4, 3], [2, 3], [3, 1], [4, 1]])
      expect(game.players[:player2].moves).to eq([[0, 1], [0, 0], [1, 1], [2, 3], [4, 3]])
    end
  end

  describe '#attack' do
    let(:player1) { Player.new(5) }
    let(:player2) { Player.new(5) }

    it 'registers hits and misses correctly' do
      game.initialize_game(file_path)
      game.attack(game.players[:player2], [[0, 1], [2, 2], [3, 1]])
      expect(game.players[:player2].grid[0][1]).to eq('X')
      expect(game.players[:player2].grid[2][2]).to eq('O')
      expect(game.players[:player2].grid[3][0]).to eq('B')
    end
  end

  describe '#split_input' do
    it 'converts input line to array of coordinates' do
      input_line = "1,1:2,0:2,3:3,4:4,3"
      result = game.split_input(input_line)
      expect(result).to eq([[1, 1], [2, 0], [2, 3], [3, 4], [4, 3]])
    end
  end

  describe '#output' do
    let(:output_file) { 'spec/fixtures/sample_output.txt' }

    it 'writes correct output to file' do
      game.initialize_game(file_path)
      game.play
      game.output(output_file)

      expected_output = <<~OUTPUT
        Player 1

        O O _ _ _
        _ X _ _ _
        B _ _ X _
        _ _ _ _ B
        _ _ _ X _

        Player 2

        _ X _ _ _
        _ _ _ _ _
        _ _ _ X _
        B O _ _ B
        _ X _ O _

        P1:3

        P2:3

        It is a draw
      OUTPUT

      expect(File.read(output_file).strip.inspect).to eq(expected_output.strip.inspect)
    end
  end
end