$:.push File.expand_path("../lib", __FILE__)
require "cloud_archiver/version"

Gem::Specification.new do |s|
  s.name = "cloud_archiver"
  s.version = CloudArchiver::VERSION
  s.authors = [ "Priit Marandi" ]
  s.email = "priit@grabcad.com"
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.require_paths = [ "lib" ]
  s.homepage = "http://github.com/GrabCAD/cloud_archiver"
  s.licenses = [ "MIT" ]
  s.summary = "Archive files"
  s.add_runtime_dependency 'rubyzip', '> 1.0.0'
end