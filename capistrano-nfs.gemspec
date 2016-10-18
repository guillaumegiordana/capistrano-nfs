# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/nfs/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-nfs"
  spec.version       = Capistrano::NFS::VERSION
  spec.authors       = ["Guillaume GIORDANA"]
  spec.email         = ["guillaume.giordana@gmail.com"]

  spec.summary       = %q{NFS shared folder for capistrano}
  spec.description   = %q{Enables the declaration of an additionnal shared folder}
  spec.homepage      = "https://github.com/guillaumegiordana/capistrano-nfs"
  spec.license       = "MIT"

  spec.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)

  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '>= 3.1.0', '< 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
