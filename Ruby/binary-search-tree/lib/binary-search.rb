class Node
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  # accepts array of values
  def initialize(values)
    @root = build_tree(values)
  end

  def build_tree(data)
    build_tree_recursive(data, 0, data.length - 1)
  end

  def build_tree_recursive(arr, start, last)
  end
end
