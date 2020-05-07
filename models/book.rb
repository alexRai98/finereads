require "lazyrecord"
require "http"

class Book < LazyRecord
  @@endpoint = "https://www.googleapis.com/books/v1/volumes"
  attr_reader :id, :date
  attr_accessor :status, :notes

  def initialize(id:, status:, notes: "")
    @id = id
    @status = status
    @notes = notes
    @date = Time.now
  end

  def external_book
    HTTP.headers(accept: "application/json").get("#{@@endpoint}/#{id}").parse
  end

  def img_url
    external_book['volumeInfo']['imageLinks']['thumbnail']
  end

  def title
    external_book['volumeInfo']['title']
  end

  def authors
    external_book['volumeInfo']['authors']
  end
end
