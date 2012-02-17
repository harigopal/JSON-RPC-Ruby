BASEPATH = File.dirname(File.expand_path(__FILE__))
require "#{BASEPATH}/../lib/json_rpc_ruby"

class Calculator
  def add(value_1, value_2)
    value_1 + value_2
  end
end

run JsonRpc::RackApplication.new(Calculator.new)