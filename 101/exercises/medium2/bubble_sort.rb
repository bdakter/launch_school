#! /usr/bin/env ruby

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

def bubble_sort!(array)
  loop do
    swap_flag = false
    first_index = 0
    second_index = first_index + 1

    while second_index < array.size
      if (block_given? && !yield(array[first_index], array[second_index])) || (!block_given? && array[first_index] > array[second_index])

        array[second_index], array[first_index] = array[first_index..second_index]
        swap_flag = true
      end

      first_index += 1
      second_index = first_index + 1
    end

    break if swap_flag == false
  end
end

class TestBubbleSort < Minitest::Test
  def test_bubble_sort_bang
    array = [5, 3]
    bubble_sort!(array)
    assert_equal([3, 5], array)

    array = [5, 3, 7]
    bubble_sort!(array) { |first, second| first >= second }
    assert_equal([7, 5, 3], array)

    array = [6, 2, 7, 1, 4]
    bubble_sort!(array)
    assert_equal([1, 2, 4, 6, 7], array)

    array = [6, 12, 27, 22, 14]
    bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
    assert_equal([14, 22, 12, 6, 27], array)

    array = %w[sue Pete alice Tyler rachel Kim bonnie]
    bubble_sort!(array)
    assert_equal(%w[Kim Pete Tyler alice bonnie rachel sue], array)

    array = %w[sue Pete alice Tyler rachel Kim bonnie]
    bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
    assert_equal(%w[alice bonnie Kim Pete rachel sue Tyler], array)
end
end
