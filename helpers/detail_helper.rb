module DetailHelper
    def refactor_detail_figcaption(book)
        erb(:_detail_figcaption,  locals: {book: book})
    end
    def refactor_detail_btn_add_list(book)
        erb(:_buttons_detail_add_list,  locals: {book: book})
    end
end