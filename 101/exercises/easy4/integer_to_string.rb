#! /usr/bin/env ruby

INTEGER_LOOKUP = {
  0 => '0', 1 => '1', 2 => '2', 3 => '3', 4 => '4',
  5 => '5', 6 => '6', 7 => '7', 8 => '8', 9 => '9'
}.freeze

def integer_to_string(int)
  numeric_str = ''
  loop do
    int, smallest_digit = int.abs.divmod(10)
    numeric_str.prepend(INTEGER_LOOKUP[smallest_digit])
    break if int.zero?
  end

  numeric_str
end

puts integer_to_string(4321) == '4321'
puts integer_to_string(0) == '0'
puts integer_to_string(5000) == '5000'

def signed_to_string(int)
  string = integer_to_string(int)

  return string.prepend('+') if int.positive?
  return string.prepend('-') if int.negative?
  string
end

puts signed_to_string(4321) == '+4321'
puts signed_to_string(-123) == '-123'
puts signed_to_string(0) == '0'
