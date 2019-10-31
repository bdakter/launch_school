#! /usr/bin/env ruby

def diamonds(int)
  sequence = 1.step(to: int, by: 2).to_a
  array = sequence + sequence.slice(0..-2).reverse

  array.each do |e|
    puts "#{'*' * e}".center(int)
  end
end

diamonds(5)
diamonds(9)
