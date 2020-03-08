#! /usr/bin/env ruby

class Card
  include Comparable

  attr_reader :rank, :suit

  SUITS = %w[Spades Hearts Clubs Diamonds]

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    ranking <=> other.ranking
  end

  def ranking
    case rank
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    else rank
    end
  end

end

class Deck
  attr_reader :cards
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    build_new_deck    
  end

  def build_new_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end

    cards.shuffle!
  end

  def draw
    build_new_deck if @cards.empty?
    cards.pop
  end

  def to_s
    cards.each {|card| puts card}
  end

end

class PokerHand
  attr_reader :hand

  def initialize(deck)
    @hand = []
    5.times{@hand << deck.draw}
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private
  
  def hand_ranks
    hand.sort.map(&:rank)
  end
  
  def hand_suits
    hand.map(&:suit)
  end

  def numerical_ranks
    hand.map(&:ranking).sort
  end
  
  def hand_tally
    hand_ranks.each_with_object(Hash.new(0)) { |e, tally| tally[e] += 1 }
  end

  def royal_flush?
    hand_suits.uniq.one? &&
    hand_ranks.all? { |card| ["Jack", "King", "Queen", "Ace", 10].include? card }
  end

  def straight_flush?
    hand_suits.uniq.one? &&
    numerical_ranks.chunk_while {|a,b| b-a == 1 }.one?
  end

  def four_of_a_kind?
    hand_tally.values.max == 4
  end

  def full_house?
    hand_tally.values.min == 2 &&
    hand_tally.values.max == 3
  end

  def flush?
    hand_suits.uniq.one? &&
    numerical_ranks.chunk_while {|a,b| b-a == 1 }.count > 1
  end

  def straight?
    hand_suits.uniq.count > 1 &&
    numerical_ranks.chunk_while {|a,b| b-a == 1 }.one?
  end

  def three_of_a_kind?
    hand_tally.values.max == 3
  end

  def two_pair?
    hand_tally.values.max(2).all? {|e| e == 2}
  end

  def pair?
    hand_tally.values.max == 2
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# # Danger danger danger: monkey
# # patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
