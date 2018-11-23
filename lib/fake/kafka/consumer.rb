class Fake::Kafka::Consumer
  def initialize(kafka)
    @kafka = kafka
    @topics = []
  end

  def subscribe(topic, **)
    @topics << topic
  end

  def each_message(*options, &block)
    @kafka.messages.each do |message|
      next unless @topics.include?(message.topic)

      begin
        block.call(message)
      rescue StandardError => e
        raise Kafka::ProcessingError.new(message.topic, message.partition, message.offset)
      end
    end
  end

  def pause(topic, partition, timeout:, max_timeout: nil, exponential_backoff: false)
    @kafka.paused_partitions[topic] ||= {}
    @kafka.paused_partitions[topic][partition] = true
  end

  def stop; end
end
