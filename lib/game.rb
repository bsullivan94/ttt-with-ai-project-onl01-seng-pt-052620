class Game
  attr_accessor :board, :player_1, :player_2, :winner, :user_input

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    @board.display
  end

  def board
    @board
  end

  def current_player
     board.turn_count.odd? ? player_2 : player_1
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
        if @board.cells[combination[0]] == @board.cells[combination[1]] &&
          @board.cells[combination[1]] == @board.cells[combination[2]] &&
          @board.taken?(combination[0]+1)
          return combination
        end
      end
    return false
  end

  def draw?
    @board.full? && !won? ? true : false
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    if won?
      combination = won?
      @board.cells[combination[0]]
    end
  end

  def turn
    puts "Please enter a number 1-9:"
    @user_input = current_player.move(@board)
    if @board.valid_move?(@user_input)
      @board.update(@user_input, current_player)
    else puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end

  def play
    turn until over?
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
        
        def start
        puts "Hello! Welcome to Tic Tac Toe!"
        puts "AI Mode: Enter '0' into the terminal."
        puts "1-Player Mode: Enter '1' into the terminal."
        puts "2-Player Mode: Enter '2' into the terminal."
        mode = gets.chomp

        case mode.to_s
            when '0'
                game = Game.new(Players::Computer.new('X'), Players::Computer.new('O'), Board.new)
                game.play
                puts "Enter 'Y' to play again, or 'Exit' to exit."
                input = gets.chomp
                    if input == 'Y' || input == 'y'
                        start
                    end
            when '1'
                puts "'X' plays first. 'O' plays second. Enter 1 to play first, or 2 to play second:"
                input_order = gets.chomp
                if input_order.to_s == '1'
                    player_1 = Players::Human.new('X')
                    player_2 = Players::Computer.new('O')
                else
                    player_1 = Players::Computer.new('X')
                    player_2 = Players::Human.new('O')
                end
                game = Game.new(player_1, player_2, Board.new)
                game.play
                puts "Enter 'Y' to play again, or 'Exit' to exit."
                input = gets.chomp
                    if input == 'Y' || input == 'y'
                        start
                    end
            when '2'
                game = Game.new(Players::Human.new('X'), Players::Human.new('O'), Board.new)
                game.play
                puts "Enter 'Y' to play again, or 'Exit' to exit."
                input = gets.chomp
                    if input == 'Y' || input == 'y'
                        start
                    end
            when 'wargames'
                100.times { 
                    game = Game.new(Players::Computer.new('X'), Players::Computer.new('O'), Board.new)
                    game.play 
                    }
    end
  end
end 