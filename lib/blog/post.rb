module Blog
  class Post
    attr_reader :title, :date
    def initialize(title, date)
      @title = title
      @date = date
    end
  end
end
