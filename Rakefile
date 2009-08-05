require 'rubygems'
$:.unshift(File.dirname(__FILE__) + '/config/boot')

require 'cucumber'
require 'cucumber/rake/task'

namespace( :test ) do
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --guess --format pretty"
  end
  
  Cucumber::Rake::Task.new(:progress) do |t|
    t.cucumber_opts = "features --guess --format progress"
  end
  
  Cucumber::Rake::Task.new(:steps) do |t|
    t.cucumber_opts = "features --guess --format steps"
  end
  
  Cucumber::Rake::Task.new(:usage) do |t|
    t.cucumber_opts = "features --guess --format usage"
  end
  
  Cucumber::Rake::Task.new(:tag_cloud) do |t|
    t.cucumber_opts = "features --guess --format progress --format tag_cloud --out=./tmp/tag_cloud.html"
  end
  
  Cucumber::Rake::Task.new(:html) do |t|
    t.cucumber_opts = "features --guess --format progress --format html --out=./public/features_report.html"
  end
end

namespace :server do
  desc 'restart the web server'
  task :restart do
    `touch tmp/restart.txt`
  end
end