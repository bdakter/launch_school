#! /usr/bin/env ruby

print "Name: "
name = gets.chomp

response = "Hello #{name}"

response.upcase! if name.end_with?('!')
puts response
