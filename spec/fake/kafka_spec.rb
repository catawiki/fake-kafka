RSpec.describe Fake::Kafka do
  subject(:kafka) { described_class.new }

  it 'has a version number' do
    expect(Fake::Kafka::VERSION).not_to be nil
  end

  describe '#async_producer' do
    subject(:producer) { kafka.async_producer }

    it { is_expected.to be_a(described_class::Producer) }
  end
end
