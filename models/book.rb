require "lazyrecord"

class Book < LazyRecord
  attr_reader :id
  attr_accessor :status, :notes

  def initialize(id:, status:, notes: "")
    @id = id
    @status = status
    @notes = notes
    @date = Time.now
  end
end
