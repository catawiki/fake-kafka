class Fake::Kafka::Message
  attr_reader :key, :topic, :partition, :offset
  def initialize(value, key, topic, partition, offset)
    @value = value
    @key = key
    @topic = topic
    @partition = partition
    @offset = offset
  end

  def value
    @value.to_json
  end
end
