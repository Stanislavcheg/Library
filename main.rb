require './models/library.rb'

library = Library.new
library.read_from_file('data.yaml')

puts '-----------------------------'
puts 'Often takes the book:'
puts library.often_takes_the_book
puts '-----------------------------'
puts 'The most popular book:'
puts library.the_most_popular_book
puts '-----------------------------'
puts 'How many people ordered one of the three most popular books'
puts library.people_ordered_3_most_popular_books
puts '-----------------------------'

library.save_to_file('new_data.yaml')
