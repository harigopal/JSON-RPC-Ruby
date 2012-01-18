require 'json_rpc_ruby'

API = JsonRpcRuby::Client.connect(:host => 'localhost', :port => 80)

p API.add(1,2)

begin
  API.faulty_method
rescue StandardError
  puts "Captured StandardError from API's faulty method."
end