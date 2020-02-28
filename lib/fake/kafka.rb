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

    # https://github.com/zendesk/ruby-kafka/blob/v1.0.0/lib/kafka/client.rb#L248-L261
    # rubocop:disable Lint/UnusedMethodArgument, Metric/ParameterLists, Layout/LineLength
    def producer(
      compression_codec: nil,
      compression_threshold: 1,
      ack_timeout: 5,
      required_acks: :all,
      max_retries: 2,
      retry_backoff: 1,
      max_buffer_size: 1000,
      max_buffer_bytesize: 10_000_000,
      idempotent: false,
      transactional: false,
      transactional_id: nil,
      transactional_timeout: 60
    )
      Producer.new(self)
    end
    # rubocop:enable all

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
