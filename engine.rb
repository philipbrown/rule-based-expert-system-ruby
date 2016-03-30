class Engine
  attr_reader :database
  attr_reader :rules
  attr_reader :stack
  attr_reader :steps

  def initialize(database, rules)
    @database = database
    @rules    = rules
    @stack    = []
    @steps    = []
  end

  # Run Forward chaining by iterating over
  # the `rules` and running them in order
  def forward
    @rules.each do |rule|
      @steps.push("Running rule #{rule.id}")
      r.run(@database)
    end
  end

  # Run Backward chaining by setting a `goal`
  # and a desired value
  def backward(goal, value)
    rules = @rules.select { |r| r.has_desired_solution(goal, value) }

    if rules.count == 1
      rule = rules.first
    elsif rules.count > 1
      u_goal  = prompt("What is the next goal?")
      u_value = prompt("What is the next value?")

      rule = rules.select { |r| r.has_antecedent(u_goal, u_value) }.first
    end

    if rule.nil?
      @steps.push("Asking the user for the correct #{goal}")
      @database[goal] = prompt("What is the #{goal}?")

      @stack = @stack.reverse.reject! do |rule|
        if rule.has_antecedent(goal, value)
          @steps.push("Running rule #{rule.id}")
          rule.run(@database)
        end
      end

      return
    end

    if @database.matches(rule.antecedents.map { |a| a.object })
      @steps.push("Running rule #{rule.id}")
      return rule.run(@database)
    end

    @stack.push(rule)

    rule.antecedents.each do |a|
      unless rule.passed
        backward(a.object, a.value)
      end
    end
  end

  # Ask the user a question
  def prompt(question)
    print("#{question}\n")
    gets.chomp.to_sym
  end
end
