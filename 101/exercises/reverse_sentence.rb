#! /usr/bin/env ruby

def idiomatic_reverse_sentence(str)
  str.split.reverse.join(' ')
end

def manual_reverse_sentence(str)
  array = str.split
  rev_array = []
  array.each { |i| rev_array.unshift(i) }
  rev_array.join(' ')

end


puts idiomatic_reverse_sentence('') == ''
puts idiomatic_reverse_sentence('Hello World') == 'World Hello'
puts idiomatic_reverse_sentence('Reverse these words') == 'words these Reverse'


puts manual_reverse_sentence('') == ''
puts manual_reverse_sentence('Hello World') == 'World Hello'
puts manual_reverse_sentence('Reverse these words') == 'words these Reverse'