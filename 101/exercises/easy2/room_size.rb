#! /usr/bin/env ruby

puts 'Length? >>'
length_m = gets.chomp.to_i

puts 'Width? >>'
width_m = gets.chomp.to_i

area_m = length_m * width_m
area_f = (area_m * 10.7639).round(2)

puts "Area is #{area_m} meters (#{area_f} ft)."
