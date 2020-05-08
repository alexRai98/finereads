require 'lazyrecord'
require_relative '../models/book'

Book.all.map{|book| Book.delete(book.id)}

Book.create(id: '5W6cnfQegYcC', status: 'read')
Book.create(id: 'ntA5AlD3p4AC', status: 'read')
Book.create(id: 'BvqcDwAAQBAJ', status: 'read')
Book.create(id: 'JFdMAQAAIAAJ', status: 'read')
