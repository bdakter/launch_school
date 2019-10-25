#! /usr/bin/env ruby

def substrings_at_start(str)
  counter = 0
  results = []

  while counter < str.size
    results << str.slice(0..counter)
    counter += 1
  end
  results
end

def substrings(str)
  counter = 0
  final_results = []

  while counter < str.size
    slice = str.slice(counter..-1)
    final_results << substrings_at_start(slice)
    counter += 1
  end
  final_results.flatten
end

def palindromes(str)
  substrings(str).select do |sub|
    sub == sub.reverse if sub.size > 1
  end
end

puts palindromes('abcd') == []
puts palindromes('madam') == %w[madam ada]
puts palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
puts palindromes('knitting cassettes') == %w[
  nittin itti tt ss settes ette tt
]
