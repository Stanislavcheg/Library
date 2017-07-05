require_relative 'book'
require_relative 'order'
require_relative 'reader'
require_relative 'author'
require 'yaml'

# Manage book orders
class Library
  attr_reader :books, :orders, :readers, :authors

  def initialize(books: [], orders: [], readers: [], authors: []) end

  def read_from_file(file)
    data = YAML.load_file(file)
    @books = data[:books]
    @orders = data[:orders]
    @readers = data[:readers]
    @authors = data[:authors]
    data
  end

  def save_to_file(file)
    output = File.new(file, 'w')
    data = { books: books, orders: orders, readers: readers, authors: authors }
    output.puts(YAML.dump(data))
    output.close
  end

  def often_takes_the_book
    most_popular(&:reader)
  end

  def the_most_popular_book
    most_popular(&:book)
  end

  def people_ordered_3_most_popular_books
    three_most_popular_books = most_popular(3, &:book)
    people_list = orders.find_all { |order| three_most_popular_books.include?(order.book) }
    people_list = people_list.map(&:reader)
    people_list.uniq
  end

  private

  def most_popular(number = 1)
    grouped_orders = orders.group_by { |order| yield(order) }
    rating = grouped_orders.sort_by { |_condition, orders| -orders.length }
    rating.first(number).map { |condition, _orders| condition }
  end
end
