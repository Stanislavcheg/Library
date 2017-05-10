require_relative "book"
require_relative "order"
require_relative "reader"
require_relative "author"

require "yaml"


class Library
  attr_reader :books, :orders, :readers, :authors

  def initialize(file = "data.yaml")
    data = read_from_file(file)
    unless data
      @books = []
      @orders = []
      @readers = []
      @authors = []
    end
  end

  def read_from_file(file)
    data = YAML.load_file(file)
    @books = data[:books]
    @orders = data[:orders]
    @readers = data[:readers]
    @authors = data[:authors]
    data
  end

  def save_to_file(file)
    output = File.new(file, "w")
    data = {:books => books, :orders => orders, :readers => readers, :authors => authors}
    output.puts(YAML.dump(data))
    output.close
  end

  def often_takes_the_book
    readers_rating = sort_by_rating{|order| order.reader.name}
    reads_the_most = readers_rating[0][0]
    readers.find{|reader| reader.name == reads_the_most}
  end

  def the_most_popular_book
    books_rating = sort_by_rating{|order| order.book.title}
    the_most_popular_book = books_rating[0][0]
    books.find{|book| book.title == the_most_popular_book}
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    books_rating = sort_by_rating{|order| order.book.title}
    three_most_popular_books = books_rating.first(3).map { |elem| elem[0] }
    people_list = orders.find_all{|order| three_most_popular_books.include?(order.book.title) }
    people_list = people_list.map{|order| order.reader}
    people_list.uniq
  end

  private
  def sort_by_rating
  	rating = Hash.new(0)
  	orders.each do|order| 
  	  condition = yield(order)
  	  rating[condition] += 1
    end
    rating.sort_by{|k,v| -v}
  end

end