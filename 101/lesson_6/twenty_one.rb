#! /usr/bin/env ruby

HAND_MAX = 21

def hand_total(ary)
  regulars, aces = ary.partition { |e| e != 'ace' }
  total = 0

  regulars.each do |card|
    total += card.is_a?(Integer) ? card : 10
  end

  aces.each do
    total += total <= 10 ? 11 : 1
  end

  total
end

def hit(contestant, deck)
  contestant << deck.pop
end

def bust?(hand)
  hand_total(hand) > HAND_MAX
end

def show_hand(name, contestant_cards)
  puts "#{name}'s cards: #{contestant_cards.join(', ')}. "\
    "Total: #{hand_total(contestant_cards)}"
end

def highest_points(player, dealer)
  case hand_total(player) <=> hand_total(dealer)
  when 1 then 'Player'
  when -1 then 'Dealer'
  else 'Tie'
  end
end

def print_game_result(player, dealer)
  result = if bust?(player)
             "You busted. Dealer wins!"
           elsif bust?(dealer)
             "Dealer busted. You win!"
           elsif highest_points(player, dealer) == 'Dealer'
             "Dealer wins!"
           elsif highest_points(player, dealer) == 'Player'
             "You win!"
           else 'Tie :('
           end

  puts result
end


# GAME PLAY
loop do
  deck = (([*2..10] + ['jack', 'queen', 'king', 'ace']) * 4).shuffle!
  player = deck.pop(2)
  dealer = deck.pop(2)

  # player turn
  puts "\nDealer's card: #{dealer.sample}"

  loop do
    show_hand('Player', player)
    print "\n(H)it or (S)tay? => "
    response = gets.downcase
    puts

    hit(player, deck) if response.start_with?('h')
    break if bust?(player) || response.start_with?('s')
  end

  # dealer turn
  unless bust?(player)
    loop do
      break if hand_total(dealer) >= 17
      hit(dealer, deck)
    end
  end

  show_hand('Player', player)
  show_hand('Dealer', dealer)
  print_game_result(player, dealer)

  print "\nPlay again? (Y/N) => "
  response = gets.chomp.downcase
  break unless response.start_with?('y')
end

puts 'Ta da!'
