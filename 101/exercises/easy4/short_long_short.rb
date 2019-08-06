#! /usr/bin/env ruby

def short_long_short(str1, str2)
  short, long = [str1, str2].sort_by(&:size)
  short+long+short
end

puts short_long_short('abc', 'defgh') == "abcdefghabc"
puts short_long_short('abcde', 'fgh') == "fghabcdefgh"
puts short_long_short('', 'xyz') == "xyz"