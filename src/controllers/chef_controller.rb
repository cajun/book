module Sinatra
  module ChefController
    def self.registered(app)
      # ================
      # = CRUD Pages =
      # ================

      # index
      app.get %r{/chef/index.?(\w*)} do |extention|
        klass = klass_name.modulize.constantize
        @chefs = Chef.all( :limit => 10 )
        
        case extention
        when "json"
          @chefs.to_json
        else
          haml( "#{klass_name}/index".to_sym )
        end
      end

      # new
      app.get %r{/chef/new} do |klass_name|
        haml( "chef/new".to_sym )
      end

      # show
      app.get %r{/chef/(\w+).?(\w*)} do |id,extention|
        @chefs = Chef.get( id )

        case extention
        when "json"
          @chefs.to_json
        else
          haml( "chef/show".to_sym )
        end
      end

      # create
      app.post %r{/chef/create.?(\w*)} do |klass_name,extention|
        expire_cache( "/chef/index" )
        @chef = Chef.new( params[klass_name] )
        
        if( @chef.save )
          redirect "/chef/#{var.id}.#{extention}"
        else
          case extention
          when "json"
            { :errors => @chef.errors.to_json, :status => :error, :message => "Faild to save" }.to_json
          else
            "chef/new".to_sym
          end
        end
      end
    end
  end
  
  register ChefController
end