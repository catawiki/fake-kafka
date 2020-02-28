require 'fake/kafka/version'
require 'fake/kafka/batch'
require 'fake/kafka/message'
require 'fake/kafka/consumer'
require 'fake/kafka/producer'

module Fake
  class Kafka
    attr_reader :messages, :paused_partitions

    def initialize(*options)
      @messages = []
      @paused_partitions = {}
    end

    def paused?(topic, partition)
      @paused_partitions[topic] ||= {}
      !!@paused_partitions[topic][partition]
    end

    def deliver_message(value, topic:, key: nil)
      @messages << Message.new(value, key, topic, 0, 0)
    end

    def messages_in(topic)
      messages.select {|message| message.topic == topic }
    end

    def consumer(*options)
      Consumer.new(self)
    end

    def producer(*)
      Producer.new(self)
    end

    # https://github.com/zendesk/ruby-kafka/blob/v1.0.0/lib/kafka/client.rb#L307
    # rubocop:disable Lint/UnusedMethodArgument, Metric/ParameterLists, Layout/LineLength
    def async_producer(delivery_interval: 0, delivery_threshold: 0, max_queue_size: 1000, max_retries: -1, retry_backoff: 0, **options)
      producer(**options)
    end
    # rubocop:enable all

    # Used to clean in-memory data
    # Useful between test runs
    def reset!
      @messages = []
      @paused_partitions = {}
    end
  end
end
