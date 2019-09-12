#! /usr/bin/env ruby

DEGREE_SYM = "\xC2\xB0"

def dms(float)
  degrees, decimal = float.divmod(1)
  minutes, second_decimal = (decimal*60).divmod(1)
  seconds = (second_decimal*60).divmod(1).first

 "#{degrees}#{DEGREE_SYM}#{format('%02d', minutes)}'#{format('%02d', seconds)}\""
end

# dms(30)

puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6) == %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
