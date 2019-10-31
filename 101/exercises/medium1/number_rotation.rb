#! /usr/bin/env ruby

def rotate_array(ary)
  new_ary = ary.dup
  new_ary << new_ary.shift
  new_ary
end

def rotate_rightmost_digits(int, tail_int)
  digits = int.to_s.chars
  first_part = digits[0...-tail_int]
  second_part = digits[-tail_int..-1]
  rotated = rotate_array(second_part)
  (first_part + rotated).join.to_i
end

def max_rotation(int)
  max_cycles = int.to_s.size
  max_cycles.times do |i|
    int = rotate_rightmost_digits(int,-i)
  end
  int

end

puts max_rotation(105) == 15 # the leading zero gets dropped
puts max_rotation(735291) == 321579
puts max_rotation(35) == 53
puts max_rotation(3) == 3
puts max_rotation(8_703_529_146) == 7_321_609_845