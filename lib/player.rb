class Player
  attr_accessor :grid, :moves, :hits_count

  # Alive attleships denoted with “B”
  # Dead Battleships with “X” 
  # Missile Missed Locations “O”

  def initialize(grid_size)
    @grid_size = grid_size
    # Initializing the array grid with underscore('-')
    @grid = Array.new(grid_size) { Array.new(grid_size, '_') }
    @moves = []
    @hits_count = 0
  end

  def deploy_ships(positions)
    positions.each do |x, y|
      next unless valid_condinates?(x,y)
      # Replacing underscore to 'B' for valid ship deployments
      @grid[x][y] = "B"
    end
  end

  def attack(x, y)
    return unless valid_condinates?(x,y)

    if @grid[x][y] == "B"
      @hits_count += 1
      # Replacing 'B' to 'X' for valid attacks from opponents
      @grid[x][y] = "X"
    else
      # Replacing the cell by 'O' for missile missed location.
      @grid[x][y] = "O"
    end
  end

  private

  # This is validating the coordinates.
  def valid_condinates?(x,y)
    (x && y) && (x < 0 || y < 0 || x >= @grid_size || y >= @grid_size) ? false : true
  end
end
