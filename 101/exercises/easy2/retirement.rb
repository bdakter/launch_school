#! /usr/bin/env ruby
require 'date'

print 'Age?>> '
current_age = gets.chomp.to_i

print 'Retirement age?>> '
retirement_age = gets.chomp.to_i

difference = retirement_age - current_age
current_year = Date.today.year
retirement_year = current_year + difference

puts "It's #{current_year}. Retirement in #{retirement_year}." 
puts "#{difference} years to go. Good luck with that."
