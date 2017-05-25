# Book entity
class Book
  attr_accessor :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "book #{title}, #{author}"
  end
end
