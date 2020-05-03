require_relative 'node.rb'

class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return if array.empty?
    index = array.size / 2
    node = Node.new(array[index])
    node.left  = build_tree(array[0...index])
    node.right = build_tree(array[index+1..-1])
    node
  end

  def insert(data, node=root)
    return "Error: Duplicate values not allowed." if node == data
    if node > data
      node.left  ? insert(data, node.left)  : node.left  = Node.new(data)
    else
      node.right ? insert(data, node.right) : node.right = Node.new(data)
    end
  end

  def delete(data, node=root)
    return if node.nil?
    case node <=> data
    when 1 
      node.left  = delete(data, node.left)
    when -1 
      node.right = delete(data, node.right)
    when 0
      if node.leaf?
        return 
      elsif node.one_child?
        return node.left || node.right
      else
        child = node.right
        child = child.left while child.left
        node.data = child.data
        node.right = delete(child.data, node.right)
      end
    end
    node
  end

  def find(data, node=root)
    return "Error: Value not in tree." if node.nil?
    case node <=> data
    when  1 then find(data, node.left)
    when -1 then find(data, node.right)
    when  0 then node
    end
  end

  def level_order(queue=[root], output=[])    
    until queue.empty?
      (queue.size).times do
        queue << queue[0].left  if queue[0].left
        queue << queue[0].right if queue[0].right
        block_given? ? yield(queue.shift) : output << queue.shift.data
      end
    end
    output unless block_given?
  end

  def level_order_rec(queue=[root], output=[], &block)
    return if queue.empty?
    (queue.size).times do
      queue << queue[0].left  if queue[0].left
      queue << queue[0].right if queue[0].right
      block_given? ? yield(queue.shift) : output << queue.shift.data
    end
    level_order_rec(queue, output, &block)
    output unless block_given?
  end

  [:preorder, :inorder, :postorder].each do |method|
    define_method(method) do |node=root, output=[], &block|
      return if node.nil?
      block_given? ? yield(node) : output << node.data if method == :preorder
      self.send(method, node.left, output, &block)
      block_given? ? yield(node) : output << node.data if method == :inorder
      self.send(method, node.right, output, &block)
      block_given? ? yield(node) : output << node.data if method == :postorder
      output unless block_given?
    end
  end

  def depth(node=root)
    return -1 if node.nil?
    left_depth = depth(node.left)
    right_depth = depth(node.right)
    left_depth > right_depth ? left_depth + 1 : right_depth + 1
  end

  def balanced?
    return true if root.leaf?
    (depth(root.left) - depth(root.right)).abs < 2
  end

  def rebalance!
    return "Tree is already balanced." if balanced?
    @root = build_tree(level_order.sort.uniq)
  end
end