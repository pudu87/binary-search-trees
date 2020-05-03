require_relative 'tree.rb'

# 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
puts "#1"
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
p tree.root

# 2. Confirm that the tree is balanced by calling `#balanced?`
puts "#2"
p tree.balanced?

# 3. Print out all elements in level, pre, post, and in order
puts "#3"
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

# 4. try to unbalance the tree by adding several numbers > 100
puts "#4"
tree.insert(101); tree.insert(102); tree.insert(103); tree.insert(104); tree.insert(105)

# 5. Confirm that the tree is unbalanced by calling `#balanced?`
puts "#5"
p tree.balanced?

# 6. Balance the tree by calling `#rebalance!`
puts "#6"
tree.rebalance!

# 7. Confirm that the tree is balanced by calling `#balanced?`
puts "#7"
p tree.balanced?

# 8. Print out all elements in level, pre, post, and in order
puts "#8"
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder