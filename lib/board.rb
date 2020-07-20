class Board
  attr_accessor :cells

  @calls = []

  def initialize
    self.cells = Array.new(9, " ")
  end

  def reset!
    self.cells = Array.new(9, " ")
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def position(user_input)
    input = user_input.to_i - 1
    self.cells[input]
  end

  def full?
    self.cells.all? do |cell| 
      cell == "X" || cell == "O"
    end
  end

  def turn_count
    self.cells.count("X") +
    self.cells.count("O")
  end

  def taken?(position)
    real_position = position.to_i - 1
    self.cells[real_position] == "X" ||
    self.cells[real_position] == "O"
  end

  def valid_move?(position)
    real_position = position.to_i
    !taken?(position) && real_position > 0 && real_position <=9
  end

  def update(position, player)
    real_position = position.to_i - 1
    self.cells[real_position] = player.token
  end
end 