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
  end
end
