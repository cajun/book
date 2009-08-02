module GitInfo
  def last_deploy
    `git log -n1 --pretty=email`
  end
end

Sinatra::Base.send :include, GitInfo
