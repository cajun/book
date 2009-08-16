module CouchSecurity
  module ClassMethods
    attr_accessor :current

    # Make the following views
    # view_by current_login_at + 10 min to see how many people are logged in
    
    # Authentication Method that will accept the user's email
    # or the user's login.
    #
    # @param [String] name email or login for the user
    # @param [String] password guess what this field is...the password field
    # 
    # @return [Chef,nil] if a chef is returned then authentication worked, nil if not
    def authenticate( name, password, request = nil )
      user = [ by_email( :key => name ), by_login( :key => name ) ].flatten.compact.first
      
      if ( user && user.encrypted_password == password )
        user.set_env_success request 
        user 
      elsif( user )
        user.set_env_failure
        nil
      end
    end
  end
  
  module InstanceMethods
    attr_accessor :password, :password_confirmation
    
    def initialize( args={} )
      @password = args.delete( "password" ) unless args.nil?
      @password_confirmation = args.delete( "confirm_password" ) unless args.nil?
      super( args )
    end
    # If the object has been assigned a password then encrypt it
    def encrypt_password!
      if( !password.blank? )
        self['encrypted_password_store'] = BCrypt::Password.create( password, :cost => 11 )
        password, password_confirmation = nil, nil
      end
    end

    # The BCrypt version of the encrypted password
    # This version will allow 
    #
    # @return [BCrypt::Password] the encrypted password as a BCrypt Object
    def encrypted_password
      BCrypt::Password.new( self['encrypted_password_store'] || '' )
    end

    # Setting Magic Fields on a succesful login
    # 
    # @param [Request] request request object from the controller
    def set_env_success( request = nil )
      self['login_count'] ||= 0
      self['login_count'] += 1
      self['last_login_at'] = current_login_at
      self['current_login_at'] = Time.now
      self['last_login_ip'] = current_login_ip
      if( request )
        self['current_login_ip'] = request.env["REMOTE_ADDR"]
        request.env["REMOTE_USER"] = id
      end
      save
    end

    def set_env_failure( request = nil )
      self['failed_login_count'] ||= 0
      self['failed_login_count'] += 1
      save
    end

    # Email Regular Expression Validator
    def email_regex
      /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    end

    # Validation Test for the email
    def valid_email?
      unless( email.blank? )
        unless( email =~ email_regex )
          return [false, "Your email address does not appear to be valid" ]
        else
          return [false, "Your email domain name appears to be incorrect" ] unless validate_email_domain(email)
        end
      end
      true
    end

    # Validation Test for the email's domain
    #
    # @param [String] email the email addresss that needs to be tested
    def validate_email_domain(email)
      domain = email.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
        @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      !@mx.size.zero?
    end
    
    def valid_password_confirmation?
      if( password )
        unless( password == password_confirmation )
          return [false, "The password does not match the confirmation" ]
        end
      end
      true
    end
    
    def valid_password_length?
      if( password && password.length < 6 )
        [false, "must have more than 6 charters" ]
      else
        true
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    
    receiver.send :save_callback, :before, :encrypt_password!
    receiver.send :create_callback, :before, :encrypt_password!
    
    receiver.send :validates_with_method, :email, :valid_email?
    receiver.send :validates_with_method, :password, :valid_password_confirmation?
    receiver.send :validates_with_method, :password, :valid_password_length?
    
    receiver.send :property, :email
    receiver.send :property, :login
    receiver.send :property, :encrypted_password_store

    receiver.send :property, :login_count, :default => 0
    receiver.send :property, :failed_login_count, :default => 0
    receiver.send :property, :last_request_at
    receiver.send :property, :current_login_at
    receiver.send :property, :last_login_at
    receiver.send :property, :current_login_ip, :default => "0.0.0.0"
    receiver.send :property, :last_login_ip, :default => "0.0.0.0"
    
    receiver.send :view_by, :email
    receiver.send :view_by, :login

    # Must be so it will override functions
    receiver.send :include, InstanceMethods
  end
end