#! /usr/bin/env ruby

class Board
  WINNING_POSITIONS =
    [
      [1, 2, 3], [4, 5, 6], [7, 8, 9],  # rows
      [1, 4, 7], [2, 5, 8], [3, 6, 9],  # columns
      [1, 5, 9], [3, 5, 7]              # Diag
    ]

  attr_accessor :board

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square(sq)
    @squares[sq]
  end

  def set_square_to(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.select { |_,v| v.unmarked?}.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def detect_winner
    first_square = nil

    WINNING_POSITIONS.each  do |subarray|
      first_square_marker = @squares[subarray[0]].marker if [TTTPlay::HUMAN_MARKER, TTTPlay::COMPUTER_MARKER].include?( @squares[subarray[0]].marker)

      return first_square_marker if subarray.all? {|e| @squares[e].marker == first_square_marker}
    end
    nil
  end

  def someone_won?
    !!detect_winner
  end

end

class Square
  
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

end

class TTTPlay
 
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
 
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts ''
    puts "Welcome to TTT"
    puts ""
  end

  def display_board
    system('clear')
    puts "You: #{human.marker}. Computer: #{computer.marker}."
    puts ''
    puts '     |     |'
    puts "  #{@board.get_square(7)}  |  #{@board.get_square(8)}  |  #{@board.get_square(9)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@board.get_square(4)}  |  #{@board.get_square(5)}  |  #{@board.get_square(6)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@board.get_square(1)}  |  #{@board.get_square(2)}  |  #{@board.get_square(3)}"
    puts '     |     |'
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing"
    puts ''
  end

  def display_result
    display_board
    
    if board.someone_won?
      puts "You won!" if board.detect_winner == HUMAN_MARKER
      puts "Computer won!" if board.detect_winner == COMPUTER_MARKER
    else
      puts "Board full"
    end
  end

  def human_moves
    puts "Choose a square #{board.unmarked_keys.join(', ')}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Invalid choice"
    end 

    board.set_square_to(square, human.marker)
  end

  def computer_moves
    board.set_square_to(board.unmarked_keys.sample, computer.marker)
  end

  def play
    
    display_welcome_message

    loop do
      display_board
      
      human_moves
      display_board
      break if board.someone_won? || board.full? 

      computer_moves
      break if board.someone_won? || board.full?  

      display_board

    end

    display_result
    display_goodbye_message
    
  end
end

TTTPlay.new.play
