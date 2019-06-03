
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "reslacks/version"

Gem::Specification.new do |spec|
  spec.name          = "reslacks"
  spec.version       = Reslacks::VERSION
  spec.authors       = ["Cian Gallagher"]
  spec.email         = ["cian@ciangallagher.net"]

  spec.summary       = "Setup and automate slack notifications for  any action in your app."
  spec.homepage      = "https://ciangallagher.net"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/Cian911/reslacks"
    spec.metadata["changelog_uri"] = "https://github.com/Cian911/reslacks/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development Dependencies
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug", "~> 11.0.1"
  spec.add_development_dependency "dotenv", "~> 2.7.2"
  spec.add_development_dependency "faker", "~> 1.9.3"
  spec.add_development_dependency "factory_bot", "~> 5.0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.49.0"

  # Actual Dependencies
  spec.add_dependency "slack-notifier"
end
