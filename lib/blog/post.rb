module Blog

  class Post
    attr_reader :title, :date
    attr_accessor :content

    def initialize(title, date) 
      @title = title
      @date = date
      @content = content
    end

  end

end
