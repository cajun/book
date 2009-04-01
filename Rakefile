require 'rubygems'
$:.unshift(File.dirname(__FILE__) + '/config/boot')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--guess --format pretty"
end

Cucumber::Rake::Task.new("features:pretty") do |t|
  t.cucumber_opts = "--guess --format pretty"
end

Cucumber::Rake::Task.new("features:profile") do |t|
  t.cucumber_opts = "--guess --format profile"
end

Cucumber::Rake::Task.new("features:progress") do |t|
  t.cucumber_opts = "--guess --format progress"
end

Cucumber::Rake::Task.new("features:rerun") do |t|
  t.cucumber_opts = "--guess --format rerun"
end

namespace :server do
  desc 'restart the web server'
  task :restart do
    `touch tmp/restart.txt`
  end
end