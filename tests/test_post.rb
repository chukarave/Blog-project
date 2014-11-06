require "test/unit"

require "blog"

class TestPost < Test::Unit::TestCase

  def test_post
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28), Date.new(2014, 10, 28))
    assert_equal("Foobar", p.title)
    assert_equal(2014, p.date.year)
    assert_equal(10, p.date.month)
    assert_equal(28, p.date.day)
    assert_equal(p.date, p.updated_on)

    p = Blog::Post.new("derp", "Derp", Date.new(2012, 2, 13), Date.new(2012, 2, 13))
    assert_equal("Derp", p.title)           # Use Post.title to get the posts's title
    assert_equal(2012, p.date.year)          # use Post title to get the post's date. The .year is a derivative of the Ruby Date class.
    assert_equal(2, p.date.month)
    assert_equal(13, p.date.day)
    assert_equal(p.date, p.updated_on)
  end

  def test_post_content
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28), Date.new(2014, 11, 28))
    assert_equal(nil , p.content); # p.content get content from the Post class with the title and Date as identifiers.
    p.content = "ABDCE"            # writes content into the post
    assert_equal("ABDCE", p.content);      # reads the previously written content

  end

end
