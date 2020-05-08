module BookHelper
    def book_delete(book)
        "/books/#{book.id}"
    end
end