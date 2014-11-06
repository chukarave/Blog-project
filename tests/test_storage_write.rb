require "test/unit"
require "yaml"
require "blog"

class TestStorageWrite < Test::Unit::TestCase

  def setup
    @base_dir = File.join("/", ["tmp", "blog-test-data"])
    @storage = Blog::Storage.new(@base_dir)
  end

  def test_store_post()

    # make a few blog posts
    p1 = Blog::Post.new("lorem-ipsum", "Lorem Ipsum", Date.new(2014, 8, 17), Date.new(2014, 8, 17))
    p1.content = "Lorem Ipsum\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit."

    p2 = Blog::Post.new("fringilla-sit", "Fringilla Sit", Date.new(2012, 9, 2), Date.new(2012, 9, 2))
    p2.content = "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."

    p3 = Blog::Post.new("parturient-ultricies", "Parturient Ultricies", Date.new(2013, 2, 11), Date.new(2013, 2, 11))
    p3.content = "Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."

    # store the blog posts
    @storage.save(p1)
    @storage.save(p2)
    @storage.save(p3)

    # test the contents of the YAML file
    yaml_path = File.join(@base_dir, ["posts.yml"])
    File.open(yaml_path, "r") do |f|
      posts = YAML.load(f.read)
      assert_equal(3, posts.length);
      assert_equal("Lorem Ipsum", posts[0]["title"])
      assert_equal("Fringilla Sit", posts[1]["title"])
      assert_equal("Parturient Ultricies", posts[2]["title"])
    end

    # test, if the mardwon files exist
    assert_equal(true, File.exists?(
      File.join(@base_dir, ["2014", "08", "17", "lorem-ipsum.md"])
    ))

    assert_equal(true, File.exists?(
      File.join(@base_dir, ["2012", "09", "02", "fringilla-sit.md"])
    ))

    assert_equal(true, File.exists?(
      File.join(@base_dir, ["2013", "02", "11", "parturient-ultricies.md"])
    ))
  end
end

