# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
 
platform = ENV.fetch('platform', 'osx')
if platform == 'ios'
  require 'motion/project/template/ios'
elsif platform == 'osx'
  require 'motion/project/template/osx'
else
  raise "Unsupported platform #{ENV['platform']}"
end

require 'rubygems'
require 'motion-benchmark'
require 'motion-cocoapods'

begin
  require 'bundler'
  if ARGV.join(' ') =~ /spec/
    Bundler.require :default, :spec
  else
    Bundler.require
  end
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name        = 'MotionKramdown'
  app.identifier  = 'com.digitalmoksha.MotionKramdown'

  # for benchmarking
  app.pods do
    pod 'HoedownObjC'
  end

  DBT.analyze(app)
end
