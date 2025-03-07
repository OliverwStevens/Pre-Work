require_relative "lib/hashmap"
require_relative "lib/hashset"
test = HashMap.new

test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")
test.set("moon", "silver")

puts test.get("moon")
puts test.remove("jacket")
puts test.has?("jacket")
puts test.length

p test.keys
p test.values
p test.entries

# puts test.info
# puts test.clear

#----------------------

test_set = HashSet.new

test_set.set("apple")
test_set.set("banana")
test_set.set("carrot")
test_set.set("dog")
test_set.set("elephant")
test_set.set("frog")
test_set.set("grape")
test_set.set("hat")
test_set.set("ice cream")
test_set.set("jacket")
test_set.set("kite")
test_set.set("lion")
test_set.set("moon")

puts test_set.has?("moon")
puts test_set.remove("moon")
puts test_set.length
p test_set.entries

# puts test_set.info
# test_set.clear
