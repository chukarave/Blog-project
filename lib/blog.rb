require 'sinatra'
require 'date'
require 'rdiscount'

require "blog/version"
require "blog/post"
require "blog/storage"

module Blog
  class App < Sinatra::Application

    BASE_DIR = "./blog/posts"
    #set :port, 8080 # the application should not decide, on which port it runs
    set :static, true
    #set :public_folder, "static"

    #enable :sessions # this si not yet needed

    # HTTP GET /
    get '/' do
      redirect to('/home') 
    end

    get '/home' do
      p = Blog::Storage.new(BASE_DIR)     # creates the base directory for new and existing posts.
      posts = p.get_all_posts()           # get an array of all existing posts in order to pass to the view.
      
      return erb :home, :locals => {:posts => posts} # display home.erb.
    end

    # HTTP GET "/2014/08/13/foobar-derp"
    get '/:year/:month/:day/:id' do       # create the URL to each post 

      p = Blog::Storage.new(BASE_DIR)
      post = p.get_post_by_id_date(params[:year], params[:month], params[:day], params[:id])  # get the date and id params in order to pass to the get_post_by_id_date method.
     
      if post == nil          # if no post was returned by the method return client_error.erb.
        status 404
        return erb :client_error
      end  

      mdpath = File.open(File.join(BASE_DIR, ["%04d" % post.date.year,      # create the path to the markdown file,
                                              "%02d" % post.date.month,     # use string formatter to convert month and day to 2 digit numbers.
                                              "%02d" % post.date.day,  
                                              params[:id] + ".md"]))
      markdown = RDiscount.new(File.read(mdpath))                          # open and read the markdown file.
      mdpath.close                                                         # close the markdown.   
      content = markdown.to_html                                           # convert the markdown to html and assigns to a variable .
      return  erb :show_post, :locals => {:post => post, :content => content} # returns show_post.erb.

    end 

    get '/new' do                   # navigate the /new request to the new post form.
      erb :new_post
    end

    post '/new' do                

      post_title = params[:title]           # assigns variables to the title and content params.
      post_content = params[:content]
      
      if post_title.empty? || post_content.empty?     # error handling - if either title or content field is empty, return client_error.erb.
        status 400
        return erb :client_error
      end
      
      post_date = Date.today            # assign today's date to the newly created post.
      i = Blog::Storage.new(BASE_DIR)
      id = i.make_id(post_title)      # creates the post id by calling the make_id method (in storage.rb).

      p = Blog::Post.new(id, post_title, post_date) # creates a new post object.
      p.content = post_content        # assign the entered content as the post object content.

      begin
        i.save(p)
      rescue                        #  error handling - if something went wrong on the server side during the saving of the post, return server_error.erb.
        status 500
        return erb :server_error
      end

      url = "/" + ["%04d" % p.date.year,    # creates the post URL path.
                   "%02d" % p.date.month, 
                   "%02d" % p.date.day,  
                   p.id].join("/")
      
      redirect to(url)              # redirects to the newly created post. 
    

      
    end
  end
end
