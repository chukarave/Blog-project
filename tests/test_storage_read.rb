require "test/unit"

require "blog"

class TestStorageRead < Test::Unit::TestCase

  def setup
    base_dir = File.join(File.dirname(__FILE__), ["..", "/resources/test_data"])
    @storage = Blog::Storage.new(base_dir)
  end

  def test_all_posts
    posts = @storage.get_all_posts()

    assert_kind_of(Array, posts)            # asserts that posts is an array
    assert_equal(3, posts.length)           # asserts that the base directory contains 3 posts
    assert_kind_of(Blog::Post, posts[0])    # using the Post class, asserts that each of the posts is actually a post.
    assert_kind_of(Blog::Post, posts[1])
    assert_kind_of(Blog::Post, posts[2])
  end

  def test_get_post_by_id
    p1 = @storage.get_post_by_id("fringilla-ipsum")
    assert_equal("Fringilla Ipsum", p1.title)

    p2 = @storage.get_post_by_id("purus-ornare")
    assert_equal("Purus Ornare", p2.title)
  end
end

