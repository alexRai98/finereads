# myapp.rb
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/books"
require_relative "helpers/api_helper"
require "json"

helpers ApiHelper

get "/" do
  erb :index, :layout => false
end

get "/search" do #recibe el get request con query parameters - form
  content_type 'application/json'
  JSON.generate(get_books("elixir"))
end

get "/books" do
  erb(:books)
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