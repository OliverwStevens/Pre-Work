require_relative "lib/linked_list"

list = LinkedList.new
list.append("Hello")
list.append("Sir")
list.prepend("Oh!")

puts list
puts list.contains?("Oh!")
