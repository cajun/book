module GitInfo
  def email
    `git log -n1 --pretty=email`
  end
  
  def deploy_date
    `git log -n1 --pretty=format:%cd`
  end
  
  def deploy_message
    `git log -n1 --pretty=format:%s`
  end
end

Sinatra::Base.send :include, GitInfo
