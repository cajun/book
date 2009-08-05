module GitInfo
  def email
    git_firt_log( "email" )
  end
  
  def deploy_date
    git_firt_log( "format:%cd" )
  end
  
  def deploy_message
    git_firt_log( "format:%s" )
  end
  
  private 
  
  def git_firt_log( format )
    `git log -n1 --pretty=#{format}`
  end
end

Sinatra::Base.send :include, GitInfo
