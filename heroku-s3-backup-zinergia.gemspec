# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku-s3-backup-zinergia/version"

Gem::Specification.new do |s|
  s.name        = "heroku-s3-backup-zinergia"
  s.version     = Heroku::S3::Backup::Zinergia::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Davis", "Trevor Turk", "Nicolás Hock"]
  s.email       = ["nhocki@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Backup your heroku database to S3 without suffering}
  s.description = %q{Backup your heroku database to S3 without suffering. Based on http://almosteffortless.com/2010/04/14/automated-heroku-backups/}

  s.rubyforge_project = "heroku-s3-backup-zinergia"

  s.add_dependency('right_aws', '>= 2.1.0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
