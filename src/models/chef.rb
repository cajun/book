# 
#  chef.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Chef < Couch
  attr_accessor :casted_by

  property :email
  property :first_name
  property :last_name
  property :login
  property :encrypted_password
  property :login_count
  property :failed_login_count
  property :current_login_at
  property :last_login_at
  property :current_login_ip
  property :last_login_ip
  
  view_by :email
  view_by :login
  view_by :last_name
  # Make the following views
  # view_by current_login_at + 10 min to see how many people are logged in
  
  save_callback :before, :encrypt_password
  create_callback :before, :encrypt_password
  
  class << self
    def authenticate( name, given_password )
      chef = [ by_email( :key => name ), by_login( :key => name ) ].flatten.first
      if( chef && chef.encrypted_password == given_password )
        chef
      elsif( chef )
        chef.failed_login_count += 0
        chef.save
        nil
      end
    end
    
    def email_regex
      /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    end
  end
  
  def initialize( args={} )
    password = args.delete( :password ) unless args.nil?
    super( args )
  end
  
  def valid_email
    unless( email.blank? )
        unless( email =~ email_regex )
            errors.add(:email, "Your email address does not appear to be valid")
        else
            errors.add(:email, "Your email domain name appears to be incorrect") unless validate_email_domain(email)
        end
    end
  end

  def validate_email_domain(email)
        domain = email.match(/\@(.+)/)[1]
        Resolv::DNS.open do |dns|
            @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
        end
        @mx.size > 0 ? true : false
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def password=( value )
    @pass = value
  end
  
  def password
    @pass
  end
  
  def encrypt_password
    if( password )
      self['encrypted_password'] = BCrypt::Password.create( password, :cost => 11 )
    end
  end
  
  def encrypted_password
    BCrypt::Password.new( self['encrypted_password'] )
  end
  
  def login_count
    self['login_count'] || 0
  end
  
  def failed_login_count
    self['failed_login_count'] || 0
  end
  
  def set_env( request )
    login_count += 1
    last_login_at = current_login_at
    current_login_at = Time.now
    last_login_ip = current_login_ip
    current_login_ip = request.env["REMOTE_ADDR"]
    save
  end
end