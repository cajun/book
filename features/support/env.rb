# Sinatra - my views are not in the cucumber bin dir!
$0 = File.dirname(__FILE__) + '/../../config/boot.rb'
require 'spec'
# require 'webrat/sinatra/sinatra_session'
# require 'sinatra/test/common'
require File.dirname(__FILE__) + '/../../config/boot'

# World do
#   Webrat::SinatraSession.new
# end