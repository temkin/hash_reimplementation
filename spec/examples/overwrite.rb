# frozen_string_literal: true

shared_examples_for 'overwrite values' do
  it 'overwriting a key' do
    key = 'foo'
    hash[key] = 'bar'
    hash[key] = 'baz'
    expect(hash[key]).to eq('baz')
  end
end
