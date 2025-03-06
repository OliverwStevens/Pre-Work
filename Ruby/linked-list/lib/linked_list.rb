class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
    else
      current = @head
      current = current.next_node until current.next_node.nil?
      current.next_node = node
    end
  end

  def prepend(value)
    node = Node.new(value, @head)
    @head = node
  end

  def size
  end

  def head
  end

  def tail
  end

  def at(index)
  end

  def pop
  end

  def contains?(value)
  end

  def find(value)
  end

  def to_s
    string = ""

    current = @head
    while current
      string += "( #{current.value} ) ->"
      current = current.next_node
    end
    "#{string}nil"
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
