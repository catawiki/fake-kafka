# Fake::Kafka

It is a drop in replacement for ruby-kafka driver, it works as In-memory driver, useful for development and test environments

## Installation

Add this line to your application's Gemfile:

```ruby
	gem 'fake-kafka', git: 'git@github.com:catawiki/fake-kafka.git', tag: '0.0.1-beta1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fake-kafka

## Usage

### Testing

```ruby
	require 'fake/kafka'
	Catbus.kafka = Fake::Kafka.new
```

```ruby
 describe 'consume' do
    let(:payload) do
      {
        payload: {
        	YOUR_CONTENT_HERE
          },
          event_name: EVENT_NAME
        }
      }
    end
     before do
      Catbus.kafka.deliver_message payload, topic: 'test_YOUR_TOPIC'
    end
     it 'should consume message' do
      expect(Resque).to receive(:enqueue).with(described_class, payload.to_json)
      Catbus.consumer.send(:consume)
    end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/catawiki/fake-kafka.
