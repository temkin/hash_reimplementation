shared_examples_for 'inspect' do
  it 'string representation' do
    hash[1] = 2
    hash['hello'] = 'world'
    hash[true] = :false
    expect(hash.inspect).to eq("{1=>2, \"hello\"=>\"world\", true=>:false}")
  end
end
