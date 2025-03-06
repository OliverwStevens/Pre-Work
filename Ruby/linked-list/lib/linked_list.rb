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
    current = @head
    counter = 0
    while current
      counter += 1
      current = current.next_node
    end

    counter
  end

  def head # rubocop:disable Style/TrivialAccessors
    @head
  end

  def tail
    return nil if @head.nil?

    current = @head
    current = current.next_node until current.next_node.nil?
    current
  end

  def at(index)
    current = @head
    counter = 0
    while counter < index
      counter += 1

      current = current.next_node
      break if current.nil?
    end

    if current.nil?
      "Error: index to big"
    else
      current.value
    end
  end

  def pop
    return nil if @head.nil?
    return @head = nil if @head.next_node.nil?

    current = @head
    current = current.next_node until current.next_node.next_node.nil?
    current.next_node = nil
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
