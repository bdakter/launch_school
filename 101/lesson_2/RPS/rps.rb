#! /usr/bin/env ruby
require 'yaml'

MESSAGES = YAML.load_file('rps.yml')
WELCOME = MESSAGES['welcome']
CHOICE_PROMPT = MESSAGES['choice_prompt']

VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  's' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

def prompt(message)
  puts "=> #{message}"
end

def user_choice
  abbrev_choice = ''
  loop do
    print CHOICE_PROMPT
    abbrev_choice = gets.chomp.downcase

    break VALID_CHOICES[abbrev_choice] if VALID_CHOICES.include?(abbrev_choice)
    prompt("Invalid choice")
  end

  VALID_CHOICES[abbrev_choice]
end

def display_choices(choice, computer_choice)
  puts "\nChoices:\n"\
    "You:#{format('%11s', choice)}\n"\
    "Computer: #{computer_choice}\n\n"
end

def player1_win?(player1, player2)
  options = { 'scissors' => %w(paper lizard),
              'spock' => %w(scissors rock),
              'lizard' => %w(paper spock),
              'rock' => %w(scissors lizard),
              'paper' => %w(spock rock) }

  options[player1].include?(player2)
end

def update_scores(player, computer, scores)
  if player1_win?(player, computer)
    scores[:you] += 1
  elsif player1_win?(computer, player)
    scores[:computer] += 1
  end

  scores
end

def display_result(player, computer)
  if player1_win?(player, computer)
    puts "You won this round!\n"
  elsif player1_win?(computer, player)
    puts "Computer won this round!\n"
  else prompt("Tie!")
  end
end

def display_scores(scores)
  puts "\n***  SCORES: ***\n" \
       "You: #{format('%6s', scores[:you])}\n"\
       "Computer: #{scores[:computer]}"\
       "\n****************\n\n"\
end

def display_grand_winner(scores)
  player1, player2 = scores.minmax_by { |_k, v| v }
  if player1[1] == player2[1]
    puts "Tie!"
  else puts "Grand Winner: #{scores.max_by { |_k, v| v }[0]}!! \n\n"
  end
end

# Game play:
loop do
  system('clear')
  print WELCOME

  scores = { you: 0, computer: 0 }
  round_counter = 1
  while round_counter < 6 # Loop for rounds
    puts '-' * 30
    puts "Round # #{round_counter}:\n".center(20)

    choice = user_choice()
    computer_choice = VALID_CHOICES.values.sample
    puts '-' * 30
    display_choices(choice, computer_choice)

    display_result(choice, computer_choice)

    scores = update_scores(choice, computer_choice, scores)
    display_scores(scores)

    round_counter += 1
  end

  display_grand_winner(scores)

  prompt("Play again? (y/n)")
  play_again = gets.chomp.downcase
  break if ['n', 'no'].include?(play_again)
  next if ['y', 'yes'].include?(play_again)
  puts "Didn't understand that..."
  break
end

puts "\nBuh bye!!\n\n"
