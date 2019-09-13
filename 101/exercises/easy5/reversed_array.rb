#! /usr/bin/env ruby

def reverse!(ary)
  counter = 0
  while counter < ary.size
    current = ary.slice!(counter)
    ary.prepend(current)
    counter += 1
  end
  ary
end

list = [1, 2, 3]
result = reverse!(list)
puts result == [3, 2, 1]
puts list == [3, 2, 1]
puts list.object_id == result.object_id

list = %w[a b e d c]
puts reverse!(list) == %w[c d e b a]
puts list == %w[c d e b a]

list = ['abc']
puts reverse!(list) == ['abc']
puts list == ['abc']

list = []
puts reverse!(list) == []
puts list == []
