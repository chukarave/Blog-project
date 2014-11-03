module Blog

  class Post
    attr_accessor :title, :date    # read existing data only
    attr_reader :id
    attr_accessor :content      # read existing data or write new data

    def initialize(id, title, date) 
      @title = title
      @date = date    
      @content = content
      @id = id
    end

  end

end

# Post receives title and date as arguments. it returns the corresponding title of a post and the date in which it was written. 
# Access to the post's content is achieved using :content 
