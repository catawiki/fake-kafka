class Fake::Kafka::Producer
  def initialize(kafka)
    @kafka = kafka
    @buffer = []
  end

  def produce(value, **options)
    @buffer << [value, options]
  end

  def deliver_messages
    @buffer.each do |value, **options|
      @kafka.deliver_message(value.to_s, **options)
    end
  end
end
