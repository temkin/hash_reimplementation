shared_examples_for 'delete' do
  it 'delete keys' do
    key1 = 'hello'
    key2 = 'world'
    hash[key1] = Array.new(2)
    hash[key2] = :world
    deleted_val = hash.delete(key1)
    expect(deleted_val).to eq([nil, nil])
    expect(hash.keys).to eq([key2])
  end
end
