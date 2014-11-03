require 'yaml'
require 'fileutils'

module Blog

  class Storage

    def initialize(base_dir)
      @base_dir = base_dir

      unless File.exist?(base_dir)       # makes sure the base directory exists. if not, creates it.   
        FileUtils.mkdir_p(base_dir)
      end

      @yaml_path = File.join(base_dir, ["/posts.yml"])     # instance variable for the .yml file.
      
      if Array === yaml_load
        # it's ok
      else
        File.open(@yaml_path, "w") do |f| 
          # writes an empty array to the yml file, so that the YAML strucure will stay correct after the updates
          YAML.dump([], f)
        end
      end
    end

    def yaml_load
      begin
        return YAML::load(File.open(@yaml_path, 'r'))    # open the yml file and load its contents - results in an array of hashes, one for each post
      rescue
        return false                            # if the yml file is empty, return false
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
      all_posts = get_all_posts()     # calls the get_all_posts method and packs the as an array in a variable
      post_exists = false         # an indication if the given post already exists in the array file 
      all_posts.each do |p|       # if the id of the post is found in the array, update the title, date and content into the hash accordingly.
        if p.id == post.id
          p.title == post.title
          p.date == post.date
          p.content == post.content
          post_exists = true     # reflect that the post already exists. 
        end 
      end

      if post_exists == false     
        all_posts.push(post)    # if the post doesn't exist, push it into the array.
      end
      save_post_markdown(post)   # call the save markdown method with the post argument 
      yaml_update(all_posts)    # call the yaml_update method with all the posts as an argument. 
    end 

    def save_post_markdown(post)
      mdpath = File.join(@base_dir, ["%04d" % post.date.year,   # packs the base dir + date folders into a path variable
                                     "%02d" % post.date.month,  # the strformat takes care of the conversion of month and day      
                                     "%02d" % post.date.day,    # from 1 digit to 2.
                                     post.id + ".md"])          # take the object's id element and create it as the .md file's name. 
      mddir = File.dirname(mdpath)         # dirname returns all the components of the path except for the last file.   
      unless File.directory?(mddir)        # .directory? returns 'true' if the named file is a directory
        FileUtils.mkdir_p(mddir)           # mkdir_p creates directories recursively 
      end
      File.open(mdpath, 'w') do |f|     # write the contents of the post into the markdown file    
        f.write (post.content)
      end
    end  

    def yaml_update(posts)            # the method gets an array of all posts as an argument
      posts_hashes = posts.map do |post|    # converts the array of objects into an array of hashes
        {'id' => post.id,
        'title' => post.title,
        'date' => post.date} 
      end
      File.open(@yaml_path, 'w') do |y|  # write the hashes into the yml file. 
        YAML.dump(posts_hashes, y)
      end 
    end  

  end
end
