require_relative "lib/binary-search"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts tree.root.data
tree.pretty_print

tree.del_node(tree.root, 7)
puts "Hello people"
tree.pretty_print
