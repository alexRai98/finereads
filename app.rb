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
  @specific = process_param(params[:specific], avaliable_options: @specific_options.keys)
  
  @more = process_param(params[:more], avaliable_options: ["true", "false"]){ |more_option| more_option == "true"}
  count = @more ? 48 : 8

  my_books = Book.all
<<<<<<< HEAD
  @books = process_param(query) {|query_option| mark_my_books(get_books(query_option, count: count), my_books)}

  erb :search, locals: {books: @books, query: query, more: more}
=======
  @query = params[:query]
  @books = process_param(@query) do |query_option| 
    mark_my_books(get_books(query_option, count: count, specific: @specific), my_books)
  end
  erb :search
>>>>>>> 40abd1a0a57d6d23e3ede32d14211ca21d4dcc24
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
  redirect url("/books/#{id}/edit")
<<<<<<< HEAD
end
post "/books/add_detail" do
  id = params[:id]
  status = params[:status]
  Book.create(id: params[:id], status: status)
  redirect url("/books")
=======
>>>>>>> 40abd1a0a57d6d23e3ede32d14211ca21d4dcc24
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
    erb :book_detail, locals: { book: book, find: true}
  else
    book = Book.new(id: params[:id],status: nil)
    erb :book_detail, locals: {book: book,find: false}
  end
end


