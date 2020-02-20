#! /usr/bin/env ruby
# frozen_string_literal: true

module TTT
  # Game Board
  class Board
    WINNING_POSITIONS =
      [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],  # rows
        [1, 4, 7], [2, 5, 8], [3, 6, 9],  # columns
        [1, 5, 9], [3, 5, 7]              # Diag
      ].freeze

    attr_accessor :board

    def initialize
      @squares = {}
      reset
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def draw
      puts
      puts '     |     |'
      puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
      puts '     |     |'
      puts '-----+-----+-----'
      puts '     |     |'
      puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
      puts '     |     |'
      puts '-----+-----+-----'
      puts '     |     |'
      puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
      puts '     |     |'
      puts
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def squares(sqr)
      @squares[sqr]
    end

    def []=(sqr, marker)
      @squares[sqr].marker = marker
    end

    def unmarked_keys
      @squares.select { |_, v| v.unmarked? }.keys
    end

    def full?
      unmarked_keys.empty?
    end

    # Determines existence of a winner
    def someone_won?
      !!winnning_marker
    end

    # Input array of square objects, returns count of markers
    def count_human_marker(squares)
      squares.map(&:marker).count(TTTPlay::HUMAN_MARKER)
    end

    def count_computer_marker(squares)
      squares.map(&:marker).count(TTTPlay::COMPUTER_MARKER)
    end

    # Returns winning marker or nil
    def winnning_marker
      WINNING_POSITIONS.each do |line|
        if count_human_marker(@squares.values_at(*line)) == 3
          return TTTPlay::HUMAN_MARKER
        end
        if count_computer_marker(@squares.values_at(*line)) == 3
          return TTTPlay::COMPUTER_MARKER
        end
      end

      nil
    end

    def open_third_square_computer
      WINNING_POSITIONS.each do |line|
        if count_computer_marker(@squares.values_at(*line)) == 2
          return line.select { |e| @squares[e].marker == Square::INITIAL_MARKER }.first
        end
      end

      nil
    end

    def open_third_square_human
      WINNING_POSITIONS.each do |line|
        if count_human_marker(@squares.values_at(*line)) == 2
          return line.select { |e| @squares[e].marker == Square::INITIAL_MARKER }.first
        end
      end

      nil
    end

    def square_5
      5 if unmarked_keys.include?(5)
    end

    def reset
      (1..9).each { |key| @squares[key] = Square.new }
    end
  end

  # Individual squares
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

  # Players
  class Player
    attr_reader :marker

    def initialize(marker)
      @marker = marker
    end
  end

  # Orchestrator class
  class TTTPlay
    HUMAN_MARKER = 'X'
    COMPUTER_MARKER = 'O'
    INITIAL_PLAYER = HUMAN_MARKER

    attr_reader :board, :human, :computer

    def initialize
      @board = Board.new
      @human = Player.new(HUMAN_MARKER)
      @computer = Player.new(COMPUTER_MARKER)
      @current_player = INITIAL_PLAYER
    end

    def player_loop
      loop do
        current_player_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
    end

    def play
      clear
      display_welcome_message

      # Manin game loop
      loop do
        display_board
        player_loop
        display_result

        break unless play_again?

        game_reset
        display_play_again
      end

      display_goodbye_message
    end

    private

    def display_welcome_message
      puts
      puts 'Welcome to TTT'
      puts
    end

    def clear
      system('clear')
    end

    def display_board
      puts "You: #{human.marker}. Computer: #{computer.marker}."
      board.draw
    end

    def clear_screen_and_display_board
      clear
      display_board
    end

    def display_goodbye_message
      puts
      puts 'Thanks for playing'
      puts
    end

    def display_result
      clear_screen_and_display_board

      puts  case board.winnning_marker
            when human.marker
              'You won!'
            when computer.marker
              'Computer won!'
            else
              'Board full'
            end
    end

    def current_player_moves
      if @current_player == HUMAN_MARKER
        human_moves
        @current_player = COMPUTER_MARKER
      else
        computer_moves
        @current_player = HUMAN_MARKER
      end
    end

    # Formats prompt choices nicely
    def joinor(ary, delimiter = ', ', last_word = 'or')
      return ary.first if ary.size == 1
      return "#{ary.first} #{last_word} #{ary.last}" if ary.size == 2

      last_element = ary.pop
      ary << ''

      "#{ary.join(delimiter)}"\
      "#{last_word} "\
      "#{last_element}"
    end

    def prompt_human_player
      puts "Choose a square #{joinor(board.unmarked_keys)}: "
    end

    def human_moves
      prompt_human_player
      square = nil

      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)

        puts 'Invalid choice'
      end

      board[square] = human.marker
    end

    def human_turn?
      @current_player == HUMAN_MARKER
    end

    # Intelligence for computer move
    def computer_moves
      move =  (board.open_third_square_computer ||
              board.open_third_square_human ||
              board.square_5 ||
              board.unmarked_keys.sample)

      board[move] = computer.marker
    end

    def play_again?
      puts 'Play again?: '
      ans = nil

      loop do
        ans = gets.chomp.downcase

        break if %(y n).include?(ans)

        puts 'Invalid choice.'
      end

      ans == 'y'
    end

    def game_reset
      board.reset
      system 'clear'
      @current_player = INITIAL_PLAYER
    end

    def display_play_again
      puts "Let's play again"
    end
  end
end

TTT::TTTPlay.new.play
