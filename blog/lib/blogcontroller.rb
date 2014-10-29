require 'sinatra'
require 'date'


set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

enable :sessions

get '/' do
  return 'Hello world'
end


