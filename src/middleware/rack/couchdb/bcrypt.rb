 
module Rack
  module CouchDB
    class BCrypt
      include Rack::CouchDB::Auth
      include Rack::CouchDB::Register
      
      attr_accessor :request, :response, :klass, :flash
      
      def initialize(app, options)
        @app, @options = app, options
        @klass = @options[:klass]
        klass.send( :include, CouchSecurity )
        klass.send( :include, Tokens )
      end
      
      def call( env )
        set_env( env )
        
        # if the request is a post request then we might have some work to do
        if( login? )
          login!
        elsif( logout? )
          logout!
        elsif( authorized? )
          klass.current =  klass.get( request.env['REMOTE_USER'] )
          @app.call(env)
        else
          @app.call(env)
        end
      end
      
      def set_env( env )
        @request = Request.new( env )
        @response = Response.new( env )
        @flash = env['x-rack.flash']
      end
      
      def go_home!
        response.redirect '/'
        response.finish
      end
      
      def params
        request.params
      end

    end # BCrypt
  end # CouchDB
end # Rack