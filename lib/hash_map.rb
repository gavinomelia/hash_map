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

  def get(key)
    _, bucket = find_bucket(key)

    return nil unless bucket

    pair = bucket.find { |k, _| k == key }
    pair ? pair[1] : nil
  end

  def has?(key)
    _, bucket = find_bucket(key)
    return false unless bucket

    bucket.any? { |k, _| k == key }
  end

  def remove(key)
    _, bucket = find_bucket(key)
    return unless bucket

    bucket.reject! { |k, _| k == key }
  end

  def length
    @buckets.compact.flatten(1).size
  end

  def clear
    @buckets = Array.new(@capacity)
  end

  def keys
    @buckets.compact.flatten(1).map(&:first)
  end

  private

  def find_bucket(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]
    [index, bucket]
  end
end