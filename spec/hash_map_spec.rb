require 'rspec'
require_relative '../lib/hash_map'

RSpec.describe HashMap do
  describe '#set' do
    let(:hash_map) { HashMap.new(0.75, 16) }

    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
      hash_map.set('carrot', 'orange')
      hash_map.set('dog', 'brown')
      hash_map.set('elephant', 'gray')
      hash_map.set('frog', 'green')
      hash_map.set('grape', 'purple')
      hash_map.set('hat', 'black')
      hash_map.set('ice cream', 'white')
      hash_map.set('jacket', 'blue')
      hash_map.set('kite', 'pink')
      hash_map.set('lion', 'golden')
    end

    it 'sets and retrieves values correctly' do
      expect(hash_map.instance_variable_get(:@buckets).flatten(1)).to include(['apple', 'red'])
      expect(hash_map.instance_variable_get(:@buckets).flatten(1)).to include(['banana', 'yellow'])
      expect(hash_map.instance_variable_get(:@buckets).flatten(1)).to include(['lion', 'golden'])
    end

    it 'has a load factor of 0.75' do
      expect(hash_map.instance_variable_get(:@load_factor)).to eq(0.75)
    end

    it 'has a capacity of 16' do
      expect(hash_map.instance_variable_get(:@capacity)).to eq(16)
    end
  end

  describe '#hash' do
    let(:hash_map) { HashMap.new(0.75, 16) }

    it 'calculates the hash correctly' do
      expect(hash_map.hash('apple')).to be_a(Integer)
      expect(hash_map.hash('banana')).to be_a(Integer)
      expect(hash_map.hash('carrot')).to be_a(Integer)
    end
    it 'returns the same hash for the same key' do
      expect(hash_map.hash('apple')).to eq(hash_map.hash('apple'))
    end
  end

  describe '#get' do
    let(:hash_map) { HashMap.new(0.75, 16) }

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
    let(:hash_map) { HashMap.new(0.75, 16) }

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
    let(:hash_map) { HashMap.new(0.75, 16) }

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
    let(:hash_map) { HashMap.new(0.75, 16) }

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
    let(:hash_map) { HashMap.new(0.75, 16) }

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
    let(:hash_map) { HashMap.new(0.75, 16) }

    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns an array of keys' do
      expect(hash_map.keys).to contain_exactly('apple', 'banana')
    end
  end

  describe '#values' do
    let(:hash_map) { HashMap.new(0.75, 16) }

    before do
      hash_map.set('apple', 'red')
      hash_map.set('banana', 'yellow')
    end

    it 'returns an array of values' do
      expect(hash_map.values).to contain_exactly('red', 'yellow')
    end
  end
end