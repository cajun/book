require Dir.pwd + "/cook_book"
root_dir = Dir.pwd

set :root, root_dir
set :app_file, File.join(root_dir, 'cook_book.rb')
set :run, false
set :cache_enabled, false
set :public, root_dir + '/public'
set :environment, ENV['RACK_ENV'].to_sym
set :sessions, true

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

# Mount our Main class with a base url of /
run Sinatra::Application
