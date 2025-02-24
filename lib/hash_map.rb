# frozen_string_literal: true

# HashMap is a simple implementation of a hash map data structure.
class HashMap
  def initialize(load_factor, capacity)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity) { [] }
  end

  def set(key, value)
    bucket = find_bucket(key)
    pair = bucket.find { |k, _| k == key }

    if pair
      pair[1] = value
    else
      bucket << [key, value]
    end
  end

  def get(key)
    pair = find_pair(key)
    pair ? pair[1] : nil
  end

  def has?(key)
    !!find_pair(key)
  end

  def remove(key)
    bucket = find_bucket(key)
    bucket.reject! { |k, _| k == key }
  end

  def length
    @buckets.flatten(1).size
  end

  def clear
    @buckets.each(&:clear)
  end

  def keys
    @buckets.flatten(1).map(&:first)
  end

  def values
    @buckets.flatten(1).map(&:last)
  end

  def entries
    @buckets.flatten(1)
  end

  private

  def hash(key)
    key.each_char.reduce(0) { |hash_code, char| 31 * hash_code + char.ord }
  end

  def find_bucket(key)
    @buckets[hash(key) % @capacity]
  end

  def find_pair(key)
    find_bucket(key).find { |k, _| k == key }
  end
end
