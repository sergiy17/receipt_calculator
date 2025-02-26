require './lib/receipt'

input1 = <<~INPUT
  2 book at 12.49
  1 music CD at 14.99
  1 chocolate bar at 0.85
INPUT

input2 = <<~INPUT
  1 imported box of chocolates at 10.00
  1 imported bottle of perfume at 47.50
INPUT

input3 = <<~INPUT
  1 imported bottle of perfume at 27.99
  1 bottle of perfume at 18.99
  1 packet of headache pills at 9.75
  3 imported boxes of chocolates at 11.25
INPUT

puts "Receipt 1\n"
puts Receipt.new(input1).generate

puts "\n"

puts "Receipt 2\n"
puts Receipt.new(input2).generate

puts "\n"

puts "Receipt 3\n"
puts Receipt.new(input3).generate
