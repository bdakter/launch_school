#! /usr/bin/env ruby

puts "Calculate your mortgage payments"

def valid_number?(num)
  (num.is_a?(Integer) || num.is_a?(Float)) && num > 0
end

loan_amount = nil
loop do
  puts 'How much borrowing?: '
  loan_amount = gets.chomp.to_i

  break if valid_number?(loan_amount)
  puts 'Invalid entry'
end

annual_rate = nil
loop do
  puts 'Annual rate?:'
  annual_rate = gets.chomp.to_f

  break if valid_number?(annual_rate)
  puts 'Invalid entry'
end

loan_years = nil
loop do
  puts 'Years?:'
  loan_years = gets.chomp.to_f

  break if valid_number?(loan_years)
  puts "Invalid entry"
end


annual_percent = annual_rate / 100
monthly_percent = annual_percent / 12
loan_months = loan_years * 12


monthly_payment = loan_amount * (monthly_percent /
  (1 - (1 + monthly_percent)**(-loan_months)))

puts "your monthly payment is #{monthly_payment}"
