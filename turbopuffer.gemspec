# frozen_string_literal: true

require_relative "lib/turbopuffer/version"

Gem::Specification.new do |spec|
  spec.name = "turbopuffer"
  spec.version = Turbopuffer::VERSION
  spec.authors = ["Adrián Mugnolo"]
  spec.email = ["adrian@mugnolo.com"]

  spec.summary = "A Ruby client for accessing the Turbopuffer API."
  spec.description = "Turbopuffer is a serverless vector database. This gem lets you access the Turbopuffer API from Ruby."
  spec.homepage = "https://github.com/xymbol/turbopuffer-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.6"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.12", ">= 2.12.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
