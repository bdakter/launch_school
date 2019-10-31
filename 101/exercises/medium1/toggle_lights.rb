#! /usr/bin/env ruby

# Generates array of indexes to access light array.
def pattern(multiple, limit)
  (multiple - 1).step(by: multiple, to: limit).to_a
end

def which_lights_on(ary)
  ary.each_with_index.with_object([]) do |(e, i), obj|
    obj << (i + 1) if e == true
  end
end

def toggle(int)
  lights = Array.new(int, false)

  1.upto(int) do |i|
    current_pattern = pattern(i, int - 1)

    current_pattern.each do |index|
      lights[index] = !lights[index]
    end
  end

  which_lights_on(lights)
end

p toggle(5) == [1, 4]
p toggle(10) == [1, 4, 9]
p toggle(1000) == [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169,
                   196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625,
                   676, 729, 784, 841, 900, 961]
