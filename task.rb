
class Task < Post
  def initialize
    super

    @die_date = Time.now
  end

  def read_from_console
  end

  def to_strings
  end
end