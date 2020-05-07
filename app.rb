# myapp.rb
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/book"
require_relative "helpers/api_helper"
require_relative "helpers/search_helper"
require "json"

helpers ApiHelper
helpers SearchHelper

get "/" do
  erb :index, :layout => false
end

get "/search" do #recibe el get request con query parameters - form
  query = params[:query]
  books = query.nil? || query="" ? nil : get_books(query)
  erb :search, locals: {books: books}
end

get "/books" do
  books = Books.all
  erb(:books, locals: { books: books })
end

get "/books/:book_id" do
  ""
end

get "/books/:book_id/edit" do
  ""
end

put "/books/:book_id/edit" do
  ""
end
