module SearchHelper
  def render_books_in_search_page(books)
    if books.nil?
      erb("_empty_search_result".to_sym)
    else
      erb("_search_result".to_sym, locals: {books: books})
    end
  end
end