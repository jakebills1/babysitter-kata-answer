require_relative '../babysitter'

describe Babysitter do
  subject { described_class.new }
  it 'can be initialized' do
    expect(subject).to be_an_instance_of(described_class)
  end
  it 'calculates the babysitters nightly pay' do
    subject.clock_in('5 PM')
    subject.clock_out('7 PM')
    expect(subject.calculate_nightly_pay).to eq "$24"
  end
  it 'only accepts a start time of 5 PM or later' do
    expect { 
      subject.clock_in('4 PM')
    }.to raise_error ArgumentError
  end
  it 'only accepts an end time at or before 4 AM' do
    subject.clock_in('5 PM')
    expect {
      subject.clock_out('5 AM')
    }.to raise_error ArgumentError
  end
  it 'only accepts an end time if start time already entered' do
    expect {
      subject.clock_out('9 PM')
    }.to raise_error ArgumentError
  end
  it 'only accepts an end time later than the start time' do
    subject.clock_in('7 PM')
    expect {
      subject.clock_out('6 PM')
    }.to raise_error ArgumentError
  end
end

