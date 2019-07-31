#! /usr/bin/env ruby

def palindrome?(str)
  str == str.reverse
end

# def palindrome?(str)
#   rev_array = []
#   str_array = str.chars
#   rev_array << str_array.pop until str_array.empty?
#   rev_array.join == str
# end

puts palindrome?('madam') == true
puts palindrome?('Madam') == false
puts palindrome?("madam i'm adam") == false
puts palindrome?('356653') == true
puts palindrome?([1, 2, 1]) == true
puts palindrome?(['a', 'b', 'c', 'b']) == false
