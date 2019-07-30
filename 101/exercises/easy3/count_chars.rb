#! /usr/bin/env ruby

puts 'Enter string: >>'
string = gets.chomp

char_count = string.delete(' ').length

puts "There are #{char_count} char(s) in #{string}."
