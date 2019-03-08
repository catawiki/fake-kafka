class Fake::Kafka::Consumer
  def initialize(kafka)
    @kafka = kafka
    @topics = []
  end

  def subscribe(topic, **)
    @topics << topic.to_sym
  end

  def each_message(*options, &block)
    @kafka.messages.each do |message|
      next unless @topics.include?(message.topic.to_sym)

      begin
        block.call(message)
      rescue StandardError => e
        raise Kafka::ProcessingError.new(message.topic, message.partition, message.offset)
      end
    end
  end

  def each_batch(*options, &block)
    begin
      batch = Fake::Kafka::Batch.new(
        topic: @kafka.messages.first.topic,
        partition: @kafka.messages.first.partition,
        messages: @kafka.messages,
        highwater_mark_offset: @kafka.messages.first.offset
      )
      block.call(batch)
    rescue StandardError => e
      raise Kafka::ProcessingError.new(batch.topic, batch.partition, batch.highwater_mark_offset)
    end
  end

  def pause(topic, partition, timeout:, max_timeout: nil, exponential_backoff: false)
    @kafka.paused_partitions[topic] ||= {}
    @kafka.paused_partitions[topic][partition] = true
  end

  def stop; end
end
