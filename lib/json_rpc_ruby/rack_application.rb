require_relative 'version'

class JsonRpcRuby::RackApplication
  def call(environment)
    [200, {"Content-Type" => "application/json"}, ["foo"]]
  end
end