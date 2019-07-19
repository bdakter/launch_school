#! /usr/bin/env ruby

# idiomatically
def average(ary)
  ary.reduce(:+).to_f / ary.size
end

# manually
# def average(ary)
#   total = 0
#   ary.each { |i| total += i }
#   total/ary.size
# end


puts average([1, 5, 87, 45, 8, 8]) == 25.66
puts average([9, 47, 23, 95, 16, 52]) == 40.33
