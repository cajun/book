module Rack
  module CouchDB
    module Register
      def register?
        "/register" == request.path_info && request.post?
      end
      
      def register_params
        params[@klass.to_s.downcase]
      end
    end
  end
end