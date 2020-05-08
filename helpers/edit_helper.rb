module EditHelper
    def show_select(book_status)
        status = {}
        status[book_status] = "selected"
        erb :_edit_page_select, locals: { status: status }
    end
end