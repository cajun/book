# Examples:
# 
# use Rack::Auth::Basic do |username, password|
#  [username, password] == ['admin', 'admin']
# end
#
# get '/' do
#   "Everybody can see this page"
# end
# 
# get '/protected' do
#   protected!
#   "Welcome, authenticated client"
# end
module Sinatra
  module Security

    def protected!
      response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth") and \
      throw(:halt, [401, "Not authorized\n"]) and \
      return unless authorized?
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
    end
  end
  
  helpers Security
end

