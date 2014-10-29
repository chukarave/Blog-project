require 'yaml'

module Blog
 
  class Storage

    def initialize(base_dir)
      @base_dir = base_dir
    end

    def get_all_posts()
      
      yaml_path = ("./resources/test_data/posts.yml")       # find the .yml file
      
      yaml = YAML::load(File.open(yaml_path))               # open the yml file and load its contents - results in an array of hashes, one for each post
      
      posts = yaml.map do |value|
        Blog::Post.new(value["title"], value["date"])       # iteration on the array of hashes harvests the value for 'title' and 'date' from each hashmap
      end                                                   # and uses it as an argument for the Post class which returns a post object 

      return posts      # returns an array of post objects 
    end
  end
end


