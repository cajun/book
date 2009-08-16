irb = RUBY_PLATFORM =~ /(:?mswin|mingw)/ ? 'irb.bat' : 'irb'

require 'optparse'

options = { :sandbox => false, :irb => irb }
OptionParser.new do |opt|
  opt.banner = "Usage: console [environment] [options]"
  opt.on('-s', '--sandbox', 'Rollback database modifications on exit.') { |v| options[:sandbox] = v }
  opt.on("--irb=[#{irb}]", 'Invoke a different irb.') { |v| options[:irb] = v }
  opt.on("--debugger", 'Enable ruby-debugging for the console.') { |v| options[:debugger] = v }
  opt.parse!(ARGV)
end

libs =  " -r irb/completion"
libs << " -r #{File.dirname( __FILE__ ) + '/../book.rb'}"

if options[:debugger]
  begin
    require 'ruby-debug'
    libs << " -r ruby-debug"
    puts "=> Debugger enabled"
  rescue Exception
    puts "You need to install ruby-debug to run the console in debugging mode. With gems, use 'gem install ruby-debug'"
    exit
  end
end

# puts "Loading #{ENV['RAILS_ENV']} environment (Rails #{Rails.version})"

exec "#{options[:irb]} #{libs} --simple-prompt"
