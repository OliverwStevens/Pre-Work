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

  def find(data, root = @root)
    return root if root.nil? || root.data == data
    return find(data, root.right) if root.data < data

    find(data, root.left)
  end

  def level_order(root = @root)
    return [] if root.nil?

    queue = [root]
    result = []

    until queue.empty?
      current = queue.shift

      result.push(current.data)

      yield current if block_given?

      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end
    result
  end

  def level_order_recursive(root = @root, level = 0, result = {})
    return [] if root.nil?

    result[level] ||= []

    result[level].push(root.data)

    yield root if block_given?

    level_order_recursive(root.left, level + 1, result) unless root.left.nil?
    level_order_recursive(root.right, level + 1, result) unless root.right.nil?

    return result.values.flatten if level.zero?

    result
  end

  def inorder(root = @root)
    return if root.nil?

    inorder(root.left)
    puts root.data
    inorder(root.right)
  end

  # printing function for visualization
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
