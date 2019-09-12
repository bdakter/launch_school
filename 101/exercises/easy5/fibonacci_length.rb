#! /usr/bin/env ruby

def find_fibonacci_index_by_length(int)
  fibo_array = [1]
  previous = 0
  current = 1
  next_num = 0
  loop do
    next_num = current + previous
    fibo_array << next_num

    break if next_num.to_s.size >= int

    previous, current = current, next_num
  end
  fibo_array.size
end

puts find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
puts find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
puts find_fibonacci_index_by_length(10) == 45
puts find_fibonacci_index_by_length(100) == 476
puts find_fibonacci_index_by_length(1000) == 4782
puts find_fibonacci_index_by_length(10000) == 47847
