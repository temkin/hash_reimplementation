# frozen_string_literal: true

shared_examples_for 'keys' do
  it 'string key' do
    key       = 'hello'
    val       = 'world'
    hash[key] = val
    expect(hash[key]).to eq(val)
  end

  it 'an equal strings as the same key' do
    hash['hello'] = 'world'
    expect(hash['hello']).to eq('world')
  end

  it 'a symbol key' do
    key       = :hello
    hash[key] = :world
    expect(hash[key]).to eq(:world)
  end

  it 'a string and symbol keys' do
    string = 'hello'
    symbol = :hello
    hash[string]  = 'world'
    hash[symbol]  = 'ruby'
    expect(hash[string]).to  eq('world')
    expect(hash[symbol]).to  eq('ruby')
  end

  describe 'array keys' do
    it 'an array key' do
      array = [1, 2]
      hash[array] = 'world'
      expect(hash[array]).to eq('world')
    end

    it 'an arrays as the same key' do
      arr1 = [1, 2]
      arr2 = [1, 2]
      hash[[arr1]] = 'hello world'
      expect(hash[[arr2]]).to eq('hello world')
    end
  end

  describe 'object keys' do
    it 'an Object key' do
      obj = Object.new
      hash[obj] = 'world'
      expect(hash[obj]).to eq('world')
    end
  end
end

shared_examples_for 'key/value' do
  let(:a) { 'a' }
  let(:b) { 'b' }
  let(:c) { 'c' }
  let(:d) { 'd' }

  let(:hash) do
    described_class.new.tap do |h|
      h[a] = 'hello'
      h[b] = :world
      h[c] = nil
    end
  end

  it 'has key' do
    expect(hash.key?(a)).to be_truthy
    expect(hash.key?(c)).to be_truthy
    expect(hash.key?(d)).to be_falsey
  end

  it 'return keys' do
    expect(hash.keys).to eq([a, b, c])
  end

  it 'return values' do
    expect(hash.values).to eq(['hello', :world, nil])
  end
end
