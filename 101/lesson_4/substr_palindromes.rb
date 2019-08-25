#! /usr/bin/env ruby

def palindrome?(str)
  str == str.reverse && str.length > 1
end

def palindrome_substrings(str)
  results_array = []

  start_index = 0
  while start_index <= str.size - 1 # beginning loop
    end_index = start_index + 1

    while end_index <= str.size - 1 # ending loop
      substring = str[start_index..end_index]
      results_array << substring if palindrome?(substring)
      end_index += 1
    end

    start_index += 1
  end

  results_array
end

puts palindrome_substrings('abcb') == ['bcb']
puts palindrome_substrings('supercalifragilisticexpialidocious') == ['ili']
puts palindrome_substrings('abcddcbA') == %w[bcddcb cddc dd]
puts palindrome_substrings('palindrome') == []
puts palindrome_substrings('palindrome') == []
puts palindrome_substrings('') == []
