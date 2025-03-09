require_relative "lib/binary-search"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts tree.root.data
tree.pretty_print

tree.level_order { |node| puts node.data }

values = tree.level_order
recursive_values = tree.level_order_recursive

p values
p recursive_values
