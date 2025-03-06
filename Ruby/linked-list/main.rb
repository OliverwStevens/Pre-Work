require_relative "lib/linked_list"

list = LinkedList.new
list.append("Hello")
list.append("Sir")
list.prepend("Oh!")

puts list
puts list.find("Sir")
list.insert_at("Good", 0)
puts list.at(2)
puts list
