#! /usr/bin/env ruby

def merge(ary1, ary2)
  return ary1 if ary2.empty?
  return ary2 if ary1.empty?

  array1_idx = 0
  array2_idx = 0
  results = []

  loop do
    current_1 = ary1[array1_idx]
    current_2 = ary2[array2_idx]
    if current_2.nil? || current_1 <= current_2
      results << current_1
      array1_idx += 1

    elsif current_1.nil? || current_2 < current_1
      results << current_2
      array2_idx += 1

    end

    break if array1_idx >= ary1.size && array2_idx >= ary2.size
  end

  results
end

p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]
