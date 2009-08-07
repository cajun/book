module Sinatra
  module Login
    def self.registered(app) 
      app.get '/login' do
        haml( :login )
      end

      app.post '/login' do
        @chef = Chef.authenticate( params[:login], params[:password] )
        if( @chef )
          # logged in 
          session[:chef_id] = @chef.id
          @chef.set_env( request )
          haml( "/" )
        else
          # failed
          haml( "/" )
        end
      end

      app.post '/logout' do
      end  
    end
  end
  
  register Login
end

