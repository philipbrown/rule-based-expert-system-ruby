class Database < Hash
  # Check to see if the array of keys
  # are all present in the database
  def matches(keys)
    keys.all? { |k| key? k }
  end
end
