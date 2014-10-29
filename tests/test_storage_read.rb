require "test/unit"

require "blog"

class TestPost < Test::Unit::TestCase

  def setup
    base_dir = File.join(File.dirname(__FILE__), ["..", "/resources/test_data"])
    @storage = Blog::Storage.new(base_dir)
  end

  def test_all_posts
    posts = @storage.get_all_posts()

    assert_kind_of(Array, posts)
    assert_equal(3, posts.length)
    assert_kind_of(Blog::Post, posts[0])
    assert_kind_of(Blog::Post, posts[1])
    assert_kind_of(Blog::Post, posts[2])
  end

end

