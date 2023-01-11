lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fake/kafka/version"

Gem::Specification.new do |spec|
  spec.name          = "fake-kafka"
  spec.version       = Fake::Kafka::VERSION
  spec.authors       = ["Sebastian Arcila Valenzuela"]
  spec.email         = ["opensource@catawiki.nl"]
  spec.license       = 'MIT'
  spec.summary       = %q{Fake Kafka Consumer and Producer.}
  spec.description   = %q{In memory 'kafka' instruments design for testing integrations with kafka.}
  spec.homepage      = "https://github.com/catawiki/fake-kafka"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
