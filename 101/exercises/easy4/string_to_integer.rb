#! /usr/bin/env ruby

NUMBERS = { '1' => 1, '2' => 2, '3' => 3, '4' => 4,
            '5' => 5, '6' => 6, '7' => 7, '8' => 8,
            '9' => 9, '0' => 0, 'A' => 10, 'B' => 11,
            'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15 }.freeze

def string_to_integer(str)
  running_num = 0
  str.chars.map do |c|
    integer = NUMBERS[c]
    running_num = running_num * 10 + integer
  end
  running_num
end

def hex_to_integer(str)
  running_num = 0
  str.chars.map do |c|
    integer = NUMBERS[c]
    running_num = running_num * 16 + integer
  end
  running_num
end

puts string_to_integer('321') == 321
puts string_to_integer('4321') == 4321
puts string_to_integer('570') == 570
puts string_to_integer('1234') == 1234

puts hex_to_integer('21') == 33
puts hex_to_integer('F') == 15
puts hex_to_integer('10') == 16
puts hex_to_integer('20') == 32
puts hex_to_integer('4D9F') == 19871
