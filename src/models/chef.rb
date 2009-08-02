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
  
  view_by :email
  view_by :login
  view_by :last_name
  
  save_callback :before, :encrypt_password
  create_callback :before, :encrypt_password
  
  class << self
    def authenticate( name, given_password )
      chef = [ by_email( :key => name ), by_login( :key => name ) ].flatten.first
      chef if( chef && chef.encrypted_password == given_password )
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
end