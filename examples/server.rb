require 'json_rpc_ruby'

class ExampleServer < JsonRpcRuby::Server
  def add(value_1, value_2)
    value_1 + value_2
  end

  def faulty_method
    raise StandardError, "Oops! Something went wrong!"
  end
end

JsonRpcRuby::Server.serve(:port => 80)