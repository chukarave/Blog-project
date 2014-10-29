require "test/unit"

require "blog"

class TestPost < Test::Unit::TestCase

  def test_post
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28))
    assert_equal("Foobar", p.title)
    assert_equal(2014, p.date.year)
    assert_equal(10, p.date.month)
    assert_equal(28, p.date.day)

    p = Blog::Post.new("derp", "Derp", Date.new(2012, 2, 13))
    assert_equal("Derp", p.title)
    assert_equal(2012, p.date.year)
    assert_equal(2, p.date.month)
    assert_equal(13, p.date.day)
  end

  def test_post_content
    p = Blog::Post.new("foobar", "Foobar", Date.new(2014, 10, 28))
    assert_equal(nil , p.content);
    p.content = "ABDCE"
    assert_equal("ABDCE", p.content);
  end

end

