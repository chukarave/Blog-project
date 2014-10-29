module Blog

  class Post
    attr_reader :title, :date   # read existing data only
    attr_accessor :content      # read existing data or write new data

    def initialize(title, date) 
      @title = title
      @date = date
      @content = content
    end

  end

end

# Post receives title and date as arguments. it returns the corresponding title of a post and the date in which it was written. 
# Access to the post's content is achieved using :content 
