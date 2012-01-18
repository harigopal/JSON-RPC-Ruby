# Use the supplied rack-up file to start the server.

class ExampleService
  def add(value_1, value_2)
    value_1 + value_2
  end

  def faulty_method
    raise StandardError, "Oops! Something went wrong!"
  end
end