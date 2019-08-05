#! /usr/bin/env ruby
# frozen_string_literal:true

require 'yaml'

MESSAGES = YAML.load_file('rps.yml')
WELCOME = MESSAGES['welcome']
CHOICE_PROMPT = MESSAGES['choice_prompt']

VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  's' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }.freeze

def game_loading
  puts 'Loading game... Please wait'
  3.times do
    print '-----'
    sleep(1)
  end
end

def prompt(message)
  puts "=> #{message}"
end

def user_choice
  abbrev_choice = ''
  loop do
    print CHOICE_PROMPT
    print '==> '

    abbrev_choice = gets.chomp.downcase

    break VALID_CHOICES[abbrev_choice] if VALID_CHOICES.include?(abbrev_choice)

    prompt('Invalid choice')
  end

  VALID_CHOICES[abbrev_choice]
end

def display_picks(choice, computer_choice)
  puts "\nChoices:\n"\
    "You:#{format('%11s', choice)}\n"\
    "Computer: #{computer_choice}\n\n"
end

def player1_win?(player1, player2)
  options = { 'scissors' => %w[paper lizard],
              'spock' => %w[scissors rock],
              'lizard' => %w[paper spock],
              'rock' => %w[scissors lizard],
              'paper' => %w[spock rock] }.freeze

  options[player1].include?(player2)
end

def update_scores!(player, computer, scores)
  if player1_win?(player, computer)
    scores[:you] += 1
  elsif player1_win?(computer, player)
    scores[:computer] += 1
  end
end

def max_score_reached?(score)
  score.max_by { |_k, v| v }[1] == MAX_SCORE
end

def display_round_result(player, computer)
  if player1_win?(player, computer)
    puts "You won this round!\n"
  elsif player1_win?(computer, player)
    puts "Computer won this round!\n"
  else prompt('Tie!')
  end
end

def display_scores(scores)
  puts "\n***  SCORES: ***\n" \
       "You: #{format('%6s', scores[:you])}\n"\
       "Computer: #{scores[:computer]}"\
       "\n****************\n\n"\
end

def display_grand_winner(scores)
  puts "Grand Winner: #{scores.max_by { |_k, v| v }[0]}!! \n\n"
end

# Game play:
loop do
  game_loading
  system('clear')
  print WELCOME

  scores = { you: 0, computer: 0 }
  MAX_SCORE = 5

  until max_score_reached?(scores) # Loop for rounds
    puts '-' * 30

    choice = user_choice
    computer_choice = VALID_CHOICES.values.sample

    puts '-' * 30
    display_picks(choice, computer_choice)
    display_round_result(choice, computer_choice)

    update_scores!(choice, computer_choice, scores)
    display_scores(scores)
  end

  display_grand_winner(scores)

  prompt('Play again? (y/n)')
  print '==> '
  play_again = gets.chomp.downcase
  break if %w[n no].include?(play_again)
  next if %w[y yes].include?(play_again)

  break puts "Didn't understand that..."
end

puts "\nBuh bye!!\n\n"
