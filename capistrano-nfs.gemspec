# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/nfs/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-nfs"
  spec.version       = Capistrano::Nfs::VERSION
  spec.authors       = ["Guillaume GIORDANA"]
  spec.email         = ["guillaume.giordana@gmail.com"]

  spec.summary       = %q{NFS shared folder for capistrano}
  spec.description   = %q{Enables the declaration of an additionnal shared folder}
  spec.homepage      = "https://github.com/guillaumegiordana/capistrano-nfs"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '>= 3.1.0', '< 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
