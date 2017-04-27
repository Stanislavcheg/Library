require "./Models/Library.rb"

library = Library.new()

puts "-----------------------------"
puts library.often_takes_the_book
puts "-----------------------------"
puts library.the_most_popular_book
puts "-----------------------------"
puts library.how_many_people_ordered_one_of_the_three_most_popular_books
puts "-----------------------------"

library.save_to_file("new_data.yaml")
