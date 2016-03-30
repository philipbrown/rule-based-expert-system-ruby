require "./database"
require "./antecedent"
require "./consequent"
require "./rule"
require "./engine"

rules = [
  # Rule 1
  Rule.new(1, [
    Antecedent.new(:environment, :papers),
    Antecedent.new(:environment, :manuals),
    Antecedent.new(:environment, :documents),
    Antecedent.new(:environment, :textbooks),
  ],
  ->(d, a) do
    d[:environment] == a[0].value or
    d[:environment] == a[1].value or
    d[:environment] == a[2].value or
    d[:environment] == a[3].value
  end,
    Consequent.new(:situation, :verbal)
  ),
  # Rule 2
  Rule.new(2, [
    Antecedent.new(:environment, :pictures),
    Antecedent.new(:environment, :illustrations),
    Antecedent.new(:environment, :photographs),
    Antecedent.new(:environment, :diagrams),
  ],
  ->(d, a) do
    d[:environment] == a[0].value or
    d[:environment] == a[1].value or
    d[:environment] == a[2].value or
    d[:environment] == a[3].value
  end,
    Consequent.new(:situation, :visual)
  ),
  # Rule 3
  Rule.new(3, [
    Antecedent.new(:environment, :machines),
    Antecedent.new(:environment, :buildings),
    Antecedent.new(:environment, :tools)
  ],
  ->(d, a) do
    d[:environment] == a[0].value or
    d[:environment] == a[1].value or
    d[:environment] == a[2].value
  end,
    Consequent.new(:situation, :"physical object")
  ),
  # Rule 4
  Rule.new(4, [
    Antecedent.new(:environment, :numbers),
    Antecedent.new(:environment, :formulas),
    Antecedent.new(:environment, :"computer_programs")
  ],
  ->(d, a) do
    d[:environment] == a[0].value or
    d[:environment] == a[1].value or
    d[:environment] == a[2].value
  end,
    Consequent.new(:situation, :symbolic)
  ),
  # Rule 5
  Rule.new(5, [
    Antecedent.new(:job, :lecturing),
    Antecedent.new(:job, :advising),
    Antecedent.new(:job, :counselling),
  ],
  ->(d, a) do
    d[:job] == a[0].value or
    d[:job] == a[1].value or
    d[:job] == a[2].value
  end,
    Consequent.new(:response, :oral)
  ),
  # Rule 6
  Rule.new(6, [
    Antecedent.new(:job, :building),
    Antecedent.new(:job, :repairing),
    Antecedent.new(:job, :troubleshooting),
  ],
  ->(d, a) do
    d[:job] == a[0].value or
    d[:job] == a[1].value or
    d[:job] == a[2].value
  end,
    Consequent.new(:response, :"hands-on")
  ),
  # Rules 7
  Rule.new(7, [
    Antecedent.new(:job, :writing),
    Antecedent.new(:job, :typing),
    Antecedent.new(:job, :drawing),
  ],
  ->(d, a) do
    d[:job] == a[0].value or
    d[:job] == a[1].value or
    d[:job] == a[2].value
  end,
    Consequent.new(:response, :documented)
  ),
  # Rules 8
  Rule.new(8, [
    Antecedent.new(:job, :evaluating),
    Antecedent.new(:job, :reasoning),
    Antecedent.new(:job, :investigating),
  ],
  ->(d, a) do
    d[:job] == a[0].value or
    d[:job] == a[1].value or
    d[:job] == a[2].value
  end,
    Consequent.new(:response, :analytical)
  ),
  # Rule 9
  Rule.new(9, [
    Antecedent.new(:situation, :"physical object"),
    Antecedent.new(:response, :"hands-on"),
    Antecedent.new(:feedback, :required),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :workshop)
  ),
  # Rule 10
  Rule.new(10, [
    Antecedent.new(:situation, :symbolic),
    Antecedent.new(:response, :analytical),
    Antecedent.new(:feedback, :required),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :"lecture - tutorial")
  ),
  # Rule 11
  Rule.new(11, [
    Antecedent.new(:situation, :visual),
    Antecedent.new(:response, :documented),
    Antecedent.new(:feedback, :"not required"),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :videocassette)
  ),
  # Rule 12
  Rule.new(12, [
    Antecedent.new(:situation, :visual),
    Antecedent.new(:response, :oral),
    Antecedent.new(:feedback, :required),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :"lecture - tutorial")
  ),
  # Rule 13
  Rule.new(13, [
    Antecedent.new(:situation, :verbal),
    Antecedent.new(:response, :analytical),
    Antecedent.new(:feedback, :required),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :"lecture - tutorial")
  ),
  # Rule 14
  Rule.new(14, [
    Antecedent.new(:situation, :verbal),
    Antecedent.new(:response, :oral),
    Antecedent.new(:feedback, :required),
  ],
  ->(d, a) do
    d[:situation] == a[0].value and
    d[:response] == a[1].value and
    d[:feedback] == a[2].value
  end,
    Consequent.new(:medium, :"role-play excercises")
  )
]

engine = Engine.new(Database.new, rules)
engine.backward(:medium, :workshop)

puts engine.steps
