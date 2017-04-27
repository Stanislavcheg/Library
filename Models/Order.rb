class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date = Time.new)
    @book = book
    @reader = reader
    @date = date
    @id = Time.new.to_i
  end

  def to_s
    "Order: #{@book}, #{@reader}, #{@date}"
  end
  
  def hash
     @id
  end
end