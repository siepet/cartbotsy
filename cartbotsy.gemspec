# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cartbotsy/version"

Gem::Specification.new do |spec|
  spec.name          = "Cartbotsy"
  spec.version       = Cartbotsy::VERSION
  spec.authors       = ["Marcin Siepetowski"]
  spec.email         = ["marcin.siepetowski@netguru.co"]

  spec.summary       = "Slack bot to make your PiP shopping easier"
  spec.homepage      = "https://github.com/siepet/cartbotsy"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "git"
  spec.add_dependency "httparty"
  spec.add_dependency "httmultiparty"
end
