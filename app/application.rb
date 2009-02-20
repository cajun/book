class Application < Sinatra::Base
  use_in_file_templates!
end

__END__

@@ layout
!!! 1.1
%html
  %head
  %title require 'cookbook'
    
  #body 
    =yield
