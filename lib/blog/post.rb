module Blog

  class Post
    
    def initialize(title, date) 
      @title = title
      @date = date
    end

    def title
      return @title
    end

    def date
      return @date.to_date
    end  

  end

end
