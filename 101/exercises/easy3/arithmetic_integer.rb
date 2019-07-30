#! /usr/bin/env ruby

puts "First int: >> "
first_int = gets.chomp.to_i

puts "Second int: >> "
second_int = gets.chomp.to_i

operations = [:+, :-, :*, :/, :%, :**]
operations.each do |operation|
  result = first_int.public_send(operation, second_int)
  puts "==> #{first_int} #{operation} #{second_int} = #{result}."
end
