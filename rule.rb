class Rule
  attr_reader :id
  attr_reader :antecedents
  attr_reader :evaluation
  attr_reader :consequent
  attr_reader :passed

  def initialize(id, antecedents, evaluation, consequent)
    @id          = id
    @antecedents = antecedents
    @evaluation  = evaluation
    @consequent  = consequent
    @passed      = false
  end

  # Run the equluation on the database. If the evuluation is
  # satisfied, update the database with the consequent and return `true`
  def run(database)
    if @evaluation.call(database, @antecedents)
      database[@consequent.object] = @consequent.value
      @passed = true
    end
  end

  # Check if this rule has the correct antecedent
  def has_antecedent(object, value)
    @antecedents.any? do |a|
      a.object == object and a.value == value
    end
  end

  # Check if this rule has the desired solution
  def has_desired_solution(object, value)
    @consequent.object == object and @consequent.value == value
  end
end
