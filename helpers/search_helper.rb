module SearchHelper

  def url_with_updated_params(url, params:, updating:)
    updating.each{|(k, v)| params[k] = v}
    query = params.map{|k, v| "#{k}=#{v.gsub(/\s/, '+')}"}.join("&")
    "#{url}?#{query}"
  end

  def process_param(param, avaliable_options: [])
    if param.nil? || param == "" || (avaliable_options != [] && !avaliable_options.include?(param))
      nil
    elsif block_given?
      yield(param)
    else
      param
    end
  end

  def mark_my_books(books, my_books)
    return nil if books == []
    books.map do |book|
      my_book = my_books.find {|my_book| my_book.id == book["id"]}
      if my_book.nil?
        book["my_book_status"] = nil
      else
        book["my_book_status"] = my_book.status
      end
      book
    end
  end

  def render_books_in_search_page(books, more: false)
    if books.nil?
      erb("_empty_search_result".to_sym)
    else
      erb("_search_result".to_sym, locals: {books: books, more: more})
    end
  end
end