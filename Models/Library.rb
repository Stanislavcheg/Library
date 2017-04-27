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
    readers_rating = Hash.new(0)
    orders.each{|order| readers_rating[order.reader.name] += 1 }
    reads_the_most = readers_rating.sort_by{|k,v| v}[-1][0]
    readers.find{|reader| reader.name == reads_the_most}
  end

  def the_most_popular_book
    books_rating = Hash.new(0)
    orders.each{|order| books_rating[order.book.title] += 1 }
    the_most_popular_book = books_rating.sort_by{|k,v| v}[-1][0]
    books.find{|book| book.title == the_most_popular_book}
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    books_rating = Hash.new(0)
    orders.each{|order| books_rating[order.book.title] += 1 }
    three_most_popular_books = books_rating.sort_by{|k,v| -v}
    three_most_popular_books = three_most_popular_books.first(3)
    three_most_popular_books = three_most_popular_books.map { |e| e[0] }
    people_list = orders.find_all{|order| three_most_popular_books.include?(order.book.title) }
    people_list = people_list.map{|order| order.reader}
    people_list.uniq
  end


end