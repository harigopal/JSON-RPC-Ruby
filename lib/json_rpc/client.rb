require_relative 'version'

class JsonRpc::Client
  def initialize(server_url, options_hash={})
    @server_url = server_url
  end

  def method_missing(method_name, *arguments)
    request_parameters = {
      "json_rpc" => "2.0",
      "id" => random_id,
      "method" => method_name.to_s
    }

    unless arguments.empty?
      request_parameters.merge!({
        "params" => arguments
      })
    end

    uri = URI @server_url
    req = Net::HTTP::Post.new(uri.path)
    req.body = request_parameters.to_json
    p req.body
    req.content_type = "application/json"

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    p response.body
  end

  # Generates a random 10-digit alphanumeric string.
  def random_id
    elements = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map {|i| i.to_a}.flatten
    (0..9).map { elements[rand(elements.length)] }.join
  end
end