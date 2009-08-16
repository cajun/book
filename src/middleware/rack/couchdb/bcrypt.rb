 
module Rack
  module CouchDB
    class BCrypt
      attr_accessor :request, :response, :klass
      def initialize(app, options)
        @app, @options = app, options
        puts "App #{@app} :: Options #{@options.inspect}"
        @klass = @options[:klass]
        klass.send( :include, CouchSecurity )
        klass.send( :include, Tokens )
      end
      
      def call( env )
        @request = Request.new( env )
        @response = Response.new( env )
        
        # if the request is a post request then we might have some work to do
        if( authorized? && !logout? )
          klass.current =  klass.get( request.env['REMOTE_USER'] )
          @app.call(env)
        else
          if( request.post? && login? && auth_provided? )
            login!
          elsif( logout? )
            logout!
          else
            @app.call(env)
          end
        end
        
      end
      
      def unauthorized
        return [ 401,
          { 'Content-Type' => 'text/plain',
            'Content-Length' => '0',
            'WWW-Authenticate' => "blah blah blah" },
          [ "REJECTED!!!! YOU FAILED!!!! AHAHAHA!!!!" ]
        ]
      end
      
      def protected!
        unauthorized unless authorized?
      end
      
      def authorized?
        request.env['REMOTE_USER'] && klass.get( request.env['REMOTE_USER'] )
      end

      def auth_provided?
        params.keys.include?( "login" ) && params.keys.include?( "password" )
      end
      
      def go_home!
        response.redirect '/'
        response.finish
      end
      
      def params
        request.params
      end
      
      def login?
        "/login" == request.path_info
      end
      
      def login!
        klass_instance = klass.authenticate( params["login"], params["password"], request )
        if( klass_instance.nil? )
          unauthorized
        else
          klass_instance.set_env_success( request )
          klass.current =  klass_instance
          go_home!
        end
      end
        
      def logout?
        "/logout" == request.path_info
      end

      def logout!
        klass.current = nil
        request.env['REMOTE_USER'] = nil
        go_home!
      end
      
      
    end # BCrypt
  end # CouchDB
end # Rack