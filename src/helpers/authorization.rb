class Authorization
  attr_accessor :app, :options
  def initialize(app, options={} )
    @app = app
    @options = options
  end
  
  def call( env )
    
  end
  
  def auth
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
  end

  def protected!
    unauthorized! unless( authorized? )
  end
  
  def unauthorized!(realm="book.samuraidelicatessen.org")
    header 'WWW-Authenticate' => %(Basic realm="#{realm}")
    throw :halt, [ 401, 'Authorization Required' ]
  end

  def bad_request!
    throw :halt, [ 400, 'Bad Request' ]
  end

  def authorized?
    request.env['REMOTE_USER']
  end

  def authorize(username, password)
    # Insert your logic here to determine if username/password is good
    # @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    # @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
    
    puts "*" * 50
    puts auth.methods.sort
    puts auth.provided?
    puts 
    puts "*" * 50
    
    false
  end

  def require_administrative_privileges
    return if authorized?
    unauthorized! unless auth.provided?
    bad_request! unless auth.basic?
    unauthorized! unless authorize(*auth.credentials)
    request.env['REMOTE_USER'] = auth.username
  end

  def admin?
    authorized?
  end

end
