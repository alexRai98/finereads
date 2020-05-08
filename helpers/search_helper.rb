module SearchHelper
  def mark_my_books(books, my_books)
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

  def render_books_in_search_page(books)
    if books.nil?
      erb("_empty_search_result".to_sym)
    else
      erb("_search_result".to_sym, locals: {books: books})
    end
  end
end