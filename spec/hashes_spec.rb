require_relative '../lib/hash_table'
require_relative '../lib/data_storage'
require_relative 'examples/keys'
require_relative 'examples/overwrite'
require_relative 'examples/delete'
require_relative 'examples/inspect'

shared_examples_for 'default' do
  let(:hash) { described_class.new }
  it_should_behave_like 'keys'
  it_should_behave_like 'key/value'
  it_should_behave_like 'overwrite values'
  it_should_behave_like 'delete'
  it_should_behave_like 'inspect'
end

describe Hash do
  it_should_behave_like 'default'
end

describe DataStorage do
  it_should_behave_like 'default'
end

describe HashTable do
  it_should_behave_like 'default'
end
