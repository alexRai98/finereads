require "http"
require "json"

module ApiHelper
  extend self

  BASE_URL = "https://www.googleapis.com/books/v1"
  BOOK_PER_PAGES = 40 #Max 40

  def get_books(text, count: 8)
    result = (count/BOOK_PER_PAGES.to_f)
      .ceil
      .times
      .inject([[], count]) do |(resp, remaining), index|
        num_books = (remaining <= BOOK_PER_PAGES ? remaining : BOOK_PER_PAGES)
        
        response = JSON.parse(
          HTTP.headers(:accept => "application/json")
            .get("#{BASE_URL}/volumes", :params => {:q => text, :startIndex => index, :maxResults => num_books})
            .body
        )

        [resp + response["items"], remaining - num_books]
      end

    result[0]
  end
end
