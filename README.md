# Finereads

The finest personal book library in the web

## Resources

- [Designs](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=0%3A1)
- [Stories](./stories.md)

## Limitations

Any library is valid except for an API wrapper of the google books API. But you can build your own 😉

## Models

We just have one model called Book, that inherits from LazyRecord. This Book has the following properties:

- id: Retrieved from Google API. Only readable
- status: It only can be "want to read", "reading" or "read"
- notes: Textarea input the user types in
- date: Time when it was created. Only readable
- external_book: The resource from Google API

And the following methods:

- img_url: Thumbnail URL (String) retrieved from external_book
- title: String retrieved from external_book
- authors: Array retrieved from external_book
- description: String retrieved from external_book

Our routes:

- GET /
- GET /search
- GET /books
- GET /book/:book_id
- GET /book/:book_id/edit
- PUT /book/:book_id/edit
