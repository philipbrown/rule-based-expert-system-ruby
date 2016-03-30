class Antecedent
  attr_reader :object
  attr_reader :value

  def initialize(object, value)
    @object = object
    @value  = value
  end
end
