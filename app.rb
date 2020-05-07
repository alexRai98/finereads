# myapp.rb
require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/books"
require_relative "helpers/api_helper"

helpers ApiHelper

get "/" do
  'Hello world!'
end

get "/search" do #recibe el get request con query parameters - form
  "search"
end

get "/books" do
  ""
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
