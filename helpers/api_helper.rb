require "dotenv/load"
require "http"
require "json"

module ApiHelper
  extend self

  BASE_URL = "https://www.googleapis.com/books/v1"
  BOOK_PER_PAGES = 25 #Max 40

  def get_books(text)
    response1 = JSON.parse(
      HTTP.headers(:accept => "application/json")
        .get("#{BASE_URL}/volumes", :params => {:q => text, :startIndex => "0", :maxResults => BOOK_PER_PAGES})
        .body
    )
    response2 = JSON.parse(
      HTTP.headers(:accept => "application/json")
        .get("#{BASE_URL}/volumes", :params => {:q => text, :startIndex => "1", :maxResults => BOOK_PER_PAGES})
        .body
    )
    (response1["items"] + response2["items"])
      .take(48)
  end
end