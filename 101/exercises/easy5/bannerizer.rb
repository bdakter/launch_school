#! /usr/bin/env ruby


def print_in_box(str)
  box_length = str.size + 2

  puts "+#{'-' * box_length}+"
  puts "|#{' ' * box_length}|"
  puts "| #{str} |"
  puts "|#{' '  * box_length}|"
  puts "+#{'-'  * box_length}+"
end



print_in_box('To boldly go where no one has gone before.')


# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+