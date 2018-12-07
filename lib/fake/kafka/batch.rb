class Fake::Kafka::Batch
  attr_reader :topic, :partition, :messages, :highwater_mark_offset

  def initialize(topic:, partition:, messages:, highwater_mark_offset:)
    @topic = topic
    @partition = partition
    @messages = messages
    @highwater_mark_offset = highwater_mark_offset
  end
end
