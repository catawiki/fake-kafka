RSpec.describe Fake::Kafka do
  subject(:kafka) { described_class.new }

  it 'has a version number' do
    expect(Fake::Kafka::VERSION).not_to be nil
  end

  describe '#producer' do
    subject(:producer) { kafka.producer }

    it { is_expected.to be_a(described_class::Producer) }

    context 'when invalid options are passed' do
      specify do
        expect { kafka.producer(foo: 'x') }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe '#async_producer' do
    subject(:producer) { kafka.async_producer }

    it { is_expected.to be_a(described_class::Producer) }

    context 'when invalid options are passed' do
      specify do
        expect { kafka.async_producer(foo: 'x') }
          .to raise_error(ArgumentError)
      end
    end
  end
end
