require 'rubygems'
$:.unshift(File.dirname(__FILE__) + '/config/boot')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end

Cucumber::Rake::Task.new("features:pretty") do |t|
  t.cucumber_opts = "--format pretty"
end

Cucumber::Rake::Task.new("features:profile") do |t|
  t.cucumber_opts = "--format profile"
end

Cucumber::Rake::Task.new("features:progress") do |t|
  t.cucumber_opts = "--format progress"
end

Cucumber::Rake::Task.new("features:rerun") do |t|
  t.cucumber_opts = "--format rerun"
end