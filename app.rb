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
  #specific = process_param(params[:specific], avaliable_options: ["all", "intitle", "inauthor"])
  more = process_param(params[:more], avaliable_options: ["true", "false"]){ |more_option| more_option == "true"}
  count = more ? 48 : 8

  my_books = Book.all
  books = process_param(query) {|query_option| mark_my_books(get_books(query_option, count: count), my_books)}

  erb :search, locals: {books: books, query: query, more: more}
end

get "/books" do
  books = Books.all
  erb(:books, locals: { books: books })
end

post "/books" do
  id = params[:id]
  status = params[:status]
  Book.create(id: params[:id], status: status)
  redirect url("/books/#{id}")
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
