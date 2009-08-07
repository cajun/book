require Dir.pwd + "/cook_book"

set :root, File.dirname(__FILE__)
set :app_file, Proc.new { File.join(root, "cook_book.rb") }
set :run, false
set :cache_enabled, false
#set :public, Proc.new { File.join(root, "public") }
#set :views, Proc.new { File.join(root, "views") }
set :environment, ENV['RACK_ENV'].to_sym
set :sessions, true
set :static, true

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

# Mount our Main class with a base url of /
run Book
