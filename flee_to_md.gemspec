require File.expand_path("../lib/flee_to_md", __FILE__)

Gem::Specification.new do |flee_to_md|
  flee_to_md.name          = "flee_to_md"
  flee_to_md.version       = Flee_to_md::VERSION
  flee_to_md.date          = Flee_to_md::LAST_UPDATED
  flee_to_md.summary       = "Helps convert a big xml file (like from squarespace) into separate markdown files (like for statamic)"
  flee_to_md.description   = "Helps convert a big xml file (like from squarespace) into separate markdown files"
  flee_to_md.authors       = ["Max Jacobson"]
  flee_to_md.email         = "max@maxjacobson.net"
  flee_to_md.files         = Dir[
                            './*.{md,gemspec}',
                            './.gitignore',
                            './bin/*',
                            './lib/*'
                          ]
  flee_to_md.require_paths = ["lib"]
  flee_to_md.executables   = ["flee_to_md"]
  flee_to_md.homepage      = "http://rubygems.org/gems/flee_to_md"
  flee_to_md.license       = "MIT"
  flee_to_md.required_ruby_version = '>= 1.8.7'
  flee_to_md.add_runtime_dependency 'nokogiri'
  flee_to_md.add_runtime_dependency 'kramdown'
  flee_to_md.add_runtime_dependency 'ruby-progressbar'
end
