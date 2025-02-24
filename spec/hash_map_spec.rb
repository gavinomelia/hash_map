require 'rspec'
require_relative '../lib/hash_map'

RSpec.describe HashMap do
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