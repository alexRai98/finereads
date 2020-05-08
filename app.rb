# myapp.rb
require "json"
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/book"
require_relative "helpers/api_helper"
require_relative "helpers/edit_helper"
require_relative "helpers/search_helper"
require_relative "helpers/book_helper"

helpers ApiHelper
helpers SearchHelper
helpers BookHelper

use Rack::MethodOverride
get "/" do
  erb :index, :layout => false
end

get "/search" do #recibe el get request con query parameters - form
  query = params[:query]
  books = (query.nil? || query=="") ? nil : get_books(query)
  erb :search, locals: {books: books, query: query}
end

get "/books" do
  books = Book.all
  erb :books, locals: { books: books }
end

delete "/books/:book_id" do
  id = params[:book_id]
  Book.delete(id)
  redirect to("/books")
end

post "/books" do
  id = params[:id]
  status = params[:status]
  Book.create(id: params[:id], status: status)
  redirect url("/books/#{id}")
end


get "/books/:book_id/edit" do
  id = params[:book_id]
  book = Book.find(id)
  erb :book_edit, locals: { book: book }
end

put "/books/:book_id/edit" do
  id = params[:book_id]
  book = Book.find(id)
  book.status = params[:status]
  book.notes = params[:notes]
  book.save
  redirect to("/books")
end


get "/books/:id" do 
  @book = Book.find(params[:id])
  erb :book_detail, locals: { book: @book}
end

delete "/books/:id" do 
  @book = Book.delete(params[:id])
  redirect url("/books")
end
