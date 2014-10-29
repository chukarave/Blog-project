require "test/unit"

require "blog"

class TestPost < Test::Unit::TestCase

  def test_post

    p = Blog::Post.new("Foobar", Date.new(2014, 10, 28))
    assert_equal("Foobar", p.title)
    assert_equal(2014, p.date.year)
    assert_equal(10, p.date.month)
    assert_equal(28, p.date.day)
  end

end

