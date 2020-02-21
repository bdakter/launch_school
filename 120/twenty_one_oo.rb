#! /usr/bin/env ruby

module Hand
  attr_accessor :cards

  def hit

  end

  def stay

  end

  def add_card_to_hand(card)
    cards << card
  end

  # Transforms array of card objects to english descriptions
  def card_descriptions
    cards.map(&:to_s)
  end

  def faces
    cards.map(&:face)
  end

  def show_hand_and_total
    puts "#{self.class}: #{card_descriptions.join(', ')}. Total: #{total}"
  end

  def busted?
    total > 21
  end

  def total  
# require 'pry'; binding.pry
    regulars, aces = faces.partition { |e| e != 'ace' }
    sum = 0

    regulars.each do |card|
      sum += card.instance_of?(Integer) ? card : 10
    end

    aces.each do
      sum += (sum <= 10 ? 11 : 1)
    end

    sum
  end

end



class Human
  include Hand

  def initialize
    @cards = []

  end


  def show_initial_cards
    show_hand_and_total
  end

end

class Dealer
  include Hand

  def initialize
    @cards = []
  end

  def show_initial_cards
    puts "#{self.class}: #{@cards.sample}"
  end

  def under_17?
    total <= 17
  end

end




class Deck
  attr_accessor :cards

  SUITS = %w[hearts spades diamonds clubs]
  FACES = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'king', 'queen', 'ace']


  def initialize
    @cards = []

    SUITS.each do |s|
      FACES.each do |f|
        @cards << Card.new(s, f)
        
      end
    end

    @cards.shuffle!
  end

  def deal
    @cards.pop
  end

  def card_value

  end
end




class Card
  attr_accessor :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{face} of #{suit}"
  end

end



# Orchestrator engine
class Game
  attr_accessor :human, :dealer, :deck

  def initialize
    @human = Human.new
    @dealer = Dealer.new
    @deck = Deck.new

  end

  def print_welcome_message
    system 'clear'
    puts ''
    puts 'Welcome to 21'
    puts 'First one over 21 loses!'
    puts ''
  end

  def deal_cards
    2.times do
      human.add_card_to_hand(deck.deal)
      dealer.add_card_to_hand(deck.deal)
    end
  end

  def show_initial_hands
    [human, dealer].each { |player| player.show_initial_cards }
  end

  def prompt_human
    puts ''
    puts "Hit or Stay (H/S): "
    response = nil
    loop do
      response = gets.chomp.downcase
      break if %w[h s].include? response
      puts 'Invalid choice.'
      print '=> '
    end

    response
  end

  def human_turn
    loop do
      response = prompt_human

      if response == 'h'
        human.add_card_to_hand(deck.deal)
        human.show_hand_and_total
        break if human.busted?
      
      else
        break
      end
    end
  end

  def dealer_turn
    unless human.busted?
      while dealer.under_17?
        dealer.add_card_to_hand(deck.deal)
        break if dealer.busted?
      end
    end

  end

  def highest_score
    case human.total <=> dealer.total
    when 1
      puts 'Human won'
    when -1
      puts 'Dealer won'
    else
      puts 'Tie'
    end
  end

  def show_result
    puts ''
    puts '--------------------------------'
    puts 'RESULTS:'
    human.show_hand_and_total
    dealer.show_hand_and_total
    puts ''

    if human.busted?
      puts "Human busted!"
    elsif
      dealer.busted?
      puts "Dealer busted!"
    else
      highest_score
    end
  end

  def print_goodbye
    puts ''
    puts 'Thanks for playing with fate...'
    puts ''
  end

  def start
    print_welcome_message
    deal_cards
    show_initial_hands
    human_turn
    dealer_turn
    show_result
    print_goodbye
  end
end

Game.new.start

# d = Deck.new

