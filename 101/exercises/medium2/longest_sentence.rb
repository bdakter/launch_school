#! /usr/bin/env ruby

text = File.read("frankenstein.txt")

current_sentence = []
longest_sentence = []
count_words = 0
beginning_index = 0
ending_index = 0

while ending_index < text.size-1
  ending_index = text.index(/[.!?]/, beginning_index)
  break if ending_index.nil?
  current_sentence = text.slice(beginning_index..ending_index).split(' ')
  if current_sentence.size > count_words
    count_words = current_sentence.size
    longest_sentence = current_sentence
  end
  beginning_index = ending_index + 2

end

puts longest_sentence.join(' ')
puts count_words
