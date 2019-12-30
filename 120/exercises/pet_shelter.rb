#! /usr/bin/env ruby

class Pet
  attr_reader :name, :type
  
  def initialize(type, name)
    @type, @name = type, name
  end

  def to_s
    ["Class: #{self.class.name}","@name: #{self.name}", "@type: #{self.type}", " "].join("\n")
  end
end

class Owner

  attr_accessor :name, :number_of_pets

  def initialize(n)
    @name = n
    @number_of_pets = 0
  end

  def to_s
    ["Class: #{self.class.name}", "@name: #{name}", "@Number_of_pets: #{number_of_pets}",""].join("\n")
  end

end

class Shelter
  attr_accessor :tally

  def initialize
    @tally = Hash.new {|h,k| h[k] = []}
  end

  def adopt(owner, pet)
   @tally[owner] << pet
    owner.number_of_pets += 1 
  end

  def print_adoptions
    @tally.each do |owner, pets|
       puts "#{owner.name} has adopted the following pets:"
       pets.each do |pet|
        puts "A #{pet.type} named #{pet.name}"
       end
       puts
    end
  end

  def to_s
    "Tally: #{tally}"
  end

end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
