module Tokens
  module ClassMethods
    
  end
  
  module InstanceMethods
    def deliver_activation_email( env = nil )
      self['single_access_token'] = friendly_token
      save
      deliver_mail(
        'Book Activation Request',
        "AIEEE! #{login}
        Seems like you want to join in the fun.  
        Come on over to 
        
          http://#{env['HTTP_HOST']}/activate/#{single_access_token}
        
        and start to play.
        
        LAISSEZ LES BONS TEMPS ROULER!
        The Cajun"
      )
    end
    
    def activate!
      self['single_access_token'] = nil
      save
    end
    
    def reset_password!
      self['single_access_token'] = nil
      save
    end
    
    def deliver_reset_password_email
      password = friendly_token
      password_confirmation = password
      save
      
      deliver_mail(
        'Book Password Reset Request',
        "Mon cher,
        I hear you forgot your password.  Don't you worry none.  
        The good ole' cajun here is watching out fer ya
        Just go on over to
      
          http://#{env['HTTP_HOST']}/
          
          and login with
          
          #{password}
      
        and I'll fix you rat a way.
      
        Merci Beaucoup
        The Cajun"
      )
    end
    
    def deliver_mail( subject, body, from = 'cajun@samuraidelicatessen.org' )
      unless( ENV['RACK_ENV'] == 'test' )
        Pony.mail( :to => email, :from => from,
          :subject => subject , :body => body, :via => :smtp,
          :smtp => { 
            :host => configatron.smtp.host, 
            :domain => configatron.smtp.domain,
            :user => configatron.smtp.user,
            :password => configatron.smtp.password,
            :port => configatron.smtp.port,
            :auth => configatron.smtp.auth
          }
        )
      end
    end
    
    private
    # Taken from AuthLogic
    FRIENDLY_CHARS = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    
    def friendly_token
      newpass = ""
      1.upto(20) { |i| newpass << FRIENDLY_CHARS[rand(FRIENDLY_CHARS.size-1)] }
      newpass
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    
    receiver.send :property, :persistence_token
    receiver.send :property, :single_access_token
    receiver.send :property, :perishable_token
    
    receiver.send :view_by, :persistence_token
    receiver.send :view_by, :single_access_token
    receiver.send :view_by, :perishable_token
    
    receiver.send :include, InstanceMethods
  end
end