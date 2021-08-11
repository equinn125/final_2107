class Attendee
  attr_reader :name, :budget
  def initialize(data)
    @name = data[:name]
    @budget = data[:budget].delete("$").to_i
  end
end
