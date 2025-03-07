class HashSet
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

  def set(key)
    index = hash(key)
    bucket = @buckets[index]

    return if bucket.include?(key)

    bucket.push(key)
    @size += 1

    resize if @size.to_f / @capacity > LOAD_FACTOR
  end

  def has?(key)
    index = hash(key)
    bucket = @buckets[index]
    bucket.include?(key)
  end

  def remove(key)
    index = hash(key)
    bucket = @buckets[index]

    if bucket.include?(key)
      bucket.delete(key)
      @size -= 1
      return key
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

  def entries
    @buckets.flatten
  end

  def info
    puts "Load Factor: #{@size.to_f / @capacity} Capacity: #{@capacity} Size: #{@size}"
  end

  private

  def resize
    new_capacity = @capacity * 2
    new_buckets = Array.new(new_capacity) { [] }

    @buckets.each do |bucket|
      bucket.each do |key|
        new_index = hash(key, new_capacity)
        new_buckets[new_index].push(key)
      end
    end

    @capacity = new_capacity
    @buckets = new_buckets
  end
end
