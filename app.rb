# myapp.rb
require "json"
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/book"
require_relative "helpers/api_helper"
require_relative "helpers/edit_helper"
require_relative "helpers/search_helper"

helpers ApiHelper
helpers BookHelper
helpers SearchHelper

use Rack::MethodOverride
get "/" do
  erb :index, :layout => false
end

get "/search" do #recibe el get request con query parameters - form
  p query = params[:query]
  books = (query.nil? || query=="") ? nil : get_books(query)
  erb :search, locals: {books: books}
end

get "/books" do
  books = Book.all
  erb :books, locals: { books: books }
end

get "/books/:book_id" do
  ""
end

get "/books/:book_id/edit" do
  book = Book.find(params[:book_id])
  erb :book_edit, locals: { book: book }
end

put "/books/:book_id/edit" do
  id = params[:book_id]
  book = Book.find(id)
  book.status = params[:status]
  book.notes = params[:notes]
  book.save
  redirect to("/books/#{id}/edit")
end

post "/books/:id" do 
  @book = Book.find(params[:id])
  erb :book_detail
end
delete "/books/:id" do 
  @book = Book.delete(params[:id])
  redirect url("/")
end
