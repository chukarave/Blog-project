require 'sinatra'
require 'date'

require "blog/version"
require "blog/post"
require "blog/storage"

module Blog
  class App < Sinatra::Application
    #set :port, 8080 # the application should not decide, on which port it runs
    set :static, true
    set :public_folder, "static"
    set :views, "views"

    #enable :sessions # this si not yet needed

    get '/' do
      return 'Hello world'
    end
  end
end
