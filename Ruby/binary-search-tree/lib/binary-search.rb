class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  # accepts array of values
  def initialize(values)
    @root = build_tree(values.sort)
  end

  def build_tree(data)
    # remove duplicates
    data = data.uniq
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

  def get_successor(node)
    current = node
    current = current.left while !current.nil? && !current.left.nil?
    current
  end

  def delete(value)
    @root = delete_node(@root, value)
  end

  def delete_node(root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete_node(root.left, value)
    elsif value > root.data
      root.right = delete_node(root.right, value)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      successor = get_successor(root.right)

      root.data = successor.data

      root.right = delete_node(root.right, successor.data)
    end

    root
  end

  # printing function for visualization
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
