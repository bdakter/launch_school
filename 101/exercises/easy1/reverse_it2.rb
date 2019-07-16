#! /usr/bin/env ruby

def reverse_words(str)
  str_array = str.split
  new_array = []

  str_array.each do |i|
    if i.length >= 5
      new_array << i.reverse
    else
      new_array << i
    end
  end

  new_array.join(' ')
end

puts reverse_words('Professional') == 'lanoisseforP'
puts reverse_words('Walk around the block') == 'Walk dnuora the kcolb'
puts reverse_words('Launch School')  == 'hcnuaL loohcS'
