#! /usr/bin/env ruby
# frozen_string_literal: true

class Player
  attr_accessor :choice
end

class Target
  attr_reader :number

  def initialize(start_int, end_int)
    @number = rand(start_int..end_int)
  end

  def hint(guess)
    if guess < number
      puts 'Too low'
    elsif guess > number
      puts 'Too high'
    else
      puts 'Jackpot!'
    end
  end
end

# Orchestrator engine
class Game
  attr_accessor :player, :target, :guesses_left
  attr_reader :start, :stop

  def initialize(start = 1, stop = 100)
    @start = start
    @stop = stop
    range_size = stop - start

    # Gives fair number of chances
    @guesses_left = Math.log2(range_size).to_i + 1
    @player = Player.new
    @target = Target.new(start, stop)
  end

  def print_welcome
    puts ''
    puts 'Welcome to Pick a Number!'
  end

  def show_remaining_guesses
    puts ''
    puts "#{guesses_left} guesses left."
  end

  def prompt_user
    loop do
      print "Enter number between #{start} and #{stop}: "
      player.choice = gets.chomp.to_i
      break if (start..stop).include? player.choice

      print 'Invalid guess. '
    end
  end

  def prompt_user_and_decrease_guesses
    prompt_user
    self.guesses_left -= 1
  end

  def guesses_remaining?
    guesses_left > 0
  end

  def print_results
    if won?
      puts 'You won!'
    else
      puts 'You lost!'
    end
  end

  def won?
    player.choice == target.number
  end

  def print_goodbye
    puts 'Thanks for playing!'
  end

  def play
    print_welcome
    loop do
      show_remaining_guesses
      prompt_user_and_decrease_guesses
      target.hint(player.choice)
      break if won? || !guesses_remaining?
    end

    print_results
  end
end

g = Game.new(501, 1500)
g.play
