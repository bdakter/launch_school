#! /usr/bin/env ruby

def palindrome?(str)
  str == str.reverse
end

def real_palindrome?(str)
  str = str.downcase.gsub(/\W/, '')
  palindrome?(str)
end

puts palindrome?('madam') == true
puts palindrome?('Madam') == false
puts palindrome?("madam i'm adam") == false
puts palindrome?('356653') == true
puts palindrome?([1, 2, 1]) == true
puts palindrome?(['a', 'b', 'c', 'b']) == false

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true
puts real_palindrome?("Madam, I'm Adam") == true
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false
