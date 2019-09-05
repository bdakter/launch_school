#! /usr/bin/env ruby

# Iterative solution
def crunch(str)
  shortened_word = ''
  counter = 0
  while counter < str.size
    shortened_word << str[counter] if str[counter] != shortened_word[-1]
    counter += 1
  end
  shortened_word
end

puts crunch('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch('4444abcabccba') == '4abcabcba'
puts crunch('ggggggggggggggg') == 'g'
puts crunch('abbc') == 'abc'
puts crunch('a') == 'a'
puts crunch('') == ''

# Recursive solution
def crunch_recursive(str, shortened = '')
  return shortened if str.empty?

  current_char = str.slice!(-1)
  shortened.prepend(current_char) if current_char != shortened[0]
  crunch_recursive(str, shortened)
end

puts crunch_recursive('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch_recursive('4444abcabccba') == '4abcabcba'
puts crunch_recursive('ggggggggggggggg') == 'g'
puts crunch_recursive('abbc') == 'abc'
puts crunch_recursive('a') == 'a'
puts crunch_recursive('') == ''
