require "test/unit"

require "blog"

class TestPost < Test::Unit::TestCase

  def test_post
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28))
    assert_equal("Foobar", p.title)
    assert_equal(2014, p.date.year)
    assert_equal(10, p.date.month)
    assert_equal(28, p.date.day)

<<<<<<< HEAD
    p = Blog::Post.new("Derp", Date.new(2012, 2, 13))
    assert_equal("Derp", p.title)           # Use Post.title to get the posts's title
    assert_equal(2012, p.date.year)         # use Post title to get the post's date. The .year is a derivative of the Ruby Date class.
=======
    p = Blog::Post.new("derp", "Derp", Date.new(2012, 2, 13))
    assert_equal("Derp", p.title)
    assert_equal(2012, p.date.year)
>>>>>>> a41da3eb6ea2946d9b0a8067626ff1891162ab28
    assert_equal(2, p.date.month)
    assert_equal(13, p.date.day)
  end

  def test_post_content
<<<<<<< HEAD
    p = Blog::Post.new("Foobar", Date.new(2014, 10, 28))
    assert_equal(nil , p.content);  # p.content get content from the Post class with the title and Date as identifiers.
    p.content = "ABDCE"             # writes content into the post
    assert_equal("ABDCE", p.content);   # reads the previously written content
=======
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28))
    assert_equal(nil , p.content);
    p.content = "ABDCE"
    assert_equal("ABDCE", p.content);
>>>>>>> a41da3eb6ea2946d9b0a8067626ff1891162ab28
  end

end
