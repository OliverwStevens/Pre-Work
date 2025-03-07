class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    @starting_capacity = 16
    @capacity = @starting_capacity
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def hash(key, capacity = @capacity)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code % capacity
  end

  def set(key, value)
    index = hash(key)
    bucket = @buckets[index]

    # Check if key already exists, update value if it does
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    # Append new key-value pair
    bucket.push([key, value])
    @size += 1

    # Resize if load factor exceeded
    resize if @size.to_f / @capacity > LOAD_FACTOR
  end

  def get(key)
    index = hash(key)
    bucket = @buckets[index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil # Key not found
  end

  def has?(key)
    index = hash(key)
    bucket = @buckets[index]
    bucket.any? { |pair| pair[0] == key }
  end

  def remove(key)
    index = hash(key)
    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      next unless pair[0] == key

      bucket.delete_at(i)
      @size -= 1
      return pair[1]
    end
    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@starting_capacity) { [] }
    @size = 0
  end

  def info
    puts "Load Factor: #{@size.to_f / @capacity} Capacity: #{@capacity} Size: #{@size}"
  end

  private

  def resize
    new_capacity = @capacity * 2
    new_buckets = Array.new(new_capacity) { [] }

    @buckets.each do |bucket|
      bucket.each do |pair|
        new_index = hash(pair[0], new_capacity)
        new_buckets[new_index].push([pair[0], pair[1]])
      end
    end

    @capacity = new_capacity
    @buckets = new_buckets
  end
end
