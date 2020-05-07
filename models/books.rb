require "lazyrecord"

class Books < LazyRecord
  attr_reader :id
  attr_accessor :status, :notes

  def initialize(id:, status:, notes: "")
    @id = id
    @status = status
    @notes = notes
  end

end