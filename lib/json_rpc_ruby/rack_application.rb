require_relative 'version'

class JsonRpcRuby::RackApplication
  def initialize(service_object)
    @service_object = service_object
  end

  def call(environment)
    request = Rack::Request.new(environment)
    params = JSON.load(request.POST)

    ["method", "params"].each do |required_parameter|
      unless params.include? required_parameter
        return [400, {"Content-Type" => "application/json"}, [{"result" => nil, "error" => "Invalid Request Parameters", "id" => params["id"]}.to_json]]
      end
    end

    begin
      result = @service_object.send(params["method"].to_sym, *params["params"])
    rescue => e
      [500, {"Content-Type" => "application/json"}, [{"result" => nil, "error" => {"class" => e.class, "message" => e.message, "backtrace" => e.backtrace}, "id" => params["id"]}.to_json]]
    else
      [200, {"Content-Type" => "application/json"}, [{"result" => result, "error" => nil, "id" => params["id"]}.to_json]]
    end
  end
end