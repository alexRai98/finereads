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
    authors = @external_book['volumeInfo']['authors']
  end

  def description
    @external_book['volumeInfo']['description'].to_s.gsub(/<\/?\w+>/,"")
  end
  
  def price
    sale_info =@external_book['saleInfo']
    if sale_info["saleability"] == "FOR_SALE"
      currency =sale_info["listPrice"]["currencyCode"]
      value = sale_info["listPrice"]["amount"]
      "#{currency} #{value}"
    else
      nil
    end
  end

  def price_buy_link
    @external_book['saleInfo']["buyLink"]
  end

end
