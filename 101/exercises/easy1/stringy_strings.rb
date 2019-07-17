#! /usr/bin/env ruby

def stringy(int, start = 1)
  other_digit = [1, 0].drop(start)[0]
  string = []
  int.times do |i|
    string << (i.even? ? start : other_digit)
  end
  string.join
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'

puts stringy(6, 0) == '010101'
puts stringy(9, 0) == '010101010'
puts stringy(4, 0) == '0101'
puts stringy(7, 0) == '0101010'
