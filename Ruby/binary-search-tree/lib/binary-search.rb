class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :root

  # accepts array of values
  def initialize(values)
    @root = build_tree(values)
  end

  def build_tree(data)
    # remove duplicates
    data.uniq!
    build_tree_recursive(data, 0, data.length - 1)
  end

  def build_tree_recursive(arr, start, last)
    return nil if start > last

    mid = start + ((last - start) / 2).floor

    root = Node.new(arr[mid])

    # left subtree
    root.left = build_tree_recursive(arr, start, mid - 1)

    # right subtree
    root.right = build_tree_recursive(arr, mid + 1, last)

    # return the root
    root
  end

  def insert(data, root = @root)
    return Node.new(data) if root.nil?

    if data < root.data
      root.left = insert(data, root.left)
    elsif data > root.data
      root.right = insert(data, root.right)
    end
    root
  end

  def get_successor(curr)
    curr = curr.right

    curr = curr.left while !curr.nil? && !curr.left.nil?
    curr
  end

  # printing function for visualization
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
