class ApplicationController < Sinatra::Base # sinatra gem that we added to our gemfile 
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

end
