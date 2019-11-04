#! /usr/bin/env ruby

def minilang(str)
  commands = str.split

  stack = []
  register = 0

  commands.each do |comm|
    case comm
    when 'PRINT' then puts register
    when 'PUSH'  then stack << register
    when 'ADD'   then register += stack.pop
    when 'SUB'   then register -= stack.pop
    when 'DIV'   then register /= stack.pop
    when 'MOD'   then register %= stack.pop 
    when 'MULT'  then register *= stack.pop
    when 'POP'   then register = stack.pop
    else register = comm.to_i

    end
  end
end

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('PRINT')
# 0

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
