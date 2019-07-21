#! /usr/bin/env ruby

puts 'Bill amount: >>'
bill_amt = gets.chomp.to_f

puts 'Tip percentage:>> '
tip_pct = gets.chomp.to_f

TIP_RATE = tip_pct / 100

tip_amount = bill_amt * TIP_RATE
bill_total = bill_amt + tip_amount

puts "Tip: $#{format('%.2f', tip_amount)}\n"\
     "Total: $#{format('%.2f', bill_total)}"
