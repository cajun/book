class Application < Sinatra::Base
  use_in_file_templates!
  
  get '/styplesheet.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass :stylesheet
  end
end

__END__

@@ layout
!!! 1.1
%html
  %head
    %script{ :type => 'text/javascript', :src => '/javascripts/jquery-1.3.2.min.js' }
    = page_cached_timestamp
  %title require 'cookbook'
  %a{ :href => '/' } Go Home!!!
  %a{ :href => '/recipes/' } Check out the Recipes

  
  #body 
    =yield
  
  #version
    == You are running Sinatra v#{Sinatra::VERSION}