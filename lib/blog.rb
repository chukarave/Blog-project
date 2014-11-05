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
      p = Blog::Storage.new(BASE_DIR)
      posts = p.get_all_posts()
      
      return erb :home, :locals => {:posts => posts} 
    end

    # HTTP GET "/2014/08/13/foobar-derp"
    get '/:year/:month/:day/:id' do

      p = Blog::Storage.new(BASE_DIR)
      post = p.get_post_by_id_date(params[:year], params[:month], params[:day], params[:id])
     
      if post == nil
        status 404
        return erb :client_error
      end  

      mdpath = File.open(File.join(BASE_DIR, ["%04d" % post.date.year,  
                                              "%02d" % post.date.month, 
                                              "%02d" % post.date.day,  
                                              params[:id] + ".md"]))
      markdown = RDiscount.new(File.read(mdpath))
      mdpath.close
      content = markdown.to_html
      return  erb :show_post, :locals => {:post => post, :content => content}

    end 

    get '/new' do
      erb :new_post
    end

    post '/new' do 

      post_title = params[:title]
      post_content = params[:content]
      
      if post_title.empty? || post_content.empty?     
        status 400
        return erb :client_error
      end
      

      post_date = Date.today
      i = Blog::Storage.new(BASE_DIR)
      id = i.make_id(post_title)

      p = Blog::Post.new(id, post_title, post_date)
      p.content = post_content

      begin
        i.save(p)
      rescue
        status 500
        return erb :server_error
      end

      url = "/" + ["%04d" % p.date.year,  
                   "%02d" % p.date.month, 
                   "%02d" % p.date.day,  
                   p.id].join("/")
      
      redirect to(url)
    

      
    end
  end
end
