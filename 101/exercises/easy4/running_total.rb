#! /usr/bin/env ruby

def running_total(ary)
  running_sum = 0
  ary.map { |i| running_sum += i }
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []

def running_total(ary)
  running_ary = []
  ary.map do |i|
    running_ary << i
    running_ary.inject(:+)
  end
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []

# TODO: fix this
# def running_total(ary)
#   require 'pry'; binding.pry
#   running_sum = 0
#   ary.map!.each_with_object(running_sum) { |e,o|  o += e }
#   ary
# end
