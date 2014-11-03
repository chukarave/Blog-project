require 'yaml'
require 'fileutils'

module Blog

  class Storage

    def initialize(base_dir)
      @base_dir = base_dir

      unless File.exist?(base_dir)
        FileUtils.mkdir_p(base_dir)
      end

      @yaml_path = File.join(base_dir, ["/posts.yml"])     # find the .yml file
      
      if Array === yaml_load
        # it's ok
      else
        File.open(@yaml_path, "w") do |f| 
          # let's make an empty array and write it, so the YAML strucure is correct
          YAML.dump([], f)
        end
      end
    end

    def yaml_load
      begin
        return YAML::load(File.open(@yaml_path, 'r'))    # open the yml file and load its contents - results in an array of hashes, one for each post
      rescue
        return false
      end  
    end

    def get_all_posts()
      posts = yaml_load.map do |value|
        Blog::Post.new(value["id"], value["title"], value["date"])       # iteration on the array of hashes harvests the value for 'title' and 'date' from each hashmap
      end                                                                # and uses it as an argument for the Post class which returns a post object 

      return posts                                                       # returns an array of post objects 
    end

    def get_post_by_id(id)
      yaml_load.map do |value|
        if value["id"] == id
          return Blog::Post.new(value["id"], value["title"], value["date"])     
          # the output of this method should be an object, on which the method .title could be called. 
        end                                    # to do that, an iteration is implemented and if the id value of a Hashmap equals the argument,     
      end                                      # a new instance of the OpenStruct class is created, with which an object is generated.    
    end                                                    

    def save(post)
      all_posts = get_all_posts()
      post_exists = false
      all_posts.each do |p| 
        if p.id == post.id
          p.title == post.title
          p.date == post.date
          p.content == post.content
          post_exists = true
        end 
      end

      if post_exists == false
        all_posts.push(post)
      end
      save_post_markdown(post)
      yaml_update(all_posts)
    end 

    def save_post_markdown(post)
      mdpath = File.join(@base_dir, ["%04d" % post.date.year,
                                     "%02d" % post.date.month,
                                     "%02d" % post.date.day,
                                     post.id + ".md"])  
      mddir = File.dirname(mdpath)
      unless File.directory?(mddir)
        FileUtils.mkdir_p(mddir)
      end
      File.open(mdpath, 'w') do |f|
        f.write (post.content)
      end
    end  

    def yaml_update(posts)
      posts_hashes = posts.map do |post|
        {'id' => post.id,
        'title' => post.title,
        'date' => post.date} 
      end
      File.open(@yaml_path, 'w') do |y|
        YAML.dump(posts_hashes, y)
      end 
    end  

  end
end
