#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake/testtask'

task default: [:test]

Rake::TestTask.new do |tt|
  test.pattern = 'test/**/test_*.rb'
  tt.verbose = true
end
