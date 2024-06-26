# frozen_string_literal: true

require_relative "lib/bundler/toolbox/version"

Gem::Specification.new do |spec|
  spec.name          = "bundler-toolbox"
  spec.version       = Bundler::Toolbox::VERSION
  spec.authors       = ["Christoph Olszowka"]
  spec.email         = ["christoph at olszowka dot de"]

  spec.summary       = "Bundler plugin for getting information about your gems from Ruby Toolbox"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/rubytoolbox/bundler-toolbox"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rubytoolbox/bundler-toolbox"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    # Since for running plugin integration tests we need to install the gem itself
    # this includes modified files too
    `git ls-files -mc -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-cli", "~> 0.6.0"
  spec.add_dependency "rubytoolbox-api", ">= 0.2.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end
