# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubymotion/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "motion-kramdown"
  gem.version       = MotionKramdown::VERSION
  gem.authors       = ['Brett Walker', 'Thomas Leitner']
  gem.email         = ['github@digitalmoksha.com', 't_leitner@gmx.at']
  gem.summary       = "RubyMotion version of kramdown parser for Markdown"
  gem.description   = "A light modification of the kramdown Markdown gem, for use with RubyMotion on iOS and OS X."
  gem.homepage      = 'https://github.com/digitalmoksha/motion-kramdown'
  gem.licenses      = ['MIT']
  
  gem.files         = Dir.glob('lib/**/*.rb')
  gem.files        << 'README.md'
  gem.test_files    = Dir.glob('spec/**/*.rb')

  gem.require_paths = ['lib']

  gem.add_dependency 'motion-strscan', '~> 0.5'
  gem.add_dependency 'motion-yaml', '~> 1.4'

end