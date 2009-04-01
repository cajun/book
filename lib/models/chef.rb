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
  
  class << self
    def authenticate( name, given_password )
      chef = [ by_email( :key => name ), by_login( :key => name ) ].flatten.first
      chef if( chef && chef.password == given_password )
    end
    
    def email_regex
      /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    end
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
    self['encrypted_password'] = BCrypt::Password.create( value, :cost => 11 )
  end
  
  def password
    BCrypt::Password.new( self['encrypted_password'] )
  end
end