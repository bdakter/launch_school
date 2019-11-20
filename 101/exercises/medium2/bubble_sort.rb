#! /usr/bin/env ruby

def bubble_sort!(array)
  loop do
    swap_flag = false
    first_index = 0
    second_index = first_index + 1

    while second_index < array.size
      if array[first_index] > array[second_index]
        array[second_index], array[first_index] = array[first_index..second_index] 
        swap_flag = true
      end

      first_index += 1
      second_index = first_index+1
    end

    break if swap_flag == false
  end

end

array = [5, 3]
bubble_sort!(array)
puts array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
puts array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
puts array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
