#! /usr/bin/env ruby

require 'yaml'
MESSAGES = YAML.load_file('mort_calc.yml')

puts "Calculate your mortgage payments"

def valid_number?(num)
  (num.is_a?(Integer) || num.is_a?(Float)) && num > 0
end

def get_info(message)
  loop do
    puts MESSAGES[message]

    input =
      case message
      when 'borrowing'
        gets.chomp.to_i
      when 'annual_rate', 'loan_years'
        gets.chomp.to_f
      end

    break input if valid_number?(input)
    puts MESSAGES['invalid']
  end
end

loop do
  loan_amount = get_info('borrowing')
  annual_rate = get_info('annual_rate')
  loan_years = get_info('loan_years')

  annual_percent = annual_rate / 100
  monthly_percent = annual_percent / 12
  loan_months = loan_years * 12

  monthly_payment = loan_amount *
                    (monthly_percent /
                    (1 - (1 + monthly_percent)**-loan_months))

  puts "your monthly payment is #{monthly_payment}"

  puts "Another calculation? (Y/N) : "
  break unless gets.chomp.downcase == 'y'
end

puts "Good luck on your dream purchase :)"
