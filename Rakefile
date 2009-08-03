require 'rubygems'
$:.unshift(File.dirname(__FILE__) + '/config/boot')

namespace( :cucumber ) do
  task :features do
    `cucumber --guess --format pretty features`
  end

  task :profile do
    `cucumber --guess --format profile features`
  end

  task :progress do
    `cucumber --guess --format progress features`
  end
  
  task :html_report do
    `cucumber --guess --format progress --format html --out=features_report.html features`
    `open features_report.html`
  end
end

namespace :server do
  desc 'restart the web server'
  task :restart do
    `touch tmp/restart.txt`
  end
end