require "lazyrecord"
require "http"
require_relative "../helpers/api_helper"

class Book < LazyRecord
  attr_reader :id, :date
  attr_accessor :status, :notes

  def initialize(id:, status:, notes: "")
    @id = id
    @status = status
    @notes = notes
    @date = Time.now
    @external_book = ApiHelper.get_book_by_id(id)
  end

  def img_url
    @external_book['volumeInfo']['imageLinks']['thumbnail']
  end

  def title
    @external_book['volumeInfo']['title']
  end

  def authors
    @external_book['volumeInfo']['authors']
  end
end
