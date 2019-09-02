#! /usr/bin/env ruby

SPELLED_INTS =
  %w[zero, one, two, three, four, five, six, seven, eight, nine,
  ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen,
  eighteen, nineteen]

def alphabetic_number_sort_by(ary)
  ary_hash = {}
  ary.each { |e| ary_hash[e] = SPELLED_INTS[e] }
  ary_hash.sort_by { |_k, v| v }.to_h.keys
end
puts alphabetic_number_sort_by((0..19).to_a) ==
     [8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17, 6, 16, 10, 13, 3, 12, 2, 0]

def alphabetic_number_sort(ary)
  ary.sort { |a, b| SPELLED_INTS[a] <=> SPELLED_INTS[b] }
end

puts alphabetic_number_sort((0..19).to_a) ==
     [8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17, 6, 16, 10, 13, 3, 12, 2, 0]
