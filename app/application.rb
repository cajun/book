class Application < Sinatra::Base
  use_in_file_templates!
end

__END__

@@ layout
!!! 1.1
%html
  %head
    = page_cached_timestamp
  %title require 'cookbook'
    
  #body 
    =yield
