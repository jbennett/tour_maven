require_relative "lib/tour_maven/version"

Gem::Specification.new do |spec|
  spec.name        = "tour_maven"
  spec.version     = TourMaven::VERSION
  spec.authors     = ["Jonathan Bennett"]
  spec.email       = ["jonathan@jbennett.me"]
  spec.homepage    = "https://jbennett.me"
  spec.summary     = "TourMaven is a backend for tourguide.js"
  spec.description = "TourMaven is a backend for tourguide.js"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jbennett/tour_maven"
  spec.metadata["changelog_uri"] = "https://github.com/jbennett/tour_maven/changelog"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.6"
end
