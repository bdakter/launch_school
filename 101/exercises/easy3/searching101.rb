#! /usr/bin/env ruby

array = Array.new(6)

def get_int
  puts "Enter a number:"
  gets.chomp.to_i
end

array.map! { |_| get_int }

array_body = array.slice(0..-2)
last_element = array[-1]
duplicate = array_body.include?(last_element)

message = duplicate ? 'appears' : 'does not appear'

puts "The number #{last_element} #{message} in #{array_body}."
