# myapp.rb
require "json"
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/book"
require_relative "helpers/api_helper"
require_relative "helpers/search_helper"
require_relative "helpers/book_helper"
require_relative "helpers/detail_helper"

helpers ApiHelper
helpers SearchHelper
helpers BookHelper
helpers DetailHelper

use Rack::MethodOverride
get "/" do
  erb :index, :layout => false
end

get "/search" do #recibe el get request con query parameters - form
  @specific_options = {"all" => "All", "subject" => "In subject", "intitle" => "In Title", "inauthor" => "In Author", "inpublisher" => "In Publisher", "isbn" => "Is ISBN"}
  @specific = process_param(params[:specific], avaliable_options: @specific_options.keys, default: "all")

  @more = process_param(params[:more], avaliable_options: ["true", "false"]){ |more_option| more_option == "true"}
  count = @more ? 48 : 8

  @sort_options = ["relevance", "newest"]
  @sort = process_param(params[:sort], avaliable_options: @sort_options, default: "relevance")

  my_books = Book.all
  @query = params[:query]
  @books = process_param(@query) do |query_option| 
    mark_my_books(get_books(query_option, count: count, specific: @specific, sort: @sort), my_books)
  end

  erb :search
end

get "/books" do
  filter = params[:filter] ? params[:filter] : "all"
  selected = {}
  selected[filter] = "selected"
  books = Book.all

  if filter == "want to read" || filter == "reading" || filter == "read"
    books = books.select { |book| book.status == filter }
  end

  erb :books, locals: { books: books, selected: selected }
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
  redirect url("/books/#{id}/edit")
end

post "/books/add_detail" do
  id = params[:id]
  status = params[:status]
  Book.create(id: params[:id], status: status)
  redirect url("/books")
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
  book = Book.find(params[:id])
  if book
    erb :book_detail, locals: { book: book, find: true }
  else
    book = Book.new(id: params[:id], status: nil)
    erb :book_detail, locals: { book: book, find: false }
  end
end
