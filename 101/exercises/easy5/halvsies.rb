#! /usr/bin/env ruby

def halvsies(ary)
  first_half = ary.size / 2
  first_half += 1 if ary.size.odd?

  [ary.slice(0...first_half), ary.slice(first_half..-1)]
end

puts halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
puts halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
puts halvsies([5]) == [[5], []]
puts halvsies([]) == [[], []]
