require "http"
require "json"

module ApiHelper
  extend self

  BASE_URL = "https://www.googleapis.com/books/v1"
  BOOK_PER_PAGES = 40 #Max 40

  def get_books(text, count:, specific:)
    result = (count/BOOK_PER_PAGES.to_f)
      .ceil
      .times
      .inject([[], count]) do |(resp, remaining), index|
        num_books = (remaining <= BOOK_PER_PAGES ? remaining : BOOK_PER_PAGES)
        q = (specific == nil || specific == "all") ? text : "#{specific}:#{text}"
        response = JSON.parse(
          HTTP.headers(:accept => "application/json")
            .get("#{BASE_URL}/volumes", :params => {:q => q, :startIndex => index, :maxResults => num_books})
            .body
        )
        [resp + Array(response["items"]), remaining - num_books]
      end

    result[0]
  end

  def get_book_by_id(id)
    JSON.parse(
      HTTP.headers(:accept => "application/json")
        .get("#{BASE_URL}/volumes/#{id}")
        .body
    )
  end
end
