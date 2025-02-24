# frozen_string_literal: true

# HashMap is a simple implementation of a hash map data structure.
class HashMap
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @size = 0
    @buckets = Array.new(capacity) { [] }
  end

  def set(key, value)
    resize if @size >= @capacity * @load_factor
    bucket = find_bucket(key)
    pair = bucket.find { |k, _| k == key }

    if pair
      pair[1] = value
    else
      bucket << [key, value]
      @size += 1
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
    removed_pair = bucket.find { |k, _| k == key }
    if removed_pair
      bucket.delete_if { |k, _| k == key }
      @size -= 1
      removed_pair[1]
    else
      nil
    end
  end

  def length
    @size
  end

  def clear
    @buckets.each(&:clear)
    @size = 0
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

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.flatten(1).each do |key, value|
      set(key, value)
    end
  end
end
