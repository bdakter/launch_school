#! /usr/bin/env ruby

def get_data
  puts "First number: >>"
  first = gets.chomp.to_f

  puts "Second number: >>"
  second = gets.chomp.to_f

  puts "Add, minus, mult or divide? >>"
  operation = gets.chomp.downcase.to_sym

  return first, second, operation
end

def math_symbol(symbol)
  operands = {:add=>:+, :sub=>:-, :mult=>:*, :div=>:/}
  operands[symbol]
end

def compute((first, second, operator))

  math_symbol = math_symbol(operator)

  first.public_send(math_symbol, second)
end

input = get_data
p compute(input)
