# frozen_string_literal: true

# HashMap is a simple implementation of a hash map data structure.
class HashMap
  def initialize(load_factor, capacity)
    @load_factor = load_factor
    @buckets = Array.new(capacity)
    @capacity = capacity
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    @buckets ||= Array.new(@capacity)
    @buckets[index] ||= []

    bucket = @buckets[index]
    pair = bucket.find { |k, _| k == key }

    if pair
      pair[1] = value
    else
      bucket << [key, value]
    end
  end
end