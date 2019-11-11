#! /usr/bin/env ruby
# frozen_string_literal: true

WINNING_POSITIONS =
  [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],  # rows
    [1, 4, 7], [2, 5, 8], [3, 6, 9],  # columns
    [1, 5, 9], [3, 5, 7]              # Diag
  ].freeze

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMP_MARKER = 'O'

def initialize_board
  (1..9).each_with_object({}) { |i, o| o[i] = INITIAL_MARKER }
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd)
  system('clear')

  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def available_moves(brd)
  brd.select { |_k, v| v == ' ' }.keys
end

def joinor(ary, delimiter = ', ', joiner = 'or')
  return ary.first.to_s if ary.size == 1

  last = ary.pop.to_s
  ary << '' if ary.size > 1   # Forces delimiter after penultimate item

  "#{ary.join(delimiter)}#{' ' if ary.size == 1}#{joiner} #{last}"
end

def player_move!(brd)
  move = ''
  loop do
    puts "Pick a square from #{joinor(available_moves(brd))}: "
    move = gets.chomp.to_i
    break if available_moves(brd).include?(move)

    puts 'invalid move'
  end

  brd[move] = PLAYER_MARKER
end

def find_third_square(brd, piece)
  WINNING_POSITIONS.each_with_object([]) do |line, ary|
    ary << line[2] if [brd[line[0]], brd[line[1]]].all? { |i| i == piece }
    ary << line[0] if [brd[line[1]], brd[line[2]]].all? { |i| i == piece }
  end
end

def computer_move!(brd)
  offensive = find_third_square(brd, COMP_MARKER).detect do |square|
    available_moves(brd).include?(square)
  end

  defensive = find_third_square(brd, PLAYER_MARKER).detect do |square|
    available_moves(brd).include?(square)
  end

  square_five = 5 if available_moves(brd).include?(5)

  move = offensive || defensive || square_five || available_moves(brd).sample
  brd[move] = COMP_MARKER
end

def place_piece!(brd, current_player)
  current_player == 'Player' ? player_move!(brd) : computer_move!(brd)
end

def alternate_players(current_player)
  %w[Player Computer].reject { |p| p == current_player }.first
end

def display_winner(brd)
  WINNING_POSITIONS.each do |line|
    return 'Player'   if brd.values_at(*line).all? { |v| v == PLAYER_MARKER }
    return 'Computer' if brd.values_at(*line).all? { |v| v == COMP_MARKER }
    # return nil
  end
  nil
end

def winner?(brd)
  !!display_winner(brd)
end

def tie?(brd)
  available_moves(brd).empty?
end

# Main game loop
loop do
  tracker = { 'Player' => 0, 'Computer' => 0 }

  # Rounds loop
  loop do
    board = initialize_board
    display_board(board)
    current_player = 'Player'

    # Players loop
    loop do
      place_piece!(board, current_player)
      current_player = alternate_players(current_player)
      display_board(board)
      break if winner?(board) || tie?(board)
    end

    display_board(board)
    if winner?(board)
      puts "#{display_winner(board)} won!"
      tracker[display_winner(board)] += 1
    else
      puts 'Tie!'
    end
    puts "Scores: #{tracker}"
    break if tracker.values.max == 5
  end

  puts 'Play again? (Y/N)'
  break unless gets.chomp.downcase == 'y'
end

puts 'Thanks for playing!'
