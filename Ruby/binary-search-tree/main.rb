require_relative "lib/binary-search"

tree = Tree.new(Array.new(15) { rand(1..100) })

tree.pretty_print

puts tree.balanced?

p tree.level_order

p tree.inorder

p tree.preorder

p tree.postorder

tree.insert(150)
tree.insert(160)
tree.insert(170)
tree.insert(180)
tree.insert(190)
tree.insert(200)

tree.pretty_print

puts tree.balanced?

tree.rebalance

tree.pretty_print

puts tree.balanced?

p tree.level_order

p tree.inorder

p tree.preorder

p tree.postorder
