module Sinatra
  module SessionAuth
    
    def authenticate_with_http_basic(&block)
      @auth = Rack::Auth::Basic::Request.new(controller.request.env)
      if @auth.provided? and @auth.basic?
        block.call(*@auth.credentials)
      else
        false
      end
    end
    
    def cookie_domain
      raise NotImplementedError.new("The cookie_domain method has not been implemented by the controller adapter")
    end

    def request_content_type
      request.content_type
    end
    
    def responds_to_single_access_allowed?
      respond_to?(:single_access_allowed?, true)
    end
    
    def single_access_allowed?
      send(:single_access_allowed?)
    end
    
    def responds_to_last_request_update_allowed?
      respond_to?(:last_request_update_allowed?, true)
    end
    
    def last_request_update_allowed?
      send(:last_request_update_allowed?)
    end
    
    private
      def method_missing(id, *args, &block)
        controller.send(id, *args, &block)
      end
  end
  register SessionAuth
end
