require_relative '../babysitter'

describe Babysitter do
  it 'can be initialized' do
    expect(described_class.new).to be_an_instance_of(described_class)
  end
end

