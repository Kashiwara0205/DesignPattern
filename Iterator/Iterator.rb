class Article
  attr_reader :title
  def initialize(title)
    @title = title
  end
end

class Blog
  def initialize
    @articles = []
  end

  def get_article_at(index)
    @articles[index]
  end

  def add_article(article)
    @articles << article
  end

  def length
    @articles.length
  end

  def iterator
    # Blogオブジェクトからイテレータを生成
    BlogItarator.new(self)
  end
end

class BlogItarator
  def initialize(blog)
    @blog = blog
    @index = 0
  end

  def has_next?
    @index < @blog.length
  end

  def next_article
    # イレレータの動きとして終わりにnilやNoneを返すのは適切
    article = self.has_next? ? @blog.get_article_at(@index) : nil
    @index = @index + 1
    article
  end
end

blog = Blog.new
# @articles配列に追加
blog.add_article(Article.new("デザインパターン1"))
blog.add_article(Article.new("デザインパターン2"))
blog.add_article(Article.new("デザインパターン3"))
blog.add_article(Article.new("デザインパターン4"))

iterator = blog.iterator
while iterator.has_next?
    article = iterator.next_article
    puts article.title
end