$:.unshift("/Library/RubyMotion/lib")

platform = ENV.fetch('platform', 'osx')
testing  = true if ARGV.join(' ') =~ /spec/

require "motion/project/template/#{platform}"
require 'rubygems'
require 'motion-benchmark'
require 'motion-cocoapods'

begin
  require 'bundler'
  testing ? Bundler.require(:default, :spec) : Bundler.require
rescue LoadError
end

require 'bacon-expect' if testing

Motion::Project::App.setup do |app|
  app.name        = 'MotionKramdown'
  app.identifier  = 'com.digitalmoksha.MotionKramdown'

  # for benchmarking
  app.pods do
    pod 'HoedownObjC'
  end

  DBT.analyze(app)
end
