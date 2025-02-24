require 'rspec'
require_relative '../lib/hash_map'

RSpec.describe HashMap do
  let(:hash_map) { HashMap.new(0.75, 16) }

  describe '#set' do
    before do
      %w[apple banana carrot dog elephant frog grape hat ice\ cream jacket kite lion].each_with_index do |key, index|
        hash_map.set(key, %w[red yellow orange brown gray green purple black white blue pink golden][index])
      end
    end

    it 'sets and retrieves values correctly' do
      %w[apple banana lion].each do |key|
        expect(hash_map.instance_variable_get(:@buckets).flatten(1)).to include([key, hash_map.get(key)])
      end
    end

    it 'has a load factor of 0.75' do
      expect(hash_map.instance_variable_get(:@load_factor)).to eq(0.75)
    end

    it 'has a capacity of 16' do
      expect(hash_map.instance_variable_get(:@capacity)).to eq(16)
    end
  end

  describe '#hash' do
    it 'calculates the hash correctly' do
      %w[apple banana carrot].each do |key|
        expect(hash_map.hash(key)).to be_a(Integer)
      end
    end

    it 'returns the same hash for the same key' do
      expect(hash_map.hash('apple')).to eq(hash_map.hash('apple'))
    end
  end

  describe '#get' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'retrieves the correct value for a given key' do
      expect(hash_map.get('apple')).to eq('red')
      expect(hash_map.get('banana')).to eq('yellow')
    end

    it 'returns nil for a non-existent key' do
      expect(hash_map.get('non_existent_key')).to be_nil
    end
  end

  describe '#has?' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns true for an existing key' do
      expect(hash_map.has?('apple')).to be true
    end

    it 'returns false for a non-existent key' do
      expect(hash_map.has?('non_existent_key')).to be false
    end

    it 'returns false for an empty key' do
      expect(hash_map.has?('')).to be false
    end
  end

  describe '#remove' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'removes the correct key-value pair' do
      hash_map.remove('apple')
      expect(hash_map.get('apple')).to be_nil
    end

    it 'does not remove non-existent keys' do
      hash_map.remove('non_existent_key')
      expect(hash_map.get('banana')).to eq('yellow')
    end

    it 'does not raise an error when removing a non-existent key' do
      expect { hash_map.remove('non_existent_key') }.not_to raise_error
    end
  end

  describe '#length' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns the correct length' do
      expect(hash_map.length).to eq(2)
    end

    it 'returns 0 for an empty hash map' do
      empty_hash_map = HashMap.new(0.75, 16)
      expect(empty_hash_map.length).to eq(0)
    end
  end

  describe '#clear' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'clears all key-value pairs' do
      hash_map.clear
      expect(hash_map.length).to eq(0)
    end
  end

  describe '#keys' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns an array of keys' do
      expect(hash_map.keys).to contain_exactly('apple', 'banana')
    end
  end

  describe '#values' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns an array of values' do
      expect(hash_map.values).to contain_exactly('red', 'yellow')
    end
  end

  describe '#entries' do
    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns an array of key-value pairs' do
      expect(hash_map.entries).to contain_exactly(['apple', 'red'], ['banana', 'yellow'])
    end
  end
end
