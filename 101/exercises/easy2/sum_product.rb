#! /usr/bin/env ruby

print 'Pos int: >> '
num = gets.chomp.to_i

print '(S)um or (P)roduct? >> '
operation = gets.chomp.downcase

array = (1..num).to_a

message = ''
result = case operation
         when 's'
           message = 'sum'
           array.reduce(:+)
         when 'p'
           message = 'product'
           array.reduce(:*)
         end

puts "The #{message} of numbers between 1 and #{num} is #{result}."
