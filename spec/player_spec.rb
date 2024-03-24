require './lib/player.rb'

RSpec.describe Player do
  let(:grid_size) { 5 }
  let(:player) { Player.new(grid_size) }

  describe '#initialize' do
    it 'initializes grid with correct size' do
      expect(player.grid.size).to eq(grid_size)
      expect(player.grid.all? { |row| row.size == grid_size }).to be true
    end

    it 'initializes moves array' do
      expect(player.moves).to eq([])
    end

    it 'initializes hits_count to zero' do
      expect(player.hits_count).to eq(0)
    end
  end

  describe '#deploy_ships' do
    it 'deploys ships correctly' do
      positions = [[1, 1], [2, 2]]
      player.deploy_ships(positions)
      expect(player.grid[1][1]).to eq('B')
      expect(player.grid[2][2]).to eq('B')
    end

    it 'does not deploy ships for invalid coordinates' do
      positions = [[-1, 1], [2, 6], [5, 3]]
      player.deploy_ships(positions)
      expect(player.grid.flatten).to all(eq('_'))
    end
  end

  describe '#attack' do
    it 'registers hit if attack is on ship' do
      player.deploy_ships([[1, 1]])
      player.attack(1, 1)
      expect(player.hits_count).to eq(1)
      expect(player.grid[1][1]).to eq('X')
    end

    it 'registers missed attack if no ship at location' do
      player.attack(2, 2)
      expect(player.grid[2][2]).to eq('O')
    end

    it 'does not register hit or miss for invalid coordinates' do
      player.attack(-1, 1)
      player.attack(2, 6)
      expect(player.grid.flatten).to all(eq('_'))
    end
  end
end