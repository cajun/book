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
    def authenticate( name, password )
      user = [ by_email( :key => name ), by_login( :key => name ) ].flatten.compact.first
      
      user if( user && user.encrypted_password == password )
    end
  end
  
  module InstanceMethods
    attr_accessor :password
    
    # If the object has been assigned a password then encrypt it
    def encrypt_password!
      if( password )
        self['encrypted_password_store'] = BCrypt::Password.create( password, :cost => 11 )
      end
    end

    # The BCrypt version of the encrypted password
    # This version will allow 
    #
    # @return [BCrypt::Password] the encrypted password as a BCrypt Object
    def encrypted_password
      BCrypt::Password.new( self['encrypted_password_store'] )
    end

    # Setting Magic Fields on a succesful login
    # 
    # @param [Request] request request object from the controller
    def set_env_success( request )
      login_count += 1
      last_login_at = current_login_at
      current_login_at = Time.now
      last_login_ip = current_login_ip
      current_login_ip = request.env["REMOTE_ADDR"]
      save
    end
    
    def set_env_failure( request = nil )
      failed_login_count += 0
      save
    end
    
    # Email Regular Expression Validator
    def email_regex
      /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    end
    
    # Validation Test for the email
    def valid_email
      unless( email.blank? )
        unless( email =~ email_regex )
          errors.add(:email, "Your email address does not appear to be valid")
        else
          errors.add(:email, "Your email domain name appears to be incorrect") unless validate_email_domain(email)
        end
      end
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
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    
    receiver.send :save_callback, :before, :encrypt_password!
    receiver.send :create_callback, :before, :encrypt_password!

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