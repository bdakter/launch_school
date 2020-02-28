#! /usr/bin/env ruby

require 'set'

class StackError < StandardError; end
class InvalidToken < StandardError; end

class Minilang
  attr_accessor :register, :stack
  attr_reader :instructions

  def initialize(string)
    @instructions = string.split
    @stack = []
    @register = 0
  end

  OPERATIONS = Set.new %w[PUSH ADD SUB DIV MOD MULT POP PRINT]

  def print
    puts register
  end

  def push
    stack << register
  end

  def add
    self.register += stack.pop
  end

  def sub
    self.register -= stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def mod
    self.register %= stack.pop
  end

  def mult
    self.register *= stack.pop
  end

  def pop
    raise StackError, 'Empty stack!' if stack.empty?

    self.register = stack.pop
  end

  def eval
    instructions.each do |inst|
      eval_token(inst)
    end
  end

  def eval_token(token)
    if OPERATIONS.include? token
      send(token.downcase)
    elsif token =~ /\d/
      self.register = token.to_i
    else raise InvalidToken, "Invalid token #{token}"
    end
  end
end

Minilang.new('PRINT').eval
# 0

# require 'pry'; binding.pry
Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

# Error: Empty stack!
begin
  Minilang.new('5 PUSH POP POP PRINT').eval
  puts false
rescue StackError
  puts true
end

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# Invalid token: XSUB
begin
  Minilang.new('-3 PUSH 5 XSUB PRINT').eval
  puts false
rescue InvalidToken
  puts true
end
