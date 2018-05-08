$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "segment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "segment"
  s.version     = Segment::VERSION
  s.authors     = ["David Van Der Beek"]
  s.email       = ["earlynovrock@gmail.com"]
  s.homepage    = "https://github.com/dvanderbeek/segment"
  s.summary     = "Easily display segments of your data."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "ransack", "~> 1.8.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "bootstrap", '~> 4.1.1'
end
