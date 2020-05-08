require 'lazyrecord'
require_relative '../models/book'

books = [
  Book.create(id: '5W6cnfQegYcC', status: 'read'),
  Book.create(id: 'ntA5AlD3p4AC', status: 'read'),
  Book.create(id: 'BvqcDwAAQBAJ', status: 'read'),
  Book.create(id: 'JFdMAQAAIAAJ', status: 'read'),
]

puts "----------"
books.each_with_index do |book, i|
  puts "BOOK #{i + 1}"
  puts "Title:"
  p book.title
  puts "Image:"
  p book.img_url
  puts "Authors:"
  p book.authors
  puts "Description:"
  p book.description
  puts "----------"
end
