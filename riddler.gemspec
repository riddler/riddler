lib = File.expand_path "lib", __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require "riddler/version"

Gem::Specification.new do |spec|
  spec.name          = "riddler"
  spec.version       = Riddler::VERSION
  spec.authors       = ["JohnnyT"]
  spec.email         = ["ubergeek3141@gmail.com"]

  spec.summary       = %q{Dynamic content and workflow engine}
  spec.homepage      = "https://github.com/riddler/riddler"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to? :metadata
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = [spec.metadata["source_code_uri"], "CHANGELOG.md"].join "/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir __dir__ do
    `git ls-files -z`.split("\x0").select { |f| f.match %r{^(riddler.gemspec|LIC|CODE|READ|lib/riddler)} }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename f }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "grpc"
  spec.add_dependency "liquid"
  spec.add_dependency "outlog"
  spec.add_dependency "predicator"
  spec.add_dependency "ulid-ruby"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
