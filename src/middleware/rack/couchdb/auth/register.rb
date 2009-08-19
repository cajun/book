module Rack
  module CouchDB
    module Register
      def register?
        "/register" == request.path_info && request.post?
      end
      
      def register_params
        params[@klass.to_s.downcase]
      end
      
      def activate?
        /^\/activate/ =~ request.path_info
      end
      
      def activate!
        token = request.path_info.split( '/' ).last
        klass_instance = klass.by_single_access_token( :key => token ).first
        if( klass_instance )
          klass_instance.activate!
          klass_instance.set_env_success( request )
          klass.current =  klass_instance
        else
          flash['notice'] = 'Sorry cher.  I could not find you.  Please email me for some help'
        end
  
        go_home!
      end
      
      def register!
        klass_instance = klass.new register_params
        
        if( klass_instance.save )
          # all went well
          flash['notice'] = "All went good cher.  Check yo emails for an activation link"
          klass_instance.deliver_activation_email( request.env )
          go_home!
        else
          # go back
          flash['error'] = "You didn't to do good.  Go on and try again."
          go_back!
        end
      end
    end
  end
end