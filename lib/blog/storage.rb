require 'yaml'

module Blog
 
  class Storage

    def initialize(base_dir)
      @base_dir = base_dir
      yaml_path = ("./resources/test_data/posts.yml")       # find the .yml file

      @yaml = YAML::load(File.open(yaml_path))               # open the yml file and load its contents - results in an array of hashes, one for each post
    end

    def get_all_posts()
      
                
           
      posts = @yaml.map do |value|
        Blog::Post.new(value["id"], value["title"], value["date"])       # iteration on the array of hashes harvests the value for 'title' and 'date' from each hashmap
      end                                                                # and uses it as an argument for the Post class which returns a post object 

      return posts      # returns an array of post objects 
    end
  
    def get_post_by_id(id)
       @yaml.map do |value|
        if value["id"] == id
          return OpenStruct.new(value)         # the output of this method should be an object, on which the method .title could be called.
        end                                                  # to do that, an iteration is implemented and if the id value of a Hashmap equals the argument,     
      end                                                    # a new instance of the OpenStruct class is created, with which an object is generated.    
     end                                                    

    end
end


