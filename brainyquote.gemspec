lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brainyquote/version'

Gem::Specification.new do |spec|
  spec.name          = "brainyquote"
  spec.version       = BrainyQuote::VERSION
  spec.authors       = ["Nathaniel Miller"]
  spec.email         = ["dukeoflaser@gmail.com"]
  spec.summary       = "Retrieve random quotes according to topic."
  spec.homepage      = "https://github.com/dukeoflaser/brainyquote-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables << 'brainyquote'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "nokogiri"
end
