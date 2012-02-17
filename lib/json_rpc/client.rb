require_relative 'version'

class JsonRpc::Client
  def initialize(server_url, options_hash={})
    @server_url = server_url
  end

  def method_missing(method_name, *arguments)
    Net::HTTP.post_form(@server_url, {'json_rpc' => "2.0", "method" => method_name.to_s, "id" => "a1b2c3"})
  end
end