module GitInfo
  include Grit
  
  # Last deploy date
  def deploy_date
    last_commit.committed_date
  end
  
  # Last Message for the deploy
  def deploy_message
    last_commit.message
  end
  
  private 
  
    # Last commit in the repo
    def last_commit
      @head ||= repo.commits( 'master', 1 ).first
    end
  
    # The Repo
    def repo
      @repo ||= Repo.new( ROOT )
    end
end
