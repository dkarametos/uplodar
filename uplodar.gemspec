$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "uplodar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "uplodar"
  s.version     = Uplodar::VERSION
  s.authors     = ["dimitrios karametos"]
  s.description = "just an uplodar"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'devise'
  s.add_development_dependency 'kaminari'

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "jquery-rails"
  s.add_dependency 'cancan', '1.6.7'
  s.add_dependency 'simple_form'
  s.add_dependency 'kaminari'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'twitter-bootstrap-rails', '~>2.1.3'
end
