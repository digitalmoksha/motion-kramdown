# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

platform = ENV.fetch('platform', 'osx')
testing  = true if ARGV.join(' ') =~ /spec/

require "motion/project/template/#{platform}"
require 'rubygems'
require 'motion-benchmark'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  testing ? Bundler.require(:default, :spec) : Bundler.require
rescue LoadError
end

require 'motion-expect' if testing

Motion::Project::App.setup do |app|
  app.name        = 'MotionKramdown'
  app.identifier  = 'com.digitalmoksha.MotionKramdown'

  if platform == 'ios'
    # must set to the maximum SDK that the open source license supports,
    # which is the latest non-beta
    app.sdk_version           = '13.5'
    app.deployment_target     = '13.5'
  end

  DBT.analyze(app)
end
