module Rack
  module CouchDB
    module Auth
      def unauthorized
        return [ 401,
          { 'Content-Type' => 'text/plain',
            'Content-Length' => '0',
            'WWW-Authenticate' => "blah blah blah" },
          [ "REJECTED!!!! YOU FAILED!!!! AHAHAHA!!!! I WIN!!!!" ]
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
      
      def login?
        "/login" == request.path_info && request.post? && auth_provided?
      end

      def login!
        klass_instance = klass.authenticate( params["login"], params["password"], request )
        if( klass_instance.nil? )
          unauthorized
        else
          flash['notice'] = "Laissez les bon temps rouler!"
          klass_instance.set_env_success( request )
          klass.current =  klass_instance
          go_home!
        end
      end

      def logout?
        "/logout" == request.path_info
      end

      def logout!
        flash['notice'] = 'Merci Beaucoup'
        klass.current = nil
        request.env['REMOTE_USER'] = nil
        go_home!
      end
      
    end
  end
end